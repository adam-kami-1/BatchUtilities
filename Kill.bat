@echo off


REM ============================================================================
:Kill
REM ===========
setLocal
REM %1 - Application to kill: Image Name or PID
set APP=%~1
REM ===========
set /a "PID=(APP+1)-1"
if "%PID%" == "%APP%" goto :Kill-PID

REM echo Killing Application=%APP%
tasklist /fi "ImageName eq %APP%" | %SystemRoot%\System32\find.exe "%APP%" > NUL
if errorlevel 1 (
  echo Application %APP% is not running.
  exit /b 1
)
for /l %%A in (0,1,9) do (
  taskkill /t /im "%APP%"
  call Sleep.bat %%A
  tasklist /fi "ImageName eq %APP%" | %SystemRoot%\System32\find.exe "%APP%" > NUL
  if errorlevel 1 (
    echo Application %APP% successfully killed
    exit /b 0
  )
)
echo Unable to kill application %APP%
endLocal
exit /b 2

:Kill-PID
REM echo Killing PID=%PID%
tasklist /fi "PID eq %PID%" | %SystemRoot%\System32\find.exe "%PID%" > NUL
if errorlevel 1 (
  echo Application with PID=%PID% is not running.
  exit /b 1
)
for /l %%A in (0,1,9) do (
  taskkill /t /pid "%PID%"
  call Sleep.bat %%A
  tasklist /fi "PID eq %PID%" | %SystemRoot%\System32\find.exe "%PID%" > NUL
  if errorlevel 1 (
    echo Application with PID=%PID% successfully killed
    exit /b 0
  )
)
echo Unable to kill application with PID=%PID%
endLocal
exit /b 2
REM ============================================================================

