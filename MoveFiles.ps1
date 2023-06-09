#Powershell script used to move files from one folder to another folder.
#V0.1
#Author: OlleMark

#Requires -RunAsAdministrator
param(
    $SourceDir = "C:\PStemp",
    $TargetDir = "C:\PStemp\Result"
)
Move-Item $SourceDir $TargetDir
