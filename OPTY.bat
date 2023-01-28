@echo off

net session >nul 2>&1
if %errorlevel% == 0 (
    set admin=1
    echo.
    echo Running as administrator
    echo.
    timeout /t 1
) else (
    set admin=0
    echo.
    echo Not running as administrator
    echo.
    timeout /t 1
    goto menu
)


if not "%~dp0" == "C:\OPTY_by-YannD\" (
    md "C:\OPTY_by-YannD"
    xcopy /y "%~dp0OPTY.bat" "C:\OPTY_by-YannD"
    start "" "C:\OPTY_by-YannD\OPTY.bat"
    del "%~dp0OPTY.bat"
    exit
)

cd /d "%~dp0"
set current_time="%time:~0,5%"
set current_time="%current_time::=-%"
set logs="%~dp0\logs_%date%_%current_time%.txt"


set current_version=01.0.2


set loop_pinggh=0
color 60
:ping_github_loop
cls
echo.
echo  Check GitHub ping...
echo.
ping -n 1 -l 8 "github.com" | find "TTL="
if %errorlevel%==0 (
    color 20
    echo.
    echo  Ping check successful.
    echo.
    timeout /t 1
    goto update_opty
) else (
    color 40
    echo.
    echo  Ping check failed, retrying...
    echo   error : %errorlevel%
    echo.
    set loop_pinggh=%loop_pinggh%+1
    if %loop_pinggh%==5 goto ping_github_failed
    timeout /t 2
    goto ping_github_loop
)

:ping_github_failed
color c0
echo.
echo  Ping check failed.
echo   %loop_pinggh% failed
echo   error : %errorlevel%
echo.
echo  This script need internet connection to work.
echo.
timeout /t 15
goto end

:update_opty
color 0A
cls
echo.
echo  Check Update for this script...
echo.
for /f "tokens=2 delims=V" %%a in ('curl -s https://api.github.com/repos/YDeltagon/OPTY/releases/latest -L -H "Accept: application/json"^|findstr "tag_name"') do set latest_version=%%a
set latest_version=%latest_version:~0,-2%
if "%current_version%"=="%latest_version%" goto update_not_available
color 0E
cls
echo.
echo  A new version of OPTY.bat is available on GitHub.
echo.
echo.
echo   Current version: v%current_version%
echo   Latest version: v%latest_version%
echo.
echo.
set /p choice=Do you want to update ? Y (Yes) - N (No)
if /i "%choice%"=="Y" goto update_found_and_accepted
if /i "%choice%"=="N" goto update_found_and_not_accepted

:update_found_and_accepted
cls
color 02
echo.
curl -o "%~dp0\new_OPTY.bat" -LJO https://github.com/YDeltagon/OPTY/releases/latest/download/OPTY.bat
echo.
echo The script has been updated to %latest_version%.
echo.
timeout /t 2
move /y new_OPTY.bat OPTY.bat
start "" "%~dp0\OPTY.bat"
exit

:update_found_and_not_accepted
cls
color 04
echo.
echo The script will continue to run with version %current_version%.
echo.
timeout /t 2
goto menu

:update_not_available
color 30
cls
echo.
echo You are running the latest version of this script: %current_version%.
echo.
timeout /t 2
goto menu


:menu
if %admin%==1 goto menuadmin
if %admin%==0 goto menuuser
goto menu

:menuuser
color F1
cls
echo.
echo  WELCOME to OPTY by @YDeltagon (YannD)
echo  User mode
echo.
echo.
echo   a. Repair start/notif/search... (FixUserShellFolderPermissions)
echo.
echo   ns. Stop scheduled shutdown
echo.
echo.
echo.
echo.
echo  If you need to execute all actions
echo  You need to execute this script with a admin account
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
if "%choice%"=="a" goto FixUserShellFolderPermissions
if "%choice%"=="0" goto end
if "%choice%"=="ns" goto nshutdown
if "%choice%"=="oup" goto update_opty
if /i "%choice%"=="M" goto menu
color 0C
echo This is not a valid action
timeout /t 5
goto menu


:menuadmin
color F1
cls
echo.
echo  WELCOME to OPTY by @YDeltagon (YannD)
echo  Admin mode
echo.
echo.
echo   1. MENU - Clean + Optimization
echo   2. MENU - Re-enable option
echo   3. MENU - Register profil option
echo.
echo   ns. Stop scheduled shutdown
echo.
echo.
echo.
echo.
echo   If you need to execute FixUserShellFolderPermissions in a entreprise environnement
echo   Execute with the user account (not admin)
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
if "%choice%"=="1" goto optytomopti
if "%choice%"=="2" goto optytomreenable
if "%choice%"=="3" goto optytomregprofil
if "%choice%"=="0" goto end
if "%choice%"=="ns" goto nshutdown
if "%choice%"=="oup" goto update_opty
if /i "%choice%"=="M" goto menu
color 0C
echo This is not a valid action
timeout /t 5
goto menu


:optytomopti
curl -o "Opti.bat" -LJO https://github.com/YDeltagon/OPTY/releases/latest/download/Opti.bat
call "Opti.bat"
goto menu


:optytomreenable
curl -o "ReEnable.bat" -LJO https://github.com/YDeltagon/OPTY/releases/latest/download/ReEnable.bat
call "ReEnable.bat"
goto menu


:optytomregprofil
curl -o "RegProfil.bat" -LJO https://github.com/YDeltagon/OPTY/releases/latest/download/RegProfil.bat
call "RegProfil.bat"
goto menu


:FixUserShellFolderPermissions
cls
md "C:\Temp"
echo.
cd "C:\Temp"
curl -LJO https://github.com/YDeltagon/OPTY/releases/latest/download/FixUserShellFolderPermissions.ps1
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