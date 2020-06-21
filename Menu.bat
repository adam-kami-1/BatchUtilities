@echo off


REM ============================================================================
:Menu
REM ============
REM %1 - Operation
REM %2... - Other parameters specific for the operation
REM ============
goto :Menu-%~1


REM ============================================================================
:Menu-Init
REM ============
shift
setLocal
REM %1 - Name of temporary menu file
set $MENU_FILE=%~1
REM %2 - Unique ASCII character, not present in menu items and values.
REM      Optional, default value "|"
set "$SEP=%~2"
REM ============
if "%$SEP%" == "" set "$SEP=|"
set "$SEP=%$SEP:~0,1%"
echo ^%$SEP%>"%TMP%\%$MENU_FILE%-SEP"
if exist "%TMP%\%$MENU_FILE%" del "%TMP%\%$MENU_FILE%"
endLocal
goto :EOF


REM ============================================================================
:Menu-Clear
REM ============
shift
REM %1 - Name of temporary menu file
set $MENU_FILE=%~1
REM ============
if exist "%TMP%\%$MENU_FILE%-SEP" del "%TMP%\%$MENU_FILE%-SEP"
if exist "%TMP%\%$MENU_FILE%" del "%TMP%\%$MENU_FILE%"
goto :EOF


REM ============================================================================
:Menu-AddItem
REM ============
shift
setLocal EnableDelayedExpansion
REM %1 - Name of temporary menu file
set $MENU_FILE=%~1
REM %2 - Item value to be returned when item selected in menu
set $VALUE=%~2
REM %3 - Item description to be displayed in menu. Optional,
REM      If not present then identical to item value.
set $DESCR=%~3
if "%$DESCR%" == "" set $DESCR=%$VALUE%
REM ============
if exist "%TMP%\%$MENU_FILE%-SEP" goto :Menu-AddItem-Start
  echo Error: Menu "%$MENU_FILE%" not initialized.
  endLocal & set %~1= & exit /b
  goto :EOF
:Menu-AddItem-Start
set $LINE=1
for /f "tokens=1" %%A in (%TMP%\%$MENU_FILE%-SEP) do (
  if !$LINE! == 1 set "$SEP=%%A"
  set /a $LINE+=1
)
echo %$VALUE%^%$SEP%%$DESCR%>>"%TMP%\%$MENU_FILE%"
endLocal
goto :EOF


REM ============================================================================
:Menu-Select
REM ============
shift
setLocal EnableDelayedExpansion
REM %1 - Result variable name
REM %2 - Name of temporary menu file
set $MENU_FILE=%~2
REM %3 - Message
set $MSG=%~3
REM ============
REM cls
set $ALPHA[1]=A
set $ALPHA[2]=B
set $ALPHA[3]=C
set $ALPHA[4]=D
set $ALPHA[5]=E
set $ALPHA[6]=F
set $ALPHA[7]=G
set $ALPHA[8]=H
set $ALPHA[9]=I
set $ALPHA[10]=J
set $ALPHA[11]=K
set $ALPHA[12]=L
set $ALPHA[13]=M
set $ALPHA[14]=N
set $ALPHA[15]=O
set $ALPHA[16]=P
set $ALPHA[17]=Q
set $ALPHA[18]=R
set $ALPHA[19]=S
set $ALPHA[20]=T
set $ALPHA[21]=U
set $ALPHA[22]=V
set $ALPHA[23]=W
set $ALPHA[24]=X
set $ALPHA[25]=Y
set $ALPHA[26]=Z
set $MAX=26

set $MENU_SIZE=0
set $MENU_START=1
set $MENU_STOP=0
if exist "%TMP%\%$MENU_FILE%-SEP" goto :Menu-Select-Start
  echo Error: Menu "%$MENU_FILE%" not initialized.
  endLocal & set %~1= & exit /b
  goto :EOF
:Menu-Select-Start
set $LINE=1
for /f "tokens=1" %%A in (%TMP%\%$MENU_FILE%-SEP) do (
  if !$LINE! == 1 set "$SEP=%%A"
  set /a $LINE+=1
)
if exist %TMP%\%$MENU_FILE% (
  for /f "tokens=1,2 delims=^%$SEP%" %%A in (%TMP%\%$MENU_FILE%) do (
    set /a $MENU_SIZE+=1
    set /a $MENU_STOP+=1
    set $MENU[!$MENU_SIZE!].value=%%A
    set $MENU[!$MENU_SIZE!].descr=%%B
  )
)
if !$MENU_SIZE! neq 0 goto :Menu-Select-CHECK1
  endLocal & set %~1=& exit /b
  goto :EOF
:Menu-Select-CHECK1
if !$MENU_SIZE! neq 1 goto :Menu-Select-Again
  set $RESULT=!$MENU[1].value!
  endLocal & set %~1=%$RESULT%& exit /b
  goto :EOF
:Menu-Select-Again
  set $KEYS=
  set /a $OFFSET=!$MENU_START! - 1
  set /a $DISP_SIZE=!$MENU_STOP! - !$MENU_START! + 1
  if !$DISP_SIZE! gtr %$MAX% (
    set /a $MENU_STOP=!$MENU_START! + %$MAX% - 1
  )
  if !$MENU_STOP! gtr !$MENU_SIZE! (
    set $MENU_STOP=!$MENU_SIZE!
  )
  echo =======================
  if !$MENU_START! gtr 1 (
    echo 0: ^<- Previous items...
    set $KEYS=!$KEYS!0
    echo ---
  )
  for /l %%C in (!$MENU_START!,1,!$MENU_STOP!) do (
    set /a $POS=%%C - !$OFFSET!
    call :MenuDisplayItem %%C !$POS!
  )
  if !$MENU_STOP! neq !$MENU_SIZE! (
    echo ---
    echo 9: -^> Next items...
    set $KEYS=!$KEYS!9
  )
  echo =======================
  choice /c !$KEYS! /n /m "%$MSG%"
  echo -----------------------
  set $RES=%ERRORLEVEL%
  if !$MENU_START! gtr 1 (
    set /a $RES-=1
  )
  if !$RES! equ 0 (
    REM Go to previous items
    echo;
    set /a $MENU_START-=%$MAX%
    set /a $MENU_STOP=!$MENU_START! + %$MAX% - 1
    goto :Menu-Select-Again
  )
  if !$RES! gtr %$MAX% (
    REM Go to next items
    echo;
    set /a $MENU_START+=%$MAX%
    set /a $MENU_STOP+=%$MAX%
    goto :Menu-Select-Again
  )
if !$MENU_START! gtr 1 (
  set /a $RES+=$MENU_START - 1
)
set $RESULT=!$MENU[%$RES%].value!
endLocal & set %~1=%$RESULT%& exit /b
goto :EOF


REM ============================================================================
:MenuDisplayItem
REM ============
REM %1 - Menu item number
REM %2 - Display item number
REM ============
set $KEY=!$ALPHA[%~2]!
echo !$KEY!: !$MENU[%~1].descr!
set $KEYS=%$KEYS%!$KEY!
goto :EOF


