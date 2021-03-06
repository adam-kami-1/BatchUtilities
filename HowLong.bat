@echo off

REM ============================================================================
:HowLong
REM ===========
REM Run application or a script calculating real time used by it.
REM Number of hundredths of second returned in %ERRORLEVEL%
REM ===========
REM ===========
@echo off
setLocal
set $START=%TIME%
@echo on
call %*
@echo off
call %BatchLibrary%\TimeDiff %$START% %TIME%
set $RETVALUE=%errorlevel%
call %BatchLibrary%\FormatTime $DIFFERENCE %$RETVALUE%
echo;
echo The execution of '%*' took %$DIFFERENCE%
endLocal & exit /b %$RETVALUE%
REM ============================================================================
