@echo off

REM ============================================================================
:CreateShortcut
REM ===========
setLocal
REM %1 Target
set $TARGET=%~f1
REM %2 Link name
set $LINK=%~2
REM ===========
REM echo $TARGET=%$TARGET%
REM echo $LINK=%$LINK%
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%$LINK%.lnk');$s.TargetPath='%$TARGET%';$s.Save()" > NUL
endLocal
goto :EOF
REM ============================================================================


