function PrintInfo($message) {
  Write-Host $message -ForegroundColor Cyan
}

PrintInfo -message "Checking execution policy for current user."
if ((Get-ExecutionPolicy -Scope CurrentUser) -ne "RemoteSigned") {
  Set-ExecutionPolicy RemoteSigned -scope CurrentUser
}

PrintInfo -message "Checking chocolatey is installed."
if ($null -eq (Get-Command choco*)) {
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

PrintInfo -message "Install git."
choco install git.install -y --params="'/NoShellIntegration'"

PrintInfo -message "Install gsudo."
choco install gsudo -y

PrintInfo -message "Enable longpath support."
if (1 -ne (Get-ItemPropertyValue 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled')) {
  sudo Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1
}

PrintInfo -message "Completed 'prerequisites.ps1'. Press Enter."
Read-Host
