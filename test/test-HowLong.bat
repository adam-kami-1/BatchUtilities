@echo off
REM ============================================================================
:test-HowLong
REM ===========
call DoTest.bat [--] Simple-int "10 seconds" HowLong 1000 99 Sleep.bat 10
call DoTest.bat [--] Simple-int "60 seconds" HowLong 6000 99 Sleep.bat 60
goto :EOF
REM ============================================================================


