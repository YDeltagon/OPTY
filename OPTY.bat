rem Set the current version of the script
set current_version=01.0.1
rem Set the current folder
cd /d "%~dp0"
rem Set color
color 0C
rem set echo off
@echo off

:ping_github
cls
@echo off

echo Check GitHub ping...
set "url=github.com"

:loop
ping %url% | find "TTL="
if %errorlevel%==0 (
    echo Update check successful.
    goto update_opty
) else (
    echo Update check failed, retrying...
    timeout /t 5
    goto loop
)

:update_opty
echo Check Update for this script...

rem Get the latest version from GitHub
for /f "tokens=2 delims=V" %%a in ('curl -s https://api.github.com/repos/YDeltagon/OPTY/releases/latest -L -H "Accept: application/json"^|findstr "tag_name"') do set latest_version=%%a
set latest_version=%latest_version:~0,-2%

rem Compare the versions and prompt the user to update if a new version is available
if "%current_version%"=="%latest_version%" goto update_not_available
goto update_available

:update_available
color 0C
cls
echo.
echo  A new version of OPTY.bat is available on GitHub.
echo  YDeltagon\OPTY\releases\latest\download\OPTY.bat
echo.
echo.
echo   Current version: v%current_version%
echo   Latest version: v%latest_version%
echo.
echo.
set /p choice=Do you want to update ? Y (Yes) - N (No)

if /i "%choice%"=="Y" cls & color 0A & echo. & curl -o new_OPTY.bat -LJO https://github.com/YDeltagon/OPTY/releases/latest/download/OPTY.bat & echo The script has been updated to %latest_version%. & echo Please restart the script to use the new version. & timeout /t 15 & move /y new_OPTY.bat OPTY.bat & exit
if /i "%choice%"=="N" cls & color 09 & echo. & echo The script will continue to run with version %current_version%. & timeout /t 15 & goto menu

:update_not_available
color 0A
cls
echo.
echo You are running the latest version of this script: %current_version%.
echo.
timeout /t 15
goto menu


:menu
color F1
cls
echo.
echo  WELCOME to OPTY by @YDeltagon (YannD)
echo.
echo.
echo   1. MENU - Clean + Optimization
echo   2. MENU - Re-enable option
echo   3. MENU - Register profil option
echo.
echo   a. Repair start/notif/search...
echo.
echo   ns. Stop scheduled shutdown
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
echo.
echo   0. Exit
echo.
set /p choice= Enter action:
if "%choice%"=="1" goto mopti
if "%choice%"=="2" goto mreenable
if "%choice%"=="3" goto mregprofil
if "%choice%"=="a" goto FixUserShellFolderPermissions
if "%choice%"=="0" goto end
if "%choice%"=="ns" goto nshutdown
if "%choice%"=="oup" goto update_opty
if /i "%choice%"=="M" goto menu
color 0C
echo This is not a valid action
timeout /t 5
goto menu


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
echo  If you want reboot after autoopti, type "r" after the number
echo.                        "2r" "3r"
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
echo.
echo   M. Menu
echo   0. Exit
echo.
set /p choice= Enter action:
if /i "%choice%"=="1" set auto=0 & goto disenable
if /i "%choice%"=="2" set auto=1 & set autoreboot=0 & goto delete
if /i "%choice%"=="3" set auto=2 & set autoreboot=0 & goto delete
if /i "%choice%"=="2r" set auto=1 & set autoreboot=1 & goto delete
if /i "%choice%"=="3r" set auto=2 & set autoreboot=1 & goto delete
if /i "%choice%"=="M" goto menu
color 0C
echo This is not a valid action
timeout /t 5
goto mopti


:mreenable
color F2
cls
echo.
echo  WELCOME to OPTY by @YDeltagon (YannD)
echo    Choose the option to re-enable:
echo.
echo   1. Start office update
echo   2. Enable chrome update (if you compagny use GPO [Register])
echo   3. Enable windows update (if you compagny use GPO [Register])
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
echo.
echo.
echo.
echo.
echo   M. Menu
echo   0. Exit
echo.
set /p choice= Enter action:
if "%choice%"=="1" goto office_update
if "%choice%"=="2" goto enable_google_update
if "%choice%"=="3" goto enable_windows_update
if "%choice%"=="m" goto menu
color 0C
echo This is not a valid action
timeout /t 5
goto mreenable


:mregprofil
color FC
cls
echo.
echo  WELCOME to OPTY by @YDeltagon (YannD)
echo    Choose your desired profil:
echo.
echo   1. Windows vanilla
echo   2. Gaming
echo   3. Gaming + App
echo   4. Server
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
echo.
echo.
echo.
echo   M. Menu
echo   0. Exit
echo.
set /p choice= Enter action:
if "%choice%"=="1" goto regprofil-vanilla
if "%choice%"=="2" goto regprofil-gaming
if "%choice%"=="3" goto regprofil-gamingapp
if "%choice%"=="4" goto regprofil-server
if "%choice%"=="m" goto menu
color 0C
echo This is not a valid action
timeout /t 5
goto mregprofil

:regprofil-vanilla
cls
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 00000014 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Gpu Priority" /t REG_DWORD /d 00000008 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "Normal" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 00000002 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "Medium" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 0000003 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d 0000003 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpAckFrequency" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TCPNoDelay" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpDelAckTicks" /t REG_DWORD /d 00000001 /f
pause
goto menu

:regprofil-gaming
cls
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Gpu Priority" /t REG_DWORD /d 00000008 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 00000006 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "Medium" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d 00000000 /
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpAckFrequency" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TCPNoDelay" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpDelAckTicks" /t REG_DWORD /d 00000000 /f
pause
goto menu

:regprofil-gamingapp
cls
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Gpu Priority" /t REG_DWORD /d 00000008 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 00000002 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpAckFrequency" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TCPNoDelay" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpDelAckTicks" /t REG_DWORD /d 00000000 /f
pause
goto menu

:regprofil-server
cls
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 00000025 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Gpu Priority" /t REG_DWORD /d 00000008 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 00000002 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 00000003 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d 00000003 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpAckFrequency" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TCPNoDelay" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpDelAckTicks" /t REG_DWORD /d 00000000 /f
pause
goto menu


:disenable
color F4
cls
echo.
echo  WELCOME to OPTY by @YDeltagon (YannD)
echo  Choose a option to Disable/Enable :
echo.
echo  Add "+" or "-" in front of an action + activate or - deactivate it (example "-1" to deactivate animations)
echo.
echo   1. Animation
echo   2. Window content while moving
echo.
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
echo   N. Next
echo   M. Menu
echo   0. Exit
echo.
set /p choice= Enter action:
if /i "%choice%"=="-1" reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuAnimate" /t REG_SZ /d "0" /f & pause & goto disenable
if /i "%choice%"=="+1" reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuAnimate" /t REG_SZ /d "1" /f & pause & goto disenable
if /i "%choice%"=="-2" reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "0" /f & pause & goto disenmdeleteable
if /i "%choice%"=="+2" reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "1" /f & pause & goto disenable
if /i "%choice%"=="-fad" fsutil behavior set disablelastaccess 1 & pause & goto disenable
if /i "%choice%"=="+fad" fsutil behavior set disablelastaccess 0 & pause & goto disenable
if /i "%choice%"=="-hbn" powercfg.exe /hibernate off & echo Disable hibernate & pause & goto disenable
if /i "%choice%"=="+hbn" powercfg.exe /hibernate on & echo Enable hibernate & pause & goto disenable
if /i "%choice%"=="n" goto mclean
if /i "%choice%"=="M" goto menu
cls
color 0C
echo This is not a valid action
timeout /t 5
goto disenable


:mclean
cls
echo Execute clean disk - /cleanmgr ?
set /p choice= Y (Yes) - N (No)
if /i "%choice%"=="Y" goto clean
if /i "%choice%"=="N" goto mdelete
if /i "%choice%"=="M" goto menu
echo This is not a valid action
timeout /t 5
goto mclean

:clean
echo Cleanmgr...
cleanmgr /sagerun:65535
timeout /t 5
if /i %auto% == 1 goto delete
if /i %auto% == 2 goto delete


:mdelete
cls
echo Do you want to delete temporary files - /del ?
set /p choice= Y (Yes) - N (No)
if /i "%choice%"=="Y" goto delete
if /i "%choice%"=="N" goto mdism
if /i "%choice%"=="M" goto menu
echo This is not a valid action
timeout /t 5
goto mdelete

:delete
REM ========= Temp =========
setlocal
for /D %%i in ("C:\Users\*") do (
   echo %%i
   del /S /F /Q "%%i\AppData\Local\Temp\*"
)
endlocal
REM del /S /F /Q "%temp%"
del /S /F /Q "%Windir%\Temp"
rd /S /Q "%SystemRoot%\Temp"
REM ========= CCMCache =========
del /F /S /Q "%SystemRoot%\ccmcache\*.*"
rd /S /Q "%SystemRoot%\ccmcache\"
timeout /t 5
if /i %auto% == 1 goto wupdate
if /i %auto% == 2 goto dism


:mdism
cls
echo Do you want to dismy the integrity of the Windows image and correct problems - /Dism ?
set /p choice= Y (Yes) - N (No)
if /i "%choice%"=="Y" goto dism
if /i "%choice%"=="N" goto msfc
if /i "%choice%"=="M" goto menu
echo This is not a valid action
timeout /t 5
goto mdism

:dism
Dism /Online /Cleanup-Image /ScanHealth
Dism /Online /Cleanup-Image /CheckHealth
Dism /Online /Cleanup-Image /RestoreHealth
timeout /t 5
if /i %auto% == 2 goto sfc


:msfc
cls
echo Do you want to verify the integrity of system files and fix problems - /sfc ?
set /p choice= Y (Yes) - N (No)
if /i "%choice%"=="Y" goto sfc
if /i "%choice%"=="N" goto mwupdate
if /i "%choice%"=="M" goto menu
echo This is not a valid action
timeout /t 5
goto msfc

:sfc
sfc /scannow
timeout /t 5
if /i %auto% == 2 goto wupdate


:mwupdate
cls
echo Do you want to update Windows - /usoclient ?
set /p choice= Y (Yes) - N (No)
if /i "%choice%"=="Y" goto wupdate
if /i "%choice%"=="N" goto mwupdate2
if /i "%choice%"=="M" goto menu
echo This is not a valid action
timeout /t 5
goto mwupdate

:wupdate
usoclient StartScan
usoclient RefreshSettings
usoclient StartInstall
timeout /t 5
if /i %auto% == 1 goto wupdate2
if /i %auto% == 2 goto wupdate2


:mwupdate2
cls
echo Do you want to update software - /winget ?
set /p choice= Y (Yes) - N (No)
if /i "%choice%"=="Y" goto wupdate2
if /i "%choice%"=="N" goto mdefrag
if /i "%choice%"=="M" goto menu
echo This is not a valid action
timeout /t 5
goto mwupdate2

:wupdate2
winget upgrade --all --include-unknown
timeout /t 5
if /i %auto% == 1 goto reboot
if /i %auto% == 2 goto defrag


:mdefrag
cls
echo Do you want to defragment HDD or optimize SSD - /defrag ?
set /p choice= Y (Yes) - N (No)
if /i "%choice%"=="Y" goto defrag
if /i "%choice%"=="N" goto mchkdsk
if /i "%choice%"=="M" goto menu
echo This is not a valid action
timeout /t 5
goto mdefrag

:defrag
defrag /C /O /U /V /H
timeout /t 5
if /i %auto% == 2 goto defrag


:mchkdsk
cls
echo Do you want to check the integrity of hard drives and fix any problems - /CHKDSK ?
set /p choice= Y (Yes) - N (No)
if /i "%choice%"=="Y" goto chkdsk
if /i "%choice%"=="N" goto mreboot
if /i "%choice%"=="M" goto menu
echo This is not a valid action
timeout /t 5
goto mchkdsk

:chkdsk
CHKDSK /f /r
timeout /t 5
if /i %auto% == 2 goto reboot


:mreboot
cls
echo Do you want to restart the computer?
set /p choice= Y (Yes) - N (No)
if /i "%choice%"=="Y" goto reboot
if /i "%choice%"=="N" goto menu
if /i "%choice%"=="M" goto menu
echo This is not a valid action
timeout /t 5
goto mreboot

:reboot
if /i %autoreboot% == 0 goto skipreboot
shutdown /s /f /t 20
timeout /t 10
goto end


:skipreboot
echo The computer will not restart.
pause
goto end


:dcu
cls
echo.
echo Dell update...
"C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe" /scan
"C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe" /applyUpdates
pause
goto menu


:office_update
cls
echo Microsoft Office update...
"C:\Program Files\Common Files\microsoft shared\ClickToRun\OfficeC2RClient.exe" /update user
pause
goto mreenable


:enable_google_update
cls
taskkill /f /im chrome.exe
cls
REG ADD "HKLM\SOFTWARE\Policies\Google\Update" /v "UpdateDefault" /t REG_DWORD /d 1 /f
start chrome.exe
echo.
echo Go to .../help/about.
echo This launches the Update
echo.
pause
goto mreenable


:enable_windows_update
cls
Net stop wuauserv
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "SetDisableUXWUAccess" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 0 /f
echo.
Net start wuauserv
pause
goto mreenable


:FixUserShellFolderPermissions
cls
md "C:\Temp"
echo.
cd "C:\Temp"
curl -LJO https://github.com/YDeltagon/OPTY/blob/master/resources/FixUserShellFolderPermissions.ps1
echo.
echo  Set username with domain 
set /p username= domain\username :
runas /user:%username% "powershell.exe -ExecutionPolicy Bypass -File C:\Temp\FixUserShellFolderPermissions.ps1"
pause
echo.
del /f /q "C:\Temp\FixUserShellFolderPermissions.ps1"
cd /d "%~dp0"
timeout /t 5
goto menu


:nshutdown
echo.
shutdown /a
timeout /t 10
goto menu


:end
color F2
cls
echo.
echo.
echo  Thanks for using my script
echo     @YDeltagon (YannD)
echo.
timeout /t 15
exit