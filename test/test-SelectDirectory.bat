REM ============================================================================
:test-SelectDirectory
REM ===========

set $Run-SelectDirectory=%$BIN_PATH%test\test-Run-SelectDirectory.bat

call :test-Prepare-SelectDirectory %TEMP%\

call DoTest.bat [--] Simple-str "Path without \ at the end"  %$Run-SelectDirectory% "%TEMP%\test\Second.Dir" exact "%TEMP%\test" "*.*" B

call DoTest.bat [--] Simple-str "Path with \ at the end"     %$Run-SelectDirectory% "%TEMP%\test\Third.Dir"  exact "%TEMP%\test\" "*.*" C

pushd %TEMP%\test
call DoTest.bat [--] Simple-str "Local path ."               %$Run-SelectDirectory% "%TEMP%\test\First.Dir" exact "." "*.*" A
popd

pushd %TEMP%\
call DoTest.bat [--] Simple-str "Indirect path"              %$Run-SelectDirectory% "%TEMP%\test\First.Dir" exact "test" "*.*" A
popd

pushd %TEMP%\test
call DoTest.bat [--] Simple-str "Local path (default empty)" %$Run-SelectDirectory% "%TEMP%\test\Third.Dir" exact "" "" C
popd

call DoTest.bat [--] Simple-str "Path with only one maching directory"  %$Run-SelectDirectory% "%TEMP%\test\Second.Dir" exact "%TEMP%\test" "S*.Dir" A

call DoTest.bat [--] Simple-str "Path with 0 maching directories"  %$Run-SelectDirectory% "" exact "%TEMP%\test" "A*" A

call :test-Clean-SelectDirectory %TEMP%\

goto :EOF
REM ============================================================================


REM ============================================================================
:test-Prepare-SelectDirectory
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
:test-Clean-SelectDirectory
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


