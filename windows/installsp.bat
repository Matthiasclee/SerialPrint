@echo off

echo Downloading SerialPrint
git clone https://github.com/Matthiasclee/serialprint C:\serialprint

echo Running install commands
powershell Expand-Archive -Path "gnuplot_windows.zip" -DestinationPath "C:\serialprint"
cd C:\serialprint\windows
start copy_to_startup.bat
powershell Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
powershell ./install_gems.ps1

echo Install done, reboot for changes to take effect.
pause
