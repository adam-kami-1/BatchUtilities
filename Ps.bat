@echo off


REM ============================================================================
:Ps
REM ===========
setLocal
REM %1 - /A - Display all processes. If not present show only processes started
REM           by current user
REM ===========

REM ============================================================================
set TEMPFILE=%TEMP%\$Ps
if /i "%~1" == "/a" (
   set USER=
) else (
   set "USER=%USERNAME%"
)
if "%USER%" == "" (
   tasklist /v /fo csv > %TEMPFILE%
   REM  123456789012345 12345678 1234567890 123456789012345
   echo User name            PID   CPU Time       Mem Usage Image Name [Window Title]
) else (
   tasklist /v /fo csv /fi "Username eq %USER%" > %TEMPFILE%
   REM  12345678 1234567890 123456789012345
   echo      PID   CPU Time       Mem Usage Image Name [Window Title]
)
for /f "skip=1 tokens=1* delims='" %%A in (%TEMPFILE%) do call :Ps-Parse-line %%A
if exist %TEMPFILE% del %TEMPFILE%
goto :EOF


REM ===========
:Ps-Parse-line
REM ===========
setLocal
REM EnableDelayedExpansion
set "$ImageName=%~1"
set "$PID=        %~2"
set $SessionName=%~3
set $Session#=%~4
set "$MemUsage=               %~5"
set $Status=%~6
set "$UserName=%~7               "
set "$Username=%$UserName:*\=%"
set "$CPUTime=          %~8"
set "$WindowTitle=%~9"
REM ===========
set "$WindowTitle=%$WindowTitle:"=%"
set "$WindowTitle=%$WindowTitle:|=%"
if "%$WindowTitle%" == "N/A" set "$PROC=%$ImageName%"
if not "%$WindowTitle%" == "N/A" set "$PROC=%$ImageName% [%$WindowTitle%]"
if "%USER%" == "" echo %$UserName:~0,15% %$PID:~-8% %$CPUTime:~-10% %$MemUsage:~-15% %$PROC%
if not "%USER%" == "" echo %$PID:~-8% %$CPUTime:~-10% %$MemUsage:~-15% %$PROC%
goto :EOF

REM ============================================================================
