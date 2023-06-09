
param(
    [Parameter(Position=0, Mandatory)]
    $DesktopDir
)

if (Test-Path .\MoveFiles.ps1) {
    Write-Host 'MoveFiles.ps1 Exists'
}
else {
    throw 'MoveFiles.ps1 not found in the same directory'
}
