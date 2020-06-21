REM ============================================================================
:test-Sleep
REM ===========

set $Run-Sleep=%$BIN_PATH%test\test-Run-Sleep.bat

call DoTest.bat [--] Simple-int "5 Seconds"   %$Run-Sleep% 5   1 5
call DoTest.bat [--] Simple-int "20 Seconds"  %$Run-Sleep% 20  1 20
REM call DoTest.bat [--] Simple-int "240 Seconds" %$Run-Sleep% 240 1 240

goto :EOF
REM ============================================================================


