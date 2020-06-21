@echo off

REM =============================================================================
:Log
REM =============================================================================
REM If Current Log Level is ALL
REM    %1 %2 %3 %4 ... - Log message
REM    Message is always displayed
REM For all other values of Current Log Level
REM    %1 - Message Level: CRITICAL, ERROR, WARNING, INFO, TRACE, DEBUG
REM    %2 %3 %4 ... - Log message
REM    Message is displayed if Message Level <= Current Log Level
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

if "%$LogCurrLevel%" == "" (
   set $LogCurrLevel=0
)
if "%$LogCurrLevel%" == "0" (
   set $LogMsg=%date% %time%:
   goto :LogLoop
)

REM Translate first parameter to log level number
set $LevelNo=!%~1!

REM If first parameter is not valid level name then set it to 0
set /a "$LevelNo=($LevelNo+1)-1"

REM Check $LevelNo against $LogCurrLevel, and echo log if succesfull
if "%$LevelNo%" GTR "%$LogCurrLevel%" goto :EOF

set "$LogMsg=%date% %time%[!$LogLevelName[%$LevelNo%]!]:"

REM Skip first parameter if it was correct level name
if /i NOT "!$LogLevelName[%$LevelNo%]!" == "%~1" goto :LogLoop
shift

:LogLoop
   if "%~1" == "" (
      call :LogEcho "%$LogMsg%"
      goto :EOF
   )
   set "$LogMsg=!$LogMsg! %~1"
   shift
goto :LogLoop

:LogEcho

echo %~1
if not "%$LogFile%" == "" (
  echo %~1 >> "%$LogFile%"
)
goto :EOF
REM =============================================================================

