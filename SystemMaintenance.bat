@echo off
:: Elevate to Administrator
if not "%~1"=="" goto :start
powershell -Command "Start-Process '%~dpnx0' -ArgumentList start -Verb RunAs"
exit

:start
:: Title and instructions
title One-Click System Maintenance
echo ====================================================
echo         One-Click Full Computer Refresh
echo ====================================================

:: Clear %temp% folder
echo Cleaning %temp% folder...
del /q /s "%temp%\*" >nul 2>&1
echo %temp% folder cleaned.

:: Clear Temp folder
echo Cleaning C:\Windows\Temp...
del /q /s "C:\Windows\Temp\*" >nul 2>&1
echo C:\Windows\Temp cleaned.

:: Clear Recent Files
echo Cleaning recent files...
del /q /s "%userprofile%\Recent\*" >nul 2>&1
echo Recent files cleaned.

:: Disk Cleanup
echo Starting Disk Cleanup...
cleanmgr /sagerun:1
echo Disk Cleanup completed.

:: Optimize all drives
echo Optimizing all drives...
for /f "tokens=*" %%d in ('wmic logicaldisk get name') do (
    if not "%%d"=="" (
        defrag %%d /O
    )
)
echo Drive optimization completed.

:: System Refresh (Restart Explorer)
echo Restarting Explorer for a full system refresh...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
echo System refresh completed.

echo ====================================================
echo          Maintenance Complete. Have a Nice Day!
echo ====================================================
pause
exit
