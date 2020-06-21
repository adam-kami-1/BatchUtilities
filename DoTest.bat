@echo off

REM ============================================================================
:DoTest
REM ===========
if "%$VERBOSE%" == "" set $VERBOSE=off
if "%~1" == "[--]" goto :test-%2
REM ===========
REM Parameters are described in :DoTest-usage
REM ===========
setLocal
REM Use local versions of tested batch files
set $BIN_PATH=%~dp0
cd /d %$BIN_PATH%
path %$BIN_PATH%;%PATH%
REM Test will use Log.bat
set $LOG_FILE=%$BIN_PATH%test.log
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
call Log.bat
call :RestoreReport
call Log.bat Tests passed: %$PASS%
call Log.bat Tests failed: %$FAIL%
endLocal
goto :EOF

REM ===========
:DoTest-usage
echo Runs all or selected batch tests
echo;
echo test-setup [/v] [testName ...]
echo;
echo 	/?		Display this info and exit.
echo 	/v		Verbose mode.
echo 	testName	Individual test name to be run instead of all tests.
echo;
endLocal
goto :EOF
REM ============================================================================


REM ============================================================================
:GetPathPart
REM ===========
setLocal
REM %1 - Result variable name
REM %2 - Path part code f ( d p n x ) a t z
REM %3 - Input path
REM ===========
set $RES=%~3
if "%~2" == "f" set $RES=%~f3
if "%~2" == "d" set $RES=%~d3
if "%~2" == "p" set $RES=%~p3
if "%~2" == "n" set $RES=%~n3
if "%~2" == "x" set $RES=%~x3
if "%~2" == "dp" set $RES=%~dp3
if "%~2" == "dpn" set $RES=%~dpn3
if "%~2" == "dpnx" set $RES=%~dpnx3
if "%~2" == "pn" set $RES=%~pn3
if "%~2" == "pnx" set $RES=%~pnx3
if "%~2" == "nx" set $RES=%~nx3
if "%~2" == "a" set $RES=%~a3
if "%~2" == "t" set $RES=%~t3
if "%~2" == "z" set $RES=%~z3
endLocal & set %1=%$RES%& exit /b
goto :EOF
REM ============================================================================


REM ============================================================================
:DoTest-run
REM ===========
setLocal
REM %1 - Test name
call :GetPathPart $NAME n %~1
REM set $NAME=%~1
REM ===========
call Log.bat
if not exist "%$BIN_PATH%test\test-%$NAME%.bat" (
  call Log.bat Test %$NAME% not found
  endLocal
  goto :EOF
)
call :GetPathPart $NAME n "%$BIN_PATH%test\test-%$NAME%.bat"
set $NAME=%$NAME:~5%
call Log.bat "##################################################"
call Log.bat Testing %$NAME%
call "%$BIN_PATH%test\test-%$NAME%.bat"
call Log.bat "##################################################"
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
call Log.bat "########################################"
call Log.bat Test: %$NAME%
call %$SUB% "%$INPUT1%" "%$INPUT2%" "%$INPUT3%"
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
call Log.bat "########################################"
call Log.bat Test: %$NAME%
call %$SUB% $RESULT "%$INPUT1%" "%$INPUT2%" "%$INPUT3%"
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
  call Log.bat OK - Passed
  if %$VERBOSE% ==  on (
    call Log.bat Expected result:    [%$EXPECTED%]
    call Log.bat Received result:    [%$RESULT%]
    call Log.bat First input value:  [%$INPUT1%]
    if not "%$INPUT2%" == "" (
      call Log.bat Second input value: [%$INPUT2%]
    )
  )
  call :StoreReport +1 +0
  endlocal & exit /b 0
) else (
  call Log.bat FAIL:
  call Log.bat Expected result:    [%$EXPECTED%]
  call Log.bat Received result:    [%$RESULT%]
  call Log.bat First input value:  [%$INPUT1%]
  if not "%$INPUT2%" == "" (
    call Log.bat Second input value: [%$INPUT2%]
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
echo set $PASS=%$PASS% > %$BIN_PATH%test\report.bat
echo set $FAIL=%$FAIL% >> %$BIN_PATH%test\report.bat
endLocal
goto :EOF
REM ============================================================================


REM ============================================================================
:RestoreReport
REM ===========
if exist %$BIN_PATH%test\report.bat goto :RestoreReport-do
set $PASS=0
set $FAIL=0
goto :EOF
:RestoreReport-do
call %$BIN_PATH%test\report.bat
set $PASS=%$PASS%
set $FAIL=%$FAIL%
goto :EOF
REM ============================================================================

