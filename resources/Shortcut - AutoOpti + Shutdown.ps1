# Create a new shortcut object for admin mode
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("C:\Users\Public\Desktop\AutoOpti + Shutdown (Admin).lnk")

# Set the shortcut target path and working directory
$Shortcut.TargetPath = "C:\Windows\System32\cmd.exe"
$Shortcut.Arguments = "/c start """" /D ""C:\OPTY_by-YannD"" /B ""AutoOpti + Shutdown.bat"""
$Shortcut.WorkingDirectory = "C:\OPTY_by-YannD\"

# Set the shortcut to run as admin
$Shortcut.Hotkey = "CTRL+SHIFT+ALT+A"
$Shortcut.IconLocation = "C:\Windows\System32\cmd.exe, 0"
$Shortcut.Run = "powershell.exe"

# Save the shortcut
$Shortcut.Save()
