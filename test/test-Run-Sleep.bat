REM ============================================================================
:test-Run-Sleep
REM ===========
setLocal
REM %1 - Time to wait in seconds (invalid parameter treated as 0)
set $SECONDS=%~1
REM ===========
set $START=%TIME%
call Sleep %$SECONDS%
call TimeDiff "%$START%" "%TIME%"
set /a "$RESULT=%ERRORLEVEL% / 100"
endLocal & exit /b %$RESULT%
REM ============================================================================



