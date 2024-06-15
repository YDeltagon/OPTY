:: 2024-03-21 - Menu :                Only-NumLock
:: 2023-09-24 - Fix :                 Fix regprofil not work
:: 2023-01-29 - Link :                Update link GitHub
:: 2023-01-28 - standalone :          Like old, but standalone

REM if is a admin account, go to menuadmin, if is a user account, go to menuuser
:menu
echo %date% %time% : Menu.bat-admin %admin% >> %logs%
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
echo   1. Repair start/notif/search... (FixUserShellFolderPermissions)
echo.
echo.
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
echo %date% %time% : Menu.bat-menuuser %choice% >> %logs%
if "%choice%"=="1" goto FixUserShellFolderPermissions
if "%choice%"=="0" goto end
if "%choice%"=="." goto update_opty
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
echo.
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
echo %date% %time% : Menu.bat-menuadmin "%choice%" >> %logs%
if "%choice%"=="1" goto mopti
if "%choice%"=="2" goto mreenable
if "%choice%"=="3" goto mregprofil
if "%choice%"=="9" goto Clean_Opty_Curl
if "%choice%"=="0" goto end
if "%choice%"=="." goto update_opty
if "%choice%"=="-" goto mupdate_perso
color 0C
echo This is not a valid action
timeout /t 5
goto menu


:mopti
echo %date% %time% : Menu.bat-mopti >> %logs%
set AutoOpti_Shutdown=0
curl -o "Opti.bat" -LJO %GitHubRawLink%Opti.bat
call "Opti.bat"
goto menu


:mreenable
echo %date% %time% : Menu.bat-mreenable >> %logs%
curl -o "ReEnable.bat" -LJO %GitHubRawLink%ReEnable.bat
call "ReEnable.bat"
goto menu


:mregprofil
echo %date% %time% : Menu.bat-mregprofil >> %logs%
curl -o "RegProfil.bat" -LJO %GitHubRawLink%RegProfil.bat
call "RegProfil.bat"
goto menu


:FixUserShellFolderPermissions
echo %date% %time% : Menu.bat-FixUserShellFolderPermissions >> %logs%
curl -o "FixUserShellFolderPermissions.ps1" -LJO %GitHubRawLink%FixUserShellFolderPermissions.ps1
powershell.exe -ExecutionPolicy Bypass -File "%~dp0FixUserShellFolderPermissions.ps1"
pause
goto menu


:nshutdown
echo %date% %time% : Menu.bat-nshutdown >> %logs%
echo.
shutdown /a
echo.
echo The computer will not restart.
echo.
timeout /t 10
goto menu


:Clean_Opty_Curl
echo %date% %time% : Menu.bat-Clean_Opty_Curl >> %logs%
for /f "delims=" %f in ('dir /b /a-d ^| findstr /v "OPTY.bat"') do @del /f /q "%~dp0%f"
goto end


:mupdate_perso
echo %date% %time% : Menu.bat-mupdate_perso >> %logs%
curl -o "MIDIOFF.mp3" -LJO %GitHubRawLink%MIDIOFF.mp3
curl -o "MIDION.mp3" -LJO %GitHubRawLink%MIDION.mp3
pause