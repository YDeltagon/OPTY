:: 2024-03-21 - Menu :                Only-NumLock
:: 2023-01-27 - standalone :          Like old, but standalone

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
echo   0. Menu
echo.
echo.
set /p choice= Enter action:
if "%choice%"=="1" goto office_update
if "%choice%"=="2" goto enable_google_update
if "%choice%"=="3" goto enable_windows_update
if "%choice%"=="0" goto menu
color 0C
echo This is not a valid action
timeout /t 5
goto mreenable


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
