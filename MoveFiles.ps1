#Powershell script used to move files from one folder to another folder.
#V0.1
#Author: OlleMark

#Requires -RunAsAdministrator
param(
    $SourceDir = "C:\temp",
    $TargetDir = "C:\temp\Result"
)
Move-Item $SourceDir $TargetDir
