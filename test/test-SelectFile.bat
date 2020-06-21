REM ============================================================================
:test-SelectFile
REM ===========

set $Run-SelectFile=%$BIN_PATH%test\test-Run-SelectFile.bat

call :test-Prepare-SelectFile %TEMP%\

call DoTest.bat [--] Simple-str "Path without \ at the end"  %$Run-SelectFile% "%TEMP%\test\Second.txt" exact "%TEMP%\test" "*.txt" B

call DoTest.bat [--] Simple-str "Path with \ at the end"     %$Run-SelectFile% "%TEMP%\test\Third.txt"  exact "%TEMP%\test\" "*.txt" C

pushd %TEMP%\test
call DoTest.bat [--] Simple-str "Local path ."               %$Run-SelectFile% "%TEMP%\test\First.bin" exact "." "*.bin" A
popd

pushd %TEMP%\
call DoTest.bat [--] Simple-str "Indirect path"              %$Run-SelectFile% "%TEMP%\test\First.bin" exact "test" "*.bin" A
popd

pushd %TEMP%\test
call DoTest.bat [--] Simple-str "Local path (default empty)" %$Run-SelectFile% "%TEMP%\test\Third.bin" exact "" "" E
popd

call DoTest.bat [--] Simple-str "Path with only one maching file"  %$Run-SelectFile% "%TEMP%\test\Second.txt" exact "%TEMP%\test" "S*.txt" A

call DoTest.bat [--] Simple-str "Path with 0 maching files"  %$Run-SelectFile% "" exact "%TEMP%\test" "*.doc" A

call :test-Clean-SelectFile %TEMP%\

goto :EOF
REM ============================================================================


REM ============================================================================
:test-Prepare-SelectFile
REM ===========
mkdir %1test
pushd %1test
echo;> First.txt
echo;> Second.txt
echo;> Third.txt
echo;> First.bin
echo;> Second.bin
echo;> Third.bin
mkdir First.Dir
mkdir Second.Dir
mkdir Third.Dir
popd
goto :EOF
REM ============================================================================


REM ============================================================================
:test-Clean-SelectFile
REM ===========
pushd %1
cd test
del First.txt
del Second.txt
del Third.txt
del First.bin
del Second.bin
del Third.bin
rmdir First.Dir
rmdir Second.Dir
rmdir Third.Dir
cd ..
rmdir test
popd
goto :EOF
REM ============================================================================


