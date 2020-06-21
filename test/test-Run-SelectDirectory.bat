REM ============================================================================
:test-Run-SelectDirectory
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
if exist %TMP%\test-Run-SelectDirectory del %TMP%\test-Run-SelectDirectory
:test-Run-SelectDirectory-Again
  set $C=%$SEQ:~0,1%
  set $SEQ=%$SEQ:~1%
  echo ^%$C%>> %TMP%\test-Run-SelectDirectory
if not "%$SEQ%" == "" goto :test-Run-SelectDirectory-Again
REM ===========
if %$VERBOSE% ==  on (
  call SelectDirectory $RETVAL "%$PATH%" "%$MASK%" <%TMP%\test-Run-SelectDirectory
) else (
  call SelectDirectory $RETVAL "%$PATH%" "%$MASK%" <%TMP%\test-Run-SelectDirectory >NUL
)
del %TMP%\test-Run-SelectDirectory
endLocal & set %~1=%$RETVAL%& exit /b
REM ============================================================================


