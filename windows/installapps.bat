@echo off

echo Installing Firefox
pause
"Firefox Installer.exe"

echo Installing Ruby
echo Leave all options default
pause
"rubyinstaller-devkit-2.7.8-1-x64.exe"

echo Installing Git
echo On the screen, "Adjusting your PATH environment", select "Use Git and optional Unix tools from the Command Prompt"
pause
"Git-2.41.0.2-64-bit.exe"
