:: 2023-01-27 - add :                 Add some sc config
:: 2023-01-27 - standalone :          Like old, but standalone

:mreenable
color FC
cls
echo.
echo  WELCOME to OPTY by @YDeltagon (YannD) test
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
:: Multimedia
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 00000014 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Gpu Priority" /t REG_DWORD /d 00000008 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "Normal" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 00000002 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "Medium" /f
:: Memory
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 0000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d 0000000 /f
:: Tcpip
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpAckFrequency" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TCPNoDelay" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpDelAckTicks" /t REG_DWORD /d 00000001 /f
:: Graphics
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLevel" /t REG_DWORD /d 00000002 /f
:: Driver
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 00000001 /f
:: DVR
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_SZ /d "00000001" /f
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 1 /f
:: Power
powercfg /h on
timeout /t 5
goto regsc-vanilla

:regprofil-server
cls
echo.
:: Multimedia
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 00000025 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Gpu Priority" /t REG_DWORD /d 00000008 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 00000002 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
:: Memory
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d 00000000 /f
:: Tcpip
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpAckFrequency" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TCPNoDelay" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpDelAckTicks" /t REG_DWORD /d 00000000 /f
:: Graphics
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLevel" /t REG_DWORD /d 00000002 /f
:: Driver
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 00000001 /f
:: DVR
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_SZ /d "00000000" /f
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 00000000 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 00000000 /f
:: Mouse Settings - Current User
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "SmoothMouseXCurve" /t REG_BINARY /d "0000000000CCCCC0809919406626003333" /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "SmoothMouseYCurve" /t REG_BINARY /d "0000000000003800000070000000A8000000E000" /f
:: Mouse Settings - Default User
reg add "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f
reg add "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f
reg add "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f
:: Power
powercfg /h off
timeout /t 5
goto regsc-gaming

:regprofil-gamingapp
cls
echo.
:: Multimedia
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Gpu Priority" /t REG_DWORD /d 00000008 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 00000002 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
:: Memory
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d 00000000 /f
:: Tcpip
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpAckFrequency" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TCPNoDelay" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpDelAckTicks" /t REG_DWORD /d 00000000 /f
:: Graphics
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLevel" /t REG_DWORD /d 00000002 /f
:: Driver
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 00000000 /f
:: DVR
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_SZ /d "00000000" /f
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 00000000 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 00000000 /f
:: Mouse Settings - Current User
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "SmoothMouseXCurve" /t REG_BINARY /d "0000000000CCCCC0809919406626003333" /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "SmoothMouseYCurve" /t REG_BINARY /d "0000000000003800000070000000A8000000E000" /f
:: Mouse Settings - Default User
reg add "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f
reg add "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f
reg add "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f
:: Power
powercfg /h off
timeout /t 5
goto regsc-gaming

:regprofil-gaming
cls
echo.
:: Multimedia
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Gpu Priority" /t REG_DWORD /d 00000008 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 00000006 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
:: Memory
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d 00000000 /
:: Tcpip
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpAckFrequency" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TCPNoDelay" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpDelAckTicks" /t REG_DWORD /d 00000000 /f
:: Graphics
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLevel" /t REG_DWORD /d 00000000 /f
:: Driver
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 00000000 /f
:: DVR
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_SZ /d "00000000" /f
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 00000000 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 00000000 /f
:: Mouse Settings - Current User
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "SmoothMouseXCurve" /t REG_BINARY /d "0000000000CCCCC0809919406626003333" /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "SmoothMouseYCurve" /t REG_BINARY /d "0000000000003800000070000000A8000000E000" /f
:: Mouse Settings - Default User
reg add "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f
reg add "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f
reg add "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f
:: Power
powercfg /h off
timeout /t 5
goto regsc-gaming

:regsc-vanilla
sc stop WSearch
sc stop SysMain
sc stop WerSvc
sc stop Spooler
sc stop DPS
sc stop TabletInputService
sc config "WSearch" start= auto
sc config "SysMain" start= auto
sc config "WerSvc" start= auto
sc config "Spooler" start= auto
sc config "DPS" start= auto
sc config "TabletInputService" start= auto
pause
goto menu

:regsc-gaming
sc stop WSearch
sc stop SysMain
sc stop WerSvc
sc stop Spooler
sc stop DPS
sc stop TabletInputService
sc config "WSearch" start= disabled
sc config "SysMain" start= disabled
sc config "WerSvc" start= disabled
sc config "Spooler" start= disabled
sc config "DPS" start= disabled
sc config "TabletInputService" start= disabled
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
powercfg.cpl
pause
goto menu