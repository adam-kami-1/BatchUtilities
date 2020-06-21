@echo off
REM Does not work on Windows 10


REM ============================================================================
:CreateShortcut
REM ===========
setLocal
REM %1 Target
set $TARGET=%~1
REM %2 Link name
set $LINK=%~2
REM ===========
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%$LINK%.lnk');$s.TargetPath='%$TARGET%';$s.Save()"
endLocal
goto :EOF
REM ============================================================================


