@echo off


REM ============================================================================
:Sleep
REM ===========
REM %1 - Time to wait in seconds (invalid parameter treated as 0)
REM ===========
setLocal
set /a $COUNT=1 + %1
ping -n %$COUNT% 127.0.0.1 > NUL
endLocal
goto :EOF
REM ============================================================================


