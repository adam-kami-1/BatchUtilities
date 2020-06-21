REM ============================================================================
:test-Run-SelectFile
REM ===========
setLocal
REM %1 - Result variable name
REM %2 - Path containing files to select
set $PATH=%~2
REM %3 - File name mask
set $MASK=%~3
REM %4 - Sequence of characters to send one by one to Menu
set $SEQ=%~4
REM ===========
if exist %TMP%\test-Run-SelectFile del %TMP%\test-Run-SelectFile
:test-Run-SelectFile-Again
  set $C=%$SEQ:~0,1%
  set $SEQ=%$SEQ:~1%
  echo ^%$C%>> %TMP%\test-Run-SelectFile
if not "%$SEQ%" == "" goto :test-Run-SelectFile-Again
REM ===========
if %$VERBOSE% ==  on (
  call SelectFile $RETVAL "%$PATH%" "%$MASK%" <%TMP%\test-Run-SelectFile
) else (
  call SelectFile $RETVAL "%$PATH%" "%$MASK%" <%TMP%\test-Run-SelectFile >NUL
)
del %TMP%\test-Run-SelectFile
endLocal & set %~1=%$RETVAL%& exit /b
REM ============================================================================


