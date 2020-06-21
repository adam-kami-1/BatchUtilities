@echo off


REM ============================================================================
:SelectDirectory
REM ============
setLocal
REM %1 - Result variable name
REM %2 - Path containing directories to select
set $PATH=%~f2
REM %3 - Directy name mask
set $MASK=%~3
REM ============
if "%$PATH%" == "" (
  for /f "tokens=*" %%A in ('cd') do (
    set $PATH=%%A
  )
  if "%$MASK%" == "" set $MASK=*
)
if "%$PATH:~-1%" == "\" set $PATH=%$PATH:~0,-1%
pushd %$PATH%
call Menu Init $MENU1
for /d %%A in (%$MASK%) do (
  call Menu AddItem $MENU1 "%$PATH%\%%A" "%%A"
)
call Menu Select $RETVAL $MENU1 "Select directory: "
call Menu Clear $MENU1
popd
endLocal & set %~1=%$RETVAL%& exit /b
goto :EOF


