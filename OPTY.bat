:: Change-logs :                      Found on Readme.md GitHub

@echo off
set current_version=01.0.3

REM Check if running as administrator
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
    curl -o "Menu.bat" -LJO https://github.com/YDeltagon/OPTY/releases/download/V%current_version%/Menu.bat
    call "Menu.bat"
)


REM Check if running from C:\OPTY_by-YannD\OPTY.bat if not copy it to C:\OPTY_by-YannD\OPTY.bat and create a shortcut on desktop
if not "%~dp0" == "C:\OPTY_by-YannD\" (
    md "C:\OPTY_by-YannD"
    xcopy /y "%~dp0OPTY.bat" "C:\OPTY_by-YannD"
    curl -o "%~dp0Shortcut.ps1" -LJO https://github.com/YDeltagon/OPTY/releases/download/V%current_version%/Shortcut.ps1
    powershell.exe -ExecutionPolicy Bypass -File "%~dp0Shortcut.ps1"
    del /f /q "%~dp0Shortcut.ps1"
    start "" "C:\OPTY_by-YannD\OPTY.bat"
    del "%~dp0OPTY.bat"
    exit
)


REM Set variables for logs
cd /d "%~dp0"
set current_time="%time:~0,5%"
set current_time="%current_time::=-%"
set logs="%~dp0\logs_%date%_%current_time%.txt"


REM Check if internet connection is available and ping github.com
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


REM If ping failed 5 times, exit
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
cls
color 02
echo.
curl -o "%~dp0\new_OPTY.bat" -LJO https://github.com/YDeltagon/OPTY/releases/latest/download/OPTY.bat
echo.
echo The script has been updated to %latest_version%.
echo.
timeout /t 1
move /y new_OPTY.bat OPTY.bat
start "" "%~dp0\OPTY.bat"
exit

REM If user don't accept update, exit
:update_found_and_not_accepted
cls
color 04
echo.
echo The script will continue to run with version %current_version%.
echo.
timeout /t 1
curl -o "Menu.bat" -LJO https://github.com/YDeltagon/OPTY/releases/download/V%current_version%/Menu.bat
call "Menu.bat"


REM If no update is available, continue
:update_not_available
color 30
cls
echo.
echo You are running the latest version of this script: %current_version%.
echo.
timeout /t 1
curl -o "Menu.bat" -LJO https://github.com/YDeltagon/OPTY/releases/download/V%current_version%/Menu.bat
call "Menu.bat"


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