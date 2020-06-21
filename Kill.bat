@echo off


REM ============================================================================
:Kill
REM ===========
setLocal
REM %1 - Application to kill
set APP=%~1
REM ===========
REM start %APP%
tasklist /fi "ImageName eq %APP%" | %SystemRoot%\System32\find.exe "%APP%" > NUL
if errorlevel 1 (
  REM Application is not running. Nobody to kill.
  exit /b 1
)
call Version.bat
for /l %%A in (1,1,10) do (
  if %VERSION_MAJOR% lss 10 (
    taskkill /f /t /im "%APP%"
  ) else (
    taskkill /t /im "%APP%"
  )
  call Sleep.bat 10
  tasklist /fi "ImageName eq %APP%" | %SystemRoot%\System32\find.exe "%APP%" > NUL
  if errorlevel 1 (
    exit /b 0
  )
)
endLocal
exit /b 2
REM ============================================================================

