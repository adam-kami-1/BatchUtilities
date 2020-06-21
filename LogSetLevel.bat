@echo off

REM =============================================================================
:LogSetLevel
REM =============================================================================
REM %1 - LogLevel: ALL, CRITICAL, ERROR, WARNING, INFO, TRACE, DEBUG
REM      If parameter is empty then Current Log Level is displayed
REM =================

setlocal EnableDelayedExpansion

set ALL=0
set $LogLevelName[0]=ALL
set CRITICAL=1
set $LogLevelName[1]=CRITICAL
set ERROR=2
set $LogLevelName[2]=ERROR
set WARNING=3
set $LogLevelName[3]=WARNING
set INFO=4
set $LogLevelName[4]=INFO
set TRACE=5
set $LogLevelName[5]=TRACE
set DEBUG=6
set $LogLevelName[6]=DEBUG

if "%~1" == "" (
   echo Current log level is !$LogLevelName[%$LogCurrLevel%]!
   goto :EOF
)
REM Translate level name to log level number
set $LogCurrLevel=!%~1!

REM If first parameter was not valid level name then set $LogCurrLevel to ALL(0)
set /a "$LogCurrLevel=($LogCurrLevel+1)-1"

endLocal & set $LogCurrLevel=%$LogCurrLevel%& exit /b
REM =============================================================================
