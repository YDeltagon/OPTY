:: 2023-02-11 - New :                 Add this script


@echo off
REM set variables
set GitHubRawLink=https://raw.githubusercontent.com/YDeltagon/OPTY/master/resources/

REM Check if running as administrator
net session >nul 2>&1
if %errorlevel% == 0 (
    set admin=1
    echo.
    echo  Running as administrator
    echo.
    timeout /t 1
    goto shortcut
) else (
    set admin=0
    echo.
    echo  Not running as administrator
    echo  Please run this script as administrator.
    echo.
    timeout /t 5
    exit
)


REM Check if running from C:\OPTY_by-YannD\AutoOpti + Shutdown.bat if not copy it to C:\OPTY_by-YannD\AutoOpti + Shutdown.bat and create a shortcut on desktop
:shortcut
if not "%~dp0" == "C:\OPTY_by-YannD\" (
    md "C:\OPTY_by-YannD"
    xcopy /y "%~dp0AutoOpti + Shutdown.bat" "C:\OPTY_by-YannD"
    curl -o "%~dp0Shortcut - AutoOpti + Shutdown.ps1" -LJO "%GitHubRawLink%Shortcut - AutoOpti + Shutdown.ps1"
    powershell.exe -ExecutionPolicy Bypass -File "%~dp0Shortcut - AutoOpti + Shutdown.ps1"
    del /f /q "%~dp0Shortcut - AutoOpti + Shutdown.ps1"
    start "" "C:\OPTY_by-YannD\AutoOpti + Shutdown.bat"
    del "%~dp0AutoOpti + Shutdown.bat"
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
    color 20
    echo.
    echo  Ping check successful.
    echo.
    timeout /t 1
    goto Update_AutoOpti_Shutdown
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
timeout /t 3
goto AutoOpti_Shutdown


REM Update AutoOpti + Shutdown.bat
:Update_AutoOpti_Shutdown
curl -o "AutoOpti + Shutdown.bat" -LJO "%GitHubRawLink%AutoOpti + Shutdown.bat"
powershell.exe -ExecutionPolicy Bypass -File "%~dp0AutoOpti + Shutdown.bat"
pause
goto AutoOpti_Shutdown


:AutoOpti_Shutdown
set auto=1
set autoshutdownreboot=1
set AutoOpti_Shutdown=1
curl -o "Opti.bat" -LJO %GitHubRawLink%Opti.bat
if %errorlevel% neq 0 (
  if exist "Opti.bat" (
    call "Opti.bat"
  ) else (
    color 40
    echo  Opti.bat not found. 
    echo   You have no internet connection.
    echo   and you don't have Opti.bat file
    echo.
    echo  Exiting.
    timeout /t 15
    exit
  )
) else (
  call "Opti.bat"
)