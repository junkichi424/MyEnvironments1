. $PSScriptRoot\winget\winget.ps1

# Check if modules are installed, install if not
$requiredModules = @('powershell-yaml', 'posh-winget')

foreach ($module in $requiredModules) {
    if (-not (Get-Module -Name $module -ListAvailable)) {
        Write-Host "Installing module: $module"
        Install-Module -Name $module -Force -Scope CurrentUser
    }
}

# Import modules
Import-Module powershell-yaml
Import-Module posh-winget

Write-Host 'Update git repository.' -ForegroundColor Cyan
try {
    git pull
}
catch {
    Write-Warning "Error updating Git repository: $_"
}

Update-WingetPackage