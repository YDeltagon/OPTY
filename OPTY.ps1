Add-Type -AssemblyName System.Windows.Forms

# Get the local version of the script
$currentVersion = "V01.0.4"

# Create a form for the loading screen
$loadingForm = New-Object System.Windows.Forms.Form
$loadingForm.Width = 250
$loadingForm.Height = 100
$loadingForm.Text = "Loading..."

# Create a label to display the status of the update check
$label = New-Object System.Windows.Forms.Label
$label.Text = "Checking for updates..."
$label.TextAlign = "MiddleCenter"
$loadingForm.Controls.Add($label)

# Show the loading screen
$loadingForm.Show()

Write-Host "Checking if user can access GitHub..."

# Check if the user can access GitHub
if (Test-Connection github.com) {
    # Access to GitHub is available, continue the update check
    $label.Text = "Access to GitHub available."
    Write-Host "Access to GitHub available."
} else {
    # Access to GitHub is not available, display an error message
    $loadingForm.Close()
    [System.Windows.Forms.MessageBox]::Show("Unable to access GitHub. Please check your internet connection and try again.")
    Write-Host "Unable to access GitHub."
    exit
}

Write-Host "Getting the latest version available on GitHub..."

# Get the latest version available on GitHub
$latestVersion = Invoke-RestMethod -Uri "https://api.github.com/repos/YDeltagon/OPTY/releases/latest" | Select-Object -ExpandProperty tag_name

# Check if the latest version is different from the current version
if ($latestVersion -ne $currentVersion) {
    $label.Text = "Update available."
    Write-Host "Update available."

    # Download the latest version from GitHub
    $client = New-Object System.Net.WebClient
    $client.DownloadFile("https://github.com/YDeltagon/OPTY/releases/latest/download/OPTY.ps1", "C:\OPTY_by-YannD\OPTY.ps1")
    
    # Restart the script with the latest version
    Write-Host "Restarting the script with the latest version..."
    & "C:\OPTY_by-YannD\OPTY.ps1"
    $loadingForm.Close()
    exit
} else {
    $label.Text = "No update available. Start..."
    Write-Host "No update available. Start..."
    $loadingForm.Close()
}


# Create a new window
$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(475, 300)
$form.Text = "OPTY $currentVersion by YannD (@YDeltagon)"


# Create a button to check for updates
$updateButton = New-Object System.Windows.Forms.Button
$updateButton.Location = New-Object System.Drawing.Point(10, 220)
$updateButton.Size = New-Object System.Drawing.Size(200, 30)

if ($currentVersion -eq $latestVersion) {
    $imageUrl = "https://images.vexels.com/media/users/3/236565/isolated/lists/a4b039656d8bb2c49ea1ef865bd9cdd7-simple-cartoon-cute-cat.png"
    $image = [System.Drawing.Image]::FromStream((Invoke-WebRequest -Uri $imageUrl).RawContentStream)
    $updateButton.Text = "No updates"
    $updateButton.BackColor = "Green"
} else {
    $imageUrl = "https://cdn3.emoji.gg/emojis/2443_loading_cat_meme.png"
    $image = [System.Drawing.Image]::FromStream((Invoke-WebRequest -Uri $imageUrl).RawContentStream)
    $updateButton.Text = "Update available"
    $updateButton.BackColor = "Red"
}

# Add an image to the form
# $imageUrl = "https://cdn3.emoji.gg/emojis/2443_loading_cat_meme.png"
$image = [System.Drawing.Image]::FromStream((Invoke-WebRequest -Uri $imageUrl).RawContentStream)
$imageBox = New-Object System.Windows.Forms.PictureBox
$imageBox.Location = New-Object System.Drawing.Point(10, 10)
$imageBox.Size = New-Object System.Drawing.Size(200, 200)
$imageBox.Image = $image
$imageBox.SizeMode = "Zoom"
$form.Controls.Add($imageBox)

# Add a button to update the script
$updateButton.Add_Click({
    if ($currentVersion -eq $latestVersion) {
        [System.Windows.Forms.MessageBox]::Show("You are running the latest version of the script.", "No updates available", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    } else {
        # Ask the user if they want to update
        $dialogResult = [System.Windows.Forms.MessageBox]::Show("A new version of the script is available on GitHub. You are running version $currentVersion, the latest version is $latestVersion. Do you want to update?", "Updates available", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Information)
        
        if ($dialogResult -eq "Yes") {
            # Download the new version of the script
            $latestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/YDeltagon/OPTY/releases/latest"
            $assets = $latestRelease.assets
            $latestAssetUrl = $assets.browser_download_url[0]

            # Download the latest release
            Invoke-WebRequest -Uri $latestAssetUrl -OutFile "OPTY.ps1"

            # Replace the existing script with the new version
            Move-Item -Path "OPTY.ps1" -Destination "C:\OPTY_by-YannD\OPTY.ps1" -Force

            # Restart the script
            & "C:\OPTY_by-YannD\OPTY.ps1"
            exit
        }
        else {
            # Inform the user that the script will still attempt to update automatically
            [System.Windows.Forms.MessageBox]::Show("The script will continue to run with version $currentVersion. The script will still attempt to update automatically if an internet connection is available.", "Updates not accepted", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        }
    }
})

# Create a button to exit the window
$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = New-Object System.Drawing.Point(250, 10)
$exitButton.Size = New-Object System.Drawing.Size(200, 30)
$exitButton.Text = "Exit"
$exitButton.Add_Click({
    $form.Close()
})

# Add the buttons to the window
$form.Controls.Add($updateButton)
$form.Controls.Add($exitButton)

# Show the window
$form.ShowDialog()
