@echo off

REM =============================================================================
:LogSetFile
REM =============================================================================
REM %1 - Log File Name with optional path
REM      If parameter is empty then Log File Name setting is displayed
REM      If parameter value is OFF then Log File Name setting is cleared
REM =================

if "%~1" == "" (
   if "%$LogFile%" == "" (
      echo Loging to File is turned off
   ) else (
      echo Current Log File Name is: %$LogFile%
   )
   goto :EOF
)
if /i "%~1" == "OFF" (
   set $LogFile=
   goto :EOF
)
set "$LogFile=%~f1"
REM =============================================================================
