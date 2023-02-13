# 2023-01-27 - standalone :          Standalone

# Create a new shortcut object for user mode
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("C:\Users\Public\Desktop\AutoOptiShutdown (admin).lnk")

# Set the shortcut target path and working directory
$Shortcut.TargetPath = "C:\OPTY_by-YannD\AutoOptiShutdown.bat"
$Shortcut.WorkingDirectory = "C:\OPTY_by-YannD\"

# Save the shortcut
$Shortcut.Save()