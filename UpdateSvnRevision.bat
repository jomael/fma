@echo off
REM CommandInterpreter: $(COMSPEC)
echo ----------------OLD------------------
type .\fma\trunk\uAbout.inc
echo.
echo ----------------NEW------------------
echo Updating...
"c:\Program Files\TortoiseSVN\bin\SubWCRev.exe" .\fma\trunk\ .\fma\trunk\uAbout.templ .\fma\trunk\uAbout.inc
echo -------------------------------------
pause