# FixUserShellFolderPermissions.ps1 - by nicolas.dietrich@microsoft.com - 20220106
# Microsoft Customer Support and Services Helper Script
# Checks 'User Shell Folders' registry ACLs, if All Application Packages isn't granted then restore the inheritance, and finally registers back every app
# Does not require Admin rights, need to be run from the affected user context thus non-elevated
# This script is provided AS IS, no support nor warranty of any kind is provided for its usage.
$AAP_SID = 'S-1-15-2-1'
$USERS_SHELL_FOLDERS = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders'
$APPX_ALL_USER_STORE = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore'

$aap_displayname = (New-Object System.Security.Principal.SecurityIdentifier($AAP_SID)).Translate([System.Security.Principal.NTAccount])
$acl = (Get-Acl $USERS_SHELL_FOLDERS)
if (($acl.Access | where IdentityReference -eq $aap_displayname)) { Write-Host "User Shell Folders registry permission are correct." }
else 
{ 
    Write-Host "User Shell Folders registry permission are incorrect, fixing them..."

    # Restores ACL inheritance from parent (which in our cases always appeared to keep All Application Packages granted)
    $acl.Access | %{$acl.RemoveAccessRule($_)}   # Clearing the ACL to avoid duplicated ACEs 
    $acl.SetAccessRuleProtection($false, $false) # Enabling inheritance 
    $acl | Set-Acl -Path $USERS_SHELL_FOLDERS    # Now sets the repaired ACL
    Write-Host "Registry permission fixed!" 

    Write-Host "Re-registering every app..." 
    # Re-Registering apps
    $Apps = Get-ChildItem -Path $($APPX_ALL_USER_STORE + "\InboxApplications"), $($APPX_ALL_USER_STORE + "\Applications")
    ForEach($key in $apps)
    {
        # Ensure every app dependencies is correctly registered for the user
        $deps = @{} ; Get-ChildItem -Path $Key.PSPath | %{ $deps[$(Get-ItemProperty $_.PSPath).PSChildName] = $((Get-ItemProperty $_.PSPath).Path) }
        ForEach($dep in $deps.Keys) 
        { 
            if (!(Get-AppxPackage | where {$_.PackageFullName -eq $dep})) 
            { Add-AppxPackage -DisableDevelopmentMode -Register -Path ($deps[$dep] -replace "%SYSTEMDRIVE%",$env:SYSTEMDRIVE) }
        }

        # Now, register the main app with all dependencies already there
        Add-AppxPackage -DisableDevelopmentMode -Register -Path ((Get-ItemProperty $key.PsPath).path -replace "%SYSTEMDRIVE%",$env:SYSTEMDRIVE)
    }
    Write-Host "The issue should be fixed now!"
}
Read-Host -Prompt "Press Enter to exit"