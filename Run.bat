@echo off


REM ============================================================================
:Run
REM ===========
setLocal
REM %1 - Application to start
set APP=%~1
REM ===========
start %APP%
for /l %%A in (1,1,10) do (
  call Sleep.bat 10
  tasklist /fi "ImageName eq %APP%" | %SystemRoot%\System32\find.exe "%APP%" > NUL
  if not errorlevel 1 (
    exit /b 0
  )
)
endLocal
exit /b 1
REM ============================================================================

