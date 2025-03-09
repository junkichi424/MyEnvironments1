############################################################################
# PSGallery
############################################################################
Write-Host -NoNewLine "Check PSGallery InstallationPolicy..."
if ((Get-PSRepository -Name PSGallery).InstallationPolicy -eq 'Untrusted') {
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    Write-Host "InstallationPolicy is set to Trusted."
}
else {
    Write-Host "Already trusted."
}

############################################################################
# GistGet
############################################################################
Write-Host -NoNewLine "Check GistGet..."
if (-not (Get-Module -Name GistGet -ListAvailable)) {
    Write-Host "Install GistGet."
    Install-Module -Name GistGet -Force -Scope CurrentUser -ErrorAction Stop

    # GitHub Personal Access Token
    $token = Read-Host -Prompt "Enter GitHub Personal Access Token"
    Set-GitHubToken $token
    $token = $null
}
else {
    Write-Host "Already installed."
}
Import-Module -Name GistGet

############################################################################
# Git
############################################################################
Write-Host -NoNewLine "Check Git.Git..."
if (-not (Get-WinGetPackage -Id Git.Git)) {
    Write-Host "Install Git.Git."
    winget install --id Git.Git
    
    $env:Path += ";$env:ProgramFiles\Git\cmd\"
    git config --global user.name "Atsushi Nakamura"
    git config --global user.email "nuits.jp@live.jp"
}
else {
    Write-Host "Already installed."
}


############################################################################
# PowerShell execution policy
############################################################################
Write-Host -NoNewLine "Check PowerShell execution policy..."
if ((Get-ExecutionPolicy -Scope CurrentUser) -ne "RemoteSigned") {
    Write-Host "Set PowerShell execution policy for current user."
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
}
else {
    Write-Host "Already Set."
}

############################################################################
# MyEnvironments
############################################################################
Write-Host -NoNewLine "Check MyEnvironments..."
if (!(Test-Path C:\Repos\MyEnvironments)) {
    Write-Host "Clone MyEnvironments."
    if (!(Test-Path C:\Repos)) {
        New-Item -ItemType Directory C:\Repos > $null
    }

    git clone https://github.com/nuitsjp/MyEnvironments.git C:\Repos\MyEnvironments
}
else {
    Write-Host "Already cloned."
}

############################################################################
# Hyper-V
############################################################################
Write-Host -NoNewLine "Check Hyper-V..."
if (((Get-WindowsOptionalFeature -Online | Where-Object { $_.FeatureName -eq 'Microsoft-Hyper-V' })[0].State) -eq 'Disabled') {
    Write-Host "Enable Hyper-V. After enabled, reboot."
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
}
else {
    Write-Host "Already enabled."
}

Read-Host -Prompt "Press any key to exit."
