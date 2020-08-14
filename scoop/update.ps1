function PrintInfo($message) {
  Write-Host $message -ForegroundColor Cyan
}

PrintInfo -message "add buckets to scoop."
scoop bucket add extras
foreach ($item in @("extras", "jetbrains")) {
  if (!((scoop bucket list) -contains $item)) {
    PrintInfo -message "add `"$item`" bucket to scoop."
    scoop bucket add $item
  }
}

PrintInfo -message "install/update scoop packages"
Scoop-Playbook

PrintInfo -message "install Visual Studio 2019"
if (0 -eq ((vswhere -format json | ConvertFrom-Json).Length))
{
  Invoke-WebRequest -UseBasicParsing -Uri http://aka.ms/vs/16/release/vs_enterprise.exe -OutFile vs_Enterprise.exe
  Start-Process -FilePath vs_Enterprise.exe -ArgumentList "--config `"${pwd}\.vsconfig`" --passive --norestart --wait" -Verb runas -Wait
} 
else
{
  Invoke-WebRequest -UseBasicParsing -Uri http://aka.ms/vs/16/release/vs_enterprise.exe -OutFile vs_Enterprise.exe
  Start-Process -FilePath vs_Enterprise.exe -ArgumentList "update --passive --norestart --wait" -Verb runas -Wait
}
