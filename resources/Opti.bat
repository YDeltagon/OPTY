:: 2024-06-03 - Menu :                Add logs
:: 2024-03-21 - Menu :                Only-NumLock
:: 2023-11-03 - Préstart              Add a "StartReady" before AutoOpti full, for stop some services
:: 2023-10-06 - CleanMGR              Add /sageset for CleanMGR
:: 2023-09-24 - add                   Add netdns(ipconfig & netsh) - Add del Prefetch & Logs - and some other del
:: 2023-08-16 - fix                   Fix a bug if you choice the "manual", crash after chkdsk : fix
:: 2023-07-12 - Remove Winget         Remove Winget > Use "winget install wingetui" on your powershell
:: 2023-04-12 - fix                   fix code and rename auto > autoclean
:: 2023-02-11 - autoopti + shutdown   Add if AutoOpti_Shutdown == 1 goto wupdate
::                                    This is for the new shortcut
:: 2023-01-29 - auto defrag fix       Fix a bug with auto defrag
::                                    Update link GitHub
:: 2023-01-28 - timeout auto :        If is auto on, no need to wait with timeout
:: 2023-01-27 - standalone :          Like old, but standalone

echo %date% %time% : Opti.bat >> %logs%
if /i "%AutoOpti_Shutdown%"=="1" echo %date% %time% : AutoOpti_Shutdown >> %logs% & goto wupdate

:mopti
color F5
cls
echo.
echo  WELCOME to OPTY by @YDeltagon (YannD)
echo  Choose a option for Optimization cycle:
echo.
echo   1. Manual
echo   2. Auto (lite)
echo   3. Auto (Full)
echo.
echo   5. Create a desktop shortcut for Auto (lite) + Shutdown
echo.
echo  If you want reboot/stop after autoopti, type "r" (reboot) or"s" (shutdown) after the number - 2r/s-3r/s
echo  If you don't want reboot/stop, type nothing after the number - 2-3
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo   0. Menu
echo.
set /p choice= Enter action:
echo %date% %time% : Opti.bat-mopti %choice% >> %logs%
if /i "%choice%"=="1" set autoclean=0 & set autoshutdownreboot=5 & goto mdisenable
if /i "%choice%"=="2" set autoclean=1 & set autoshutdownreboot=0 & goto wupdate
if /i "%choice%"=="3" set autoclean=2 & set autoshutdownreboot=0 & goto stopapps
if /i "%choice%"=="2s" set autoclean=1 & set autoshutdownreboot=1 & goto wupdate
if /i "%choice%"=="3s" set autoclean=2 & set autoshutdownreboot=1 & goto stopapps
if /i "%choice%"=="2r" set autoclean=1 & set autoshutdownreboot=2 & goto wupdate
if /i "%choice%"=="3r" set autoclean=2 & set autoshutdownreboot=2 & goto stopapps
if /i "%choice%"=="5" goto CreateAutoOpti_Shutdown
if /i "%choice%"=="0" goto menu
color 0C
echo This is not a valid action
timeout /t 5
goto mopti


:CreateAutoOpti_Shutdown
echo %date% %time% : Opti.bat-CreateAutoOpti_Shutdown >> %logs%
set GitHubRawLink=https://raw.githubusercontent.com/YDeltagon/OPTY/master/resources/
curl -o AutoOptiShutdown.bat -LJO %GitHubRawLink%AutoOptiShutdown.bat
curl -o Shortcut_AutoOptiShutdown.ps1 -LJO %GitHubRawLink%Shortcut_AutoOptiShutdown.ps1
powershell.exe -ExecutionPolicy Bypass -File Shortcut_AutoOptiShutdown.ps1
del /f /q Shortcut_AutoOptiShutdown.ps1
echo.
echo.
timeout /t 5
goto mopti


:mdisenable
color F4
cls
echo.
echo  WELCOME to OPTY by @YDeltagon (YannD)
echo  Choose a option to Disable/Enable :
echo.
echo  Add "+" or "-" in front of an action + activate or - deactivate it (example "-1" to deactivate animations)
echo.
echo   ani. Animation
echo   mov. Window content while moving
echo   fad. File access date updating
echo   hbn. Hibernation mods
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo   2. Next
echo   0. Menu
echo.
echo.
set /p choice= Enter action:
echo %date% %time% : Opti.bat-mdisenable %choice% >> %logs%
if /i "%choice%"=="-ani" reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuAnimate" /t REG_SZ /d "0" /f & pause & goto mdisenable
if /i "%choice%"=="+ani" reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuAnimate" /t REG_SZ /d "1" /f & pause & goto mdisenable
if /i "%choice%"=="-mov" reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "0" /f & pause & goto mdisenable
if /i "%choice%"=="+mov" reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "1" /f & pause & goto mdisenable
if /i "%choice%"=="-fad" fsutil behavior set disablelastaccess 1 & pause & goto mdisenable
if /i "%choice%"=="+fad" fsutil behavior set disablelastaccess 0 & pause & goto mdisenable
if /i "%choice%"=="-hbn" powercfg.exe /hibernate off & echo Disable hibernate & pause & goto mdisenable
if /i "%choice%"=="+hbn" powercfg.exe /hibernate on & echo Enable hibernate & pause & goto mdisenable
if /i "%choice%"=="2" goto mnetdns
if /i "%choice%"=="0" goto menu
cls
color 0C
echo This is not a valid action
timeout /t 5
goto mdisenable


:stopapps
echo %date% %time% : Opti.bat-stopapps >> %logs%
cls
echo Stop your background apps !
pause
if /i %autoclean% == 2 goto startready

:startready
echo %date% %time% : Opti.bat-startready >> %logs%
net stop bits
net stop wuauserv
net stop msiserver
net stop cryptsvc
net stop appidsvc
regsvr32.exe /s atl.dll
regsvr32.exe /s urlmon.dll
regsvr32.exe /s mshtml.dll
if /i %autoclean% == 2 goto netdns


:mnetdns
cls
echo Do you want to flushdns and ip reset - IPCONFIG and NETSH ?
set /p choice= 1 (Yes) - 2 (No)
echo %date% %time% : Opti.bat-mnetdns %choice% >> %logs%
if /i "%choice%"=="1" goto netdns
if /i "%choice%"=="2" goto mdism
if /i "%choice%"=="0" goto menu
echo This is not a valid action
timeout /t 5
goto mnetdns

:netdns
echo %date% %time% : Opti.bat-netdns >> %logs%
ipconfig /flushdns
netsh int ip reset
netsh winsock reset
netsh winsock reset proxy
if /i %autoclean% == 2 goto dism
timeout /t 5


:mdism
cls
echo Do you want to dismy the integrity of the Windows image and correct problems - DISM ?
set /p choice= 1 (Yes) - 2 (No)
echo %date% %time% : Opti.bat-mdism %choice% >> %logs%
if /i "%choice%"=="1" goto dism
if /i "%choice%"=="2" goto msfc
if /i "%choice%"=="0" goto menu
echo This is not a valid action
timeout /t 5
goto mdism

:dism
echo %date% %time% : Opti.bat-dism >> %logs%
dism /Online /Cleanup-image /ScanHealth
dism /Online /Cleanup-image /CheckHealth
dism /Online /Cleanup-image /RestoreHealth
dism /Online /Cleanup-image /StartComponentCleanup /ResetBase
if /i %autoclean% == 2 goto sfc
timeout /t 5


:msfc
cls
echo Do you want to verify the integrity of system files and fix problems - SFC ?
set /p choice= 1 (Yes) - 2 (No)
echo %date% %time% : Opti.bat-msfc %choice% >> %logs%
if /i "%choice%"=="1" goto sfc
if /i "%choice%"=="2" goto mwupdate
if /i "%choice%"=="0" goto menu
echo This is not a valid action
timeout /t 5
goto msfc

:sfc
echo %date% %time% : Opti.bat-sfc >> %logs%
sfc /scannow
if /i %autoclean% == 2 goto wupdate
timeout /t 5


:mwupdate
cls
echo Do you want to update Windows - USOCLIENT ?
set /p choice= 1 (Yes) - 2 (No)
echo %date% %time% : Opti.bat-mwupdate %choice% >> %logs%
if /i "%choice%"=="1" goto wupdate
if /i "%choice%"=="2" goto mclean
if /i "%choice%"=="0" goto menu
echo This is not a valid action
timeout /t 5
goto mwupdate

:wupdate
echo %date% %time% : Opti.bat-wupdate >> %logs%
usoclient StartScan
usoclient RefreshSettings
usoclient StartInstall
if /i %autoclean% == 1 goto delete
if /i %autoclean% == 2 goto delete
timeout /t 5

:mclean
cls
echo Execute clean disk - CLEANMGR ?
set /p choice= 1 (Yes) - 2 (No)
echo %date% %time% : Opti.bat-mclean %choice% >> %logs%
if /i "%choice%"=="1" goto clean
if /i "%choice%"=="2" goto mdelete
if /i "%choice%"=="0" goto menu
echo This is not a valid action
timeout /t 5
goto mclean

:clean
echo %date% %time% : Opti.bat-clean %choice% >> %logs%
echo Cleanmgr...
cleanmgr /sageset:65535
pause
cleanmgr /sagerun:65535
timeout /t 5


:mdelete
cls
echo Do you want to delete temporary files - DEL ?
set /p choice= 1 (Yes) - 2 (No)
echo %date% %time% : Opti.bat-mdelete %choice% >> %logs%
if /i "%choice%"=="1" goto delete
if /i "%choice%"=="2" goto mdefrag
if /i "%choice%"=="0" goto menu
echo This is not a valid action
timeout /t 5
goto mdelete

:delete
echo %date% %time% : Opti.bat-delete >> %logs%

REM ========= Windows Update Cache =========
net stop wuauserv
del /S /F /Q "C:\Windows\SoftwareDistribution\Download\*"
net start wuauserv

REM ========= Windows Error Reporting =========
del /S /F /Q "%LOCALAPPDATA%\Microsoft\Windows\WER\ReportQueue\*"
del /S /F /Q "%LOCALAPPDATA%\Microsoft\Windows\WER\ReportArchive\*"

REM ========= Windows Event Logs =========
del /S /F /Q "%WINDIR%\System32\winevt\Logs\*"

REM ========= Windows Upgrade Logs =========
del /S /F /Q "%SystemDrive%\$Windows.~BT\Sources\Panther\*"

REM ========= Prefetch =========
del /S /F /Q "%WINDIR%\Prefetch\*"

REM ========= Temp Files =========
setlocal
for /D %%i in ("C:\Users\*") do (
   echo %%i
   del /S /F /Q "%%i\AppData\Local\Temp\*"
)
endlocal
del /S /F /Q "%WINDIR%\Temp"
rd /S /Q "%WINDIR%\Temp"

REM ========= CCMCache =========
del /F /S /Q "%WINDIR%\ccmcache\*.*"
rd /S /Q "%WINDIR%\ccmcache\"

REM ========= Browser Cache =========
del /S /F /Q "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*\cache2\*"
del /S /F /Q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*"
del /S /F /Q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Code Cache\*"
del /S /F /Q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*"
del /S /F /Q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Code Cache\*"

REM ========= Gaming Platforms Cache =========
del /S /F /Q "%ProgramFiles(x86)%\Steam\appcache\*"
del /S /F /Q "%ProgramFiles(x86)%\Steam\depotcache\*"
del /S /F /Q "%ProgramFiles(x86)%\Ubisoft\Ubisoft Game Launcher\cache\*"
del /S /F /Q "%ProgramData%\Battle.net\Cache\*"
del /S /F /Q "%ProgramFiles(x86)%\Rockstar Games\Launcher\cache\*"
del /S /F /Q "%ProgramData%\Origin\Cache\*"
del /S /F /Q "%ProgramData%\GOG.com\Galaxy\cache\*"

REM ========= Communication Tools Cache =========
del /S /F /Q "%APPDATA%\discord\Cache\*"
del /S /F /Q "%APPDATA%\Microsoft\Teams\Cache\*"
del /S /F /Q "%APPDATA%\Slack\Cache\*"

REM ========= Office Applications Cache =========
del /S /F /Q "%LOCALAPPDATA%\Microsoft\Outlook\RoamCache\*"

REM ========= Development Tools Cache =========
del /S /F /Q "%APPDATA%\Code\Cache\*"
del /S /F /Q "%LOCALAPPDATA%\Android\Sdk\cache\*"

REM ========= GPU Caches =========
del /S /F /Q "%LOCALAPPDATA%\AMD\DxCache\*"
del /S /F /Q "%ProgramData%\NVIDIA Corporation\NV_Cache\*"
del /S /F /Q "%LOCALAPPDATA%\Intel\ShaderCache\*"

REM ========= DirectX Shader Cache =========
del /S /F /Q "%LOCALAPPDATA%\D3DSCache\*"

REM ========= Windows Defender Cache =========
del /S /F /Q "%ProgramData%\Microsoft\Windows Defender\Scans\History\Store\*"

REM ========= Windows Thumbnail Cache =========
del /S /F /Q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db"

REM ========= Windows Installer Cache =========
del /S /F /Q "%WINDIR%\Installer\$PatchCache$\*"

REM ========= Windows Font Cache =========
del /S /F /Q "%LOCALAPPDATA%\FontCache\*"

REM ========= Nuanceur DirectX =========
del /S /F /Q "%LOCALAPPDATA%\Microsoft\DirectX Shader Cache\*"

if /i %autoclean% == 1 goto mshutdownreboot
if /i %autoclean% == 2 goto defrag
timeout /t 5


:mdefrag
cls
echo Do you want to defragment HDD or optimize SSD - DEFRAG ?
set /p choice= 1 (Yes) - 2 (No)
echo %date% %time% : Opti.bat-mdefrag %choice% >> %logs%
if /i "%choice%"=="1" goto defrag
if /i "%choice%"=="2" goto mchkdsk
if /i "%choice%"=="0" goto menu
echo This is not a valid action
timeout /t 5
goto mdefrag

:defrag
echo %date% %time% : Opti.bat-defrag >> %logs%
defrag /C /O /U /V /H
if /i %autoclean% == 2 goto endready
timeout /t 5


:mchkdsk
cls
echo Do you want to check the integrity of hard drives and fix any problems - CHKDSK ?
set /p choice= 1 (Yes) - 2 (No)
echo %date% %time% : Opti.bat-mchkdsk %choice% >> %logs%
if /i "%choice%"=="1" goto chkdsk
if /i "%choice%"=="2" goto mshutdownreboot
if /i "%choice%"=="0" goto menu
echo This is not a valid action
timeout /t 5
goto mchkdsk

:chkdsk
echo %date% %time% : Opti.bat-chkdsk >> %logs%
CHKDSK /f /r
if /i %autoclean% == 2 goto endready
timeout /t 5

:endready
echo %date% %time% : Opti.bat-endready >> %logs%
net start bits
net start wuauserv
net start msiserver
net start cryptsvc
net start appidsvc
if /i %autoclean% == 2 goto mshutdownreboot
timeout /t 5

:mshutdownreboot
echo %date% %time% : Opti.bat-mshutdownreboot >> %logs%
cls
if /i %autoshutdownreboot% == 0 goto skipshutdownreboot
if /i %autoshutdownreboot% == 1 goto shutdown
if /i %autoshutdownreboot% == 2 goto reboot
if /i %autoshutdownreboot% == 5 goto mshutdownrebootfix


:mshutdownrebootfix
echo Do you want to restart/stop the computer?
set /p choice= R (Reboot) - S (Stop) - 0 (No)
echo %date% %time% : Opti.bat-mshutdownrebootfix %choice% >> %logs%
if /i "%choice%"=="R" goto reboot
if /i "%choice%"=="S" goto shutdown
if /i "%choice%"=="0" goto menu
echo This is not a valid action
timeout /t 5
goto mshutdownreboot


:shutdown
echo %date% %time% : Opti.bat-shutdown >> %logs%
shutdown /s /f /t 15
timeout /t 15
exit

:reboot
echo %date% %time% : Opti.bat-reboot >> %logs%
shutdown /r /f /t 15
timeout /t 15
exit


:skipshutdownreboot
echo %date% %time% : Opti.bat-skipshutdownreboot >> %logs%
echo The computer will not restart.
pause
goto end