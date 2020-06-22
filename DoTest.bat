@echo off

REM ============================================================================
:DoTest
REM ===========
if "%$VERBOSE%" == "" set $VERBOSE=off
REM ===========
REM If the first parameter is "[--]" the exec individual test
REM ===========
if "%~1" == "[--]" (
  REM Execute individual test
  if /i "%~2" == "Simple-int" goto :test-%2
  if /i "%~2" == "Simple-str" goto :test-%2
  echo Invalid test type "%~2". Only Simple-int or Simple-str is allowed.
  goto :EOF
)

REM ===========
REM Parameters are described in :DoTest-usage
REM ===========
setLocal

REM Use local versions of utilities batch files
set $BIN_PATH=%~dp0

REM Store current directory
call %BatchLibrary%\GetPathPart.bat $TEST_PATH f .
set "$TEST_PATH=%$TEST_PATH%\"

REM Test will use Log.bat
set $LOG_FILE=%$TEST_PATH%test.log

REM Global counters
call :StoreReport 0 0

REM
REM Get options
set $VERBOSE=off
:DoTest-checkopt
  set $PARAM=%~1
  if "%$PARAM%" == "" goto :DoTest-list
  if not "%$PARAM:~0,1%" == "/" goto :DoTest-list
  if /i "%$PARAM%" == "/V" (
    set $VERBOSE=on
  )
  if "%$PARAM%" == "/?" (
    goto :DoTest-usage
  )
  shift
goto :DoTest-checkopt
REM
REM Run desired or all tests
:DoTest-list
if "%~1" == "" goto :DoTest-all

REM ===========
:DoTest-one-by-one
  call :DoTest-run %~1
  shift
if not "%~1" == "" goto :DoTest-one-by-one
goto :DoTest-report

REM ===========
:DoTest-all
REM Run all tests
for %%T in (*.bat) do (
  if exist test\test-%%T (
    call :DoTest-run %%T
  )
)
goto :DoTest-report

REM ===========
:DoTest-report
call %$BIN_PATH%Log.bat
call :RestoreReport
call %$BIN_PATH%Log.bat Tests passed: %$PASS%
call %$BIN_PATH%Log.bat Tests failed: %$FAIL%
call :ClearReport
endLocal
goto :EOF

REM ===========
:DoTest-usage
echo Runs all or selected batch tests
echo;
echo %~nx0 [/?] [/v] [testName ...]
echo;
echo 	/ ?		Display this info and exit.
echo 	/v		Verbose mode.
echo 	testName	Individual test name to be run instead of all tests.
echo;
endLocal
goto :EOF
REM ============================================================================


REM ============================================================================
:DoTest-run
REM ===========
setLocal
REM %1 - Test name
call %BatchLibrary%\GetPathPart.bat $NAME n %~1
REM set $NAME=%~1
REM ===========
call %$BIN_PATH%Log.bat
if not exist "%$TEST_PATH%test\test-%$NAME%.bat" (
  call %$BIN_PATH%Log.bat Test %$NAME% not found
  endLocal
  goto :EOF
)
call %BatchLibrary%\GetPathPart.bat $NAME n "%$TEST_PATH%test\test-%$NAME%.bat"
set $NAME=%$NAME:~5%
call %$BIN_PATH%Log.bat "##################################################"
call %$BIN_PATH%Log.bat Testing %$NAME%
call "%$TEST_PATH%test\test-%$NAME%.bat"
call %$BIN_PATH%Log.bat "##################################################"
endLocal
goto :EOF
REM ============================================================================


REM ============================================================================
:test-Simple-int
REM ===========
shift
shift
setLocal
REM %1 - test name
set $NAME=%~1
REM %2 - Subroutine to test
set $SUB=%~2
REM %3 - Expected output value (integer)
set $EXPECTED=%~3
REM %4 - Comparison method:
REM        - exact
REM        - 1-99 - percentage
set $CMP=%~4
REM %5 - First input value
set $INPUT1=%~5
REM %6 - Second input value
set $INPUT2=%~6
REM %7 - Third input value
set $INPUT3=%~7
REM ===========
call %$BIN_PATH%Log.bat "########################################"
call %$BIN_PATH%Log.bat Test: %$NAME%
call %TEST_PATH%%$SUB% "%$INPUT1%" "%$INPUT2%" "%$INPUT3%"
set $RESULT=%ERRORLEVEL%
call :test-Check-Result %$CMP%
endlocal & exit /b %ERRORLEVEL%
REM ============================================================================


REM ============================================================================
:test-Simple-str
REM ===========
shift
shift
setLocal
REM %1 - test name
set $NAME=%~1
REM %2 - Subroutine to test
set $SUB=%~2
REM %3 - Expected output value (string)
set $EXPECTED=%~3
REM %4 - Comparison method:
REM        - exact
REM        - 1-99 - percentage
set $CMP=%~4
REM %5 - First input value
set $INPUT1=%~5
REM %6 - Second input value
set $INPUT2=%~6
REM %7 - Third input value
set $INPUT3=%~7
REM ===========
call %$BIN_PATH%Log.bat "########################################"
call %$BIN_PATH%Log.bat Test: %$NAME%
call %TEST_PATH%%$SUB% $RESULT "%$INPUT1%" "%$INPUT2%" "%$INPUT3%"
call :test-Check-Result %$CMP%
endlocal & exit /b %ERRORLEVEL%
REM ============================================================================


REM ============================================================================
:test-Check-Result
REM ===========
setLocal
REM %1 - Comparison method:
REM        - exact
REM        - 1-99 - percentage
set $CMP=%~1
REM ===========
if not %$CMP% == exact goto :test-Check-Result-Perc
  if "%$RESULT%" == "%$EXPECTED%" (
    set $OK=1
  ) else (
    set $OK=0
  )
goto :test-Check-Result-exec
:test-Check-Result-Perc
  set /a "$DELTA=( %$EXPECTED% * %$CMP% ) / 100"
  set /a $LOW=%$EXPECTED% - %$DELTA%
  set /a $UPP=%$EXPECTED% + %$DELTA%
  if %$EXPECTED% lss %$LOW% (
    set $OK=0
  ) else (
    if %$EXPECTED% gtr %$UPP% (
      set $OK=0
    ) else (
      set $OK=1
    )
  )
  set $EXPECTED=%$LOW%..%$UPP%
:test-Check-Result-exec
if %$OK% == 1 (
  call %$BIN_PATH%Log.bat OK - Passed
  if %$VERBOSE% ==  on (
    call %$BIN_PATH%Log.bat Expected result:    [%$EXPECTED%]
    call %$BIN_PATH%Log.bat Received result:    [%$RESULT%]
    call %$BIN_PATH%Log.bat First input value:  [%$INPUT1%]
    if not "%$INPUT2%" == "" (
      call %$BIN_PATH%Log.bat Second input value: [%$INPUT2%]
    )
  )
  call :StoreReport +1 +0
  endlocal & exit /b 0
) else (
  call %$BIN_PATH%Log.bat FAIL:
  call %$BIN_PATH%Log.bat Expected result:    [%$EXPECTED%]
  call %$BIN_PATH%Log.bat Received result:    [%$RESULT%]
  call %$BIN_PATH%Log.bat First input value:  [%$INPUT1%]
  if not "%$INPUT2%" == "" (
    call %$BIN_PATH%Log.bat Second input value: [%$INPUT2%]
  )
  call :StoreReport +0 +1
  endlocal & exit /b 1
)
goto :EOF
REM ============================================================================


REM ============================================================================
:StoreReport
REM ===========
setLocal
REM EnableDelayedExpansion
REM %1 - Number of passes change: 0, +0, +1
set $P=%~1
REM %2 - Number of failes change: 0, +0, +1
set $F=%~2
REM ===========
call :RestoreReport
if %$P% == 0 set $PASS=0
if %$P% == +1 set /a $PASS+=1
if %$F% == 0 set $FAIL=0
if %$F% == +1 set /a $FAIL+=1
echo set $PASS=%$PASS% > %TEMP%\report.bat
echo set $FAIL=%$FAIL% >> %TEMP%\report.bat
endLocal
goto :EOF
REM ============================================================================


REM ============================================================================
:RestoreReport
REM ===========
if exist %TEMP%\report.bat goto :RestoreReport-do
set $PASS=0
set $FAIL=0
goto :EOF
:RestoreReport-do
call %TEMP%\report.bat
set $PASS=%$PASS%
set $FAIL=%$FAIL%
goto :EOF
REM ============================================================================


REM ============================================================================
:ClearReport
REM ===========
if exist %TEMP%\report.bat del %TEMP%\report.bat
goto :EOF
REM ============================================================================
