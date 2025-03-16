function Use-TempDir {
    param (
        [ScriptBlock]$Script
    )
    # Use more reliable temp directory path with PS7
    $tmp = [System.IO.Path]::GetTempPath() | Join-Path -ChildPath $([System.Guid]::NewGuid().ToString())
    New-Item -ItemType Directory -Path $tmp -Force | Out-Null
    Push-Location -Path $tmp
    try {
        & $Script
    }
    finally {
        Pop-Location
        if (Test-Path -Path $tmp) {
            Remove-Item -Path $tmp -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}