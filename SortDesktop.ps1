
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

$AllFiles = Get-ChildItem($DesktopDir)
$SortedDictionary = New-Object System.Collections.Generic.Dictionary"[string,System.Collections.Generic.List[String]]"

foreach($File in $AllFiles){
    $FileName = $File.Name
    $SplitName = $FileName.Split('.')
    if($SplitName.Count -gt 1){
        $FileType = $SplitName[$SplitName.Lenght-1]
        $DicExists=$false
        foreach($Type in $SortedDictionary.GetEnumerator()){
            if($FileType -eq $Type.Key){
                $DicExists=$true
                $Type.Value.Add($FileName)
                break
            }
        }
        if ($DicExists -eq $false) { #If the key+value is missing, add a new list and add the current file to the list.
            $NewList = New-Object System.Collections.Generic.List[String]
            $NewList.Add($FileName)
            $SortedDictionary.Add($FileType, $NewList)
        }
    }
}
foreach($Type in $SortedDictionary.GetEnumerator()){
    $KeyName = $Type.Key
    $FileList = $Type.Value
    $DestinationFolder = $DesktopDir+'\'+$KeyName
    Write-Host $DestinationFolder
    if (test-path -Path $DestinationFolder) { }
    else { #If folder is missing, create it
        New-Item -Path $DestinationFolder -ItemType Directory
    }
    foreach($File in $FileList){
        Move-Item -Path $DesktopDir'\'$File -Destination $DestinationFolder
    }
}