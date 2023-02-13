:: 2023-01-29 - Link :                Update link GitHub
:: 2023-01-28 - standalone :          Like old, but standalone

REM if is a admin account, go to menuadmin, if is a user account, go to menuuser
:menu
if %admin%==1 goto menuadmin
if %admin%==0 goto menuuser
goto menu


REM menu for user account
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

REM menu for admin account
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
echo   9. Clean OPTY and delete all files
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
echo   0. Exit
echo.
set /p choice= Enter action:
if "%choice%"=="1" goto optytomopti 
if "%choice%"=="2" goto optytomreenable
if "%choice%"=="3" goto optytomregprofil
if "%choice%"=="9" goto Clean_Opty_Curl
if "%choice%"=="0" goto end
if "%choice%"=="ns" goto nshutdown
if "%choice%"=="oup" goto update_opty
if /i "%choice%"=="M" goto menu
color 0C
echo This is not a valid action
timeout /t 5
goto menu


:optytomopti
set AutoOpti_Shutdown=0
curl -o "Opti.bat" -LJO %GitHubRawLink%Opti.bat
call "Opti.bat"
goto menu


:optytomreenable
curl -o "ReEnable.bat" -LJO %GitHubRawLink%ReEnable.bat
call "ReEnable.bat"
goto menu


:optytomregprofil
curl -o "RegProfil.bat" -LJO %GitHubRawLink%RegProfil.bat
call "RegProfil.bat"
goto menu


:FixUserShellFolderPermissions
curl -o "FixUserShellFolderPermissions.ps1" -LJO %GitHubRawLink%FixUserShellFolderPermissions.ps1
powershell.exe -ExecutionPolicy Bypass -File "%~dp0FixUserShellFolderPermissions.ps1"
pause
goto menu


:nshutdown
echo.
shutdown /a
echo.
echo The computer will not restart.
echo.
timeout /t 10
goto menu


:Clean_Opty_Curl
for /f "delims=" %f in ('dir /b /a-d ^| findstr /v "OPTY.bat"') do @del /f /q "%~dp0%f"
goto end