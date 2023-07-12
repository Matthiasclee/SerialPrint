@echo off

echo Downloading SerialPrint
cd C:\
git clone https://github.com/Matthiasclee/serialprint

echo Running install commands
cd serialprint\windows
copy_to_startup.bat
powershell Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
powershell ./install_gems.ps1

echo Install done, reboot for changes to take effect.
pause
