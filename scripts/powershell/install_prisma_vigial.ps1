# PowerShell Script to Install prismavigil.py

# Define the target filename and paths
$filename = "prismavigil.py"
$wrapperName = "prismavigil"
$scriptPath = "..\python\$filename"
$installPath = "$env:USERPROFILE\bin"
$wrapper = "$installPath\$wrapperName.ps1"

# Create ~/bin if it doesn't exist
if (-not (Test-Path $installPath)) {
    New-Item -ItemType Directory -Path $installPath
}

# Function to add path to user's PATH environment variable
Function Add-ToUserPath {
    param (
        [string]$NewPath
    )

    $path = [Environment]::GetEnvironmentVariable("PATH", "User")
    if (-not $path.Split(';').Contains($NewPath)) {
        $newPath = $path + ';' + $NewPath
        [Environment]::SetEnvironmentVariable("PATH", $newPath, "User")
    }
}

# Add ~/bin to PATH if not already present
Add-ToUserPath $installPath

# Copy the Python script to the target location
Copy-Item $scriptPath $installPath -Force

# Create a wrapper script that invokes python with the script
$wrapperContent = "#!/bin/bash`npython3 `"$installPath\$filename`" `"$args`""
Set-Content -Path $wrapper -Value $wrapperContent

# Make the wrapper script executable
if (-not (Get-Command $wrapperName -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
}

# Output a success message
Write-Output "Script '$filename' has been installed and is executable as '$wrapperName' from PowerShell."
Write-Output "You may need to restart PowerShell or log out and log back in to update your PATH."
