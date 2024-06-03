:: 2024-06-03  :                      Update logs fonction
:: 2024-03-21  :                      Work if not connected, but local
:: 2023-11-23  :                      Add Logs
:: Change-logs :                      Found on Readme.md GitHub


@echo off
REM set variables
set current_version=01.0.7
set GitHubRawLink=https://raw.githubusercontent.com/YDeltagon/OPTY/master/resources/
set GitHubLatestLink=https://github.com/YDeltagon/OPTY/releases/latest/download/
REM Set variables for logs
cd /d "%~dp0"
set current_time="%time:~0,5%"
set current_time="%current_time::=-%"
set logs="%~dp0\logs_%date%_%current_time%.txt"

REM Check if running as administrator
net session >nul 2>&1
if %errorlevel% == 0 (
    echo %date% %time% : Admin >> %logs%
    set admin=1
    echo.
    echo Running as administrator
    echo.
    timeout /t 1
    goto shortcut
) else (
    echo %date% %time% : User >> %logs%
    set admin=0
    echo.
    echo Not running as administrator
    echo.
    timeout /t 1
    goto ping_github
)



REM Check if running from C:\OPTY_by-YannD\OPTY.bat if not copy it to C:\OPTY_by-YannD\OPTY.bat and create a shortcut on desktop
:shortcut
if not "%~dp0" == "C:\OPTY_by-YannD\" (
    echo %date% %time% : Creat shurtcut >> %logs%
    md "C:\OPTY_by-YannD"
    xcopy /y %~dp0OPTY.bat C:\OPTY_by-YannD
    curl -o "%~dp0Shortcut_OPTY.ps1" -LJO %GitHubRawLink%Shortcut_OPTY.ps1
    powershell.exe -ExecutionPolicy Bypass -File "%~dp0Shortcut_OPTY.ps1"
    del /f /q "%~dp0Shortcut_OPTY.ps1"
    start "" "C:\OPTY_by-YannD\OPTY.bat"
    del "%~dp0OPTY.bat"
    exit
)



REM Check if internet connection is available and ping github.com
:ping_github
set loop_pinggh=0
color 60
:ping_github_loop
cls
echo.
echo  Check GitHub ping...
echo.
ping -n 1 -l 8 github.com | find "TTL="
if %errorlevel%==0 (
    echo %date% %time% : Ping GitHub ok >> %logs%
    color 20
    echo.
    echo  Ping check successful.
    echo.
    timeout /t 1
    goto update_opty
) else (
    echo %date% %time% : Ping GitHub ko for %loop_pinggh% time >> %logs%
    color 40
    echo.
    echo  Ping check failed, retrying...
    echo   error : %errorlevel%
	echo   ko : %loop_pinggh% "(max : 5)"
    echo.
    set /a loop_pinggh=%loop_pinggh%+1
    if %loop_pinggh%==5 goto ping_github_failed
    timeout /t 2
    goto ping_github_loop
)


REM If ping failed 5 times, exit
:ping_github_failed
cls
color c0
echo.
echo  Ping check failed.
echo   %loop_pinggh% failed
echo   error : %errorlevel%
echo.
echo  This script need internet connection to work properly.
echo.
timeout /t 10
goto update_not_available


REM Update OPTY.bat
:update_opty
color 0A
cls
echo.
echo  Check Update for this script...
echo.
for /f "tokens=2 delims=V" %%a in ('curl -s https://api.github.com/repos/YDeltagon/OPTY/releases/latest -L -H "Accept: application/json"^|findstr "tag_name"') do set latest_version=%%a
set latest_version=%latest_version:~0,-2%
if "%current_version%"=="%latest_version%" goto update_not_available
echo %date% %time% : Update found >> %logs%
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

REM If user accept update, download new OPTY.bat and replace the old one
:update_found_and_accepted
echo %date% %time% : Update found and accepted >> %logs%
cls
color 02
echo.
curl -o "%~dp0\new_OPTY.bat" -LJO %GitHubLatestLink%OPTY.bat
echo.
echo The script has been updated to %latest_version%.
echo.
timeout /t 1
move /y new_OPTY.bat OPTY.bat
start "" "%~dp0\OPTY.bat"
exit

REM If user don't accept update, exit
:update_found_and_not_accepted
echo %date% %time% : Update found and not accepted >> %logs%
cls
color 04
echo.
echo The script will continue to run with version %current_version%.
echo.
timeout /t 1
curl -o "Menu.bat" -LJO %GitHubRawLink%Menu.bat
call "Menu.bat"


REM If no update is available, continue
:update_not_available
echo %date% %time% : No update >> %logs%
color 30
cls
echo.
echo You are running the latest version of this script: %current_version%.
echo.
timeout /t 1
curl -o "Menu.bat" -LJO %GitHubRawLink%Menu.bat
call "Menu.bat"


:end
echo %date% %time% : End >> %logs%
color F2
cls
echo.
echo.
echo.
echo  Thanks for using my script
echo     @YDeltagon (YannD)
echo.
echo.
echo.
timeout /t 15
exit