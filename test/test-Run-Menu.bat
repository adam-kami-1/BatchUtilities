REM ============================================================================
:test-Run-Menu
REM ===========
setLocal
REM %1 - Result variable name
REM %2 - Sequence of characters to send one by one to Menu
set $SEQ=%~2
REM ===========
if exist %TMP%\test-Run-Menu del %TMP%\test-Run-Menu
:test-Run-Menu-Again
  set $C=%$SEQ:~0,1%
  set $SEQ=%$SEQ:~1%
  echo ^%$C%>> %TMP%\test-Run-Menu
if not "%$SEQ%" == "" goto :test-Run-Menu-Again
call Menu Init MENU1
call Menu AddItem MENU1 "I - jeden" One
call Menu AddItem MENU1 "II - dwa" Two
call Menu AddItem MENU1 III Three
call Menu AddItem MENU1 IV Four
call Menu AddItem MENU1 V Five
call Menu AddItem MENU1 VI Six
call Menu AddItem MENU1 VII Seven
call Menu AddItem MENU1 VIII Eight
call Menu AddItem MENU1 IX Nine
call Menu AddItem MENU1 X Ten
call Menu AddItem MENU1 XI Eleven
call Menu AddItem MENU1 XII Twelve
call Menu AddItem MENU1 XIII Thirteen
call Menu AddItem MENU1 XIV Fourteen
call Menu AddItem MENU1 XV Fifteen
call Menu AddItem MENU1 XVI Sixteen
call Menu AddItem MENU1 XVII Seventeen
call Menu AddItem MENU1 XVIII Eighteen
call Menu AddItem MENU1 XIX Nineteen
call Menu AddItem MENU1 XX Twenty
call Menu AddItem MENU1 XXI "Twenty One"
call Menu AddItem MENU1 XXII "Twenty Two"
call Menu AddItem MENU1 XXIII "Twenty Three"
call Menu AddItem MENU1 XXIV "Twenty Four"
call Menu AddItem MENU1 XXV "Twenty Five"
call Menu AddItem MENU1 XXVI "Twenty Six"
call Menu AddItem MENU1 XXVII "Twenty Seven"
call Menu AddItem MENU1 XXVIII "Twenty Eight"
call Menu AddItem MENU1 XXIX "Twenty Nine"
call Menu AddItem MENU1 XXX Thirty
call Menu AddItem MENU1 XXXI "Thirty One"
call Menu AddItem MENU1 XXXII "Thirty Two"
call Menu AddItem MENU1 XXXIII "Thirty Three"
call Menu AddItem MENU1 XXXIV "Thirty Four"
call Menu AddItem MENU1 XXXV "Thirty Five"
call Menu AddItem MENU1 XXXVI "Thirty Six"
call Menu AddItem MENU1 XXXVII "Thirty Seven"
call Menu AddItem MENU1 XXXVIII "Thirty Eight"
call Menu AddItem MENU1 XXXIX "Thirty Nine"
call Menu AddItem MENU1 XL Forty
call Menu AddItem MENU1 XLI "Forty One"
call Menu AddItem MENU1 XLII "Forty Two"
call Menu AddItem MENU1 XLIII "Forty Three"
call Menu AddItem MENU1 XLIV "Forty Four"
call Menu AddItem MENU1 XLV "Forty Five"
call Menu AddItem MENU1 XLVI "Forty Six"
call Menu AddItem MENU1 XLVII "Forty Seven"
call Menu AddItem MENU1 XLVIII "Forty Eight"
call Menu AddItem MENU1 XLIX "Forty Nine"
if %$VERBOSE% ==  on (
  call Menu Select $RETVAL MENU1 "Select the number: " <%TMP%\test-Run-Menu
) else (
  call Menu Select $RETVAL MENU1 "Select the number: " <%TMP%\test-Run-Menu >NUL
)
del %TMP%\test-Run-Menu
call Menu Clear MENU1
endLocal & set %~1=%$RETVAL%& exit /b
REM ============================================================================


