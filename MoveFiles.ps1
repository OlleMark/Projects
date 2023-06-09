#Powershell script used to move files from one folder to another folder.
#V0.1
#Author: OlleMark

#Requires -RunAsAdministrator
param(
    [string]$SourceDir = "C:\PStemp",
    [string]$TargetDir = "C:\PStemp\Result"
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