REM ============================================================================
:test-Menu
REM ===========

set $Run-Menu=%$BIN_PATH%test\test-Run-Menu.bat

call DoTest.bat [--] Simple-str "Item from first set"                   %$Run-Menu% "XI"       exact K
call DoTest.bat [--] Simple-str "Item from second set"                  %$Run-Menu% "XXXVI"    exact 9J
call DoTest.bat [--] Simple-str "Going to second set and back to first" %$Run-Menu% "II - dwa" exact 90B

goto :EOF
REM ============================================================================


