############################################################################
# PSGallery
############################################################################
Write-Host -NoNewLine "Check PSGallery InstallationPolicy..."
$psRepository = Get-PSRepository -Name PSGallery -ErrorAction SilentlyContinue
if ($null -ne $psRepository -and $psRepository.InstallationPolicy -eq 'Untrusted') {
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
$gitInstalled = $false
try {
    $gitInstalled = $null -ne (Get-Command winget -ErrorAction SilentlyContinue) -and 
                   ($null -ne (& winget list --id Git.Git 2>$null))
}
catch {
    $gitInstalled = $false
}

if (-not $gitInstalled) {
    Write-Host "Install Git.Git."
    winget install --id Git.Git --accept-source-agreements --accept-package-agreements
    
    # Update PATH for current session
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
    git config --global user.name "Junki Akiyama"
    git config --global user.email "junki@example.jp"
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
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser -Force
}
else {
    Write-Host "Already Set."
}

############################################################################
# MyEnvironments
############################################################################
Write-Host -NoNewLine "Check MyEnvironments..."
if (!(Test-Path C:\Repos\MyEnvironments1)) {
    Write-Host "Clone MyEnvironments."
    if (!(Test-Path C:\Repos)) {
        New-Item -ItemType Directory C:\Repos > $null
    }

    git clone https://github.com/junkichi424/MyEnvironments1.git C:\Repos\MyEnvironments1
}
else {
    Write-Host "Already cloned."
}

Read-Host -Prompt "Press any key to exit."