#Powershell script used to move files from one folder to another folder.
#V0.1
#Author: OlleMark

#Requires -RunAsAdministrator
param(
    [Parameter(Position=0,mandatory=$true)]
    [string]$SourceDir,
    [Parameter(Position=1,mandatory=$true)]
    [string]$TargetDir
)
foreach ($File in Get-ChildItem($SourceDir )) {
    $TargetFolders = $TargetDir.Split('\')
    $MoveFile = 1
    foreach($Folder in $TargetFolders){ #Check so we dont try and move one of the folders of the target directory
        if ($Folder -eq $File){
            $MoveFile = 0
            break
        }
    }
    if ($MoveFile -eq 1) {
        Move-Item ($SourceDir+$File) $TargetDir
        Write-Host $File.Name 'Moved'
    }
}