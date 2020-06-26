@echo off


REM ============================================================================
:Run
REM ===========
setLocal
REM %1 - Application to start
set APP=%~1
REM ===========
start "" %*
for /l %%A in (0,1,9) do (
  call Sleep.bat %%A
  REM tasklist /fi "ImageName eq %APP%" | %SystemRoot%\System32\find.exe "%APP%" > NUL
  REM Solve problem with space in Image Name
  tasklist | %SystemRoot%\System32\find.exe "%APP%" > NUL
  if not errorlevel 1 (
    echo Application %APP% successfully started
    exit /b 0
  )
)
echo Unable to verify if application %APP% successfully started
endLocal
exit /b 1
REM ============================================================================

