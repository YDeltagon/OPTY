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
if /i "%choice%"=="1" set auto=0 & goto mdisenable
if /i "%choice%"=="2" set auto=1 & set autoreboot=0 & goto delete
if /i "%choice%"=="3" set auto=2 & set autoreboot=0 & goto delete
if /i "%choice%"=="2r" set auto=1 & set autoreboot=1 & goto delete
if /i "%choice%"=="3r" set auto=2 & set autoreboot=1 & goto delete
if /i "%choice%"=="M" goto menu
color 0C
echo This is not a valid action
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
del /S /F /Q "%Windir%\Temp"
rd /S /Q "%SystemRoot%\Temp"
REM ========= CCMCache =========
del /F /S /Q "%SystemRoot%\ccmcache\*.*"
rd /S /Q "%SystemRoot%\ccmcache\"
timeout /t 5
REM Creating log file
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