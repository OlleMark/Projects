#Powershell script used sort directorys into folders named after the file type.
#V0.1
#Author: OlleMark

param(
    [Parameter(Position=0, Mandatory)]
    $DesktopDir
)
function Get-Filecategory {
    param (
        [parameter(Mandatory)]
        [string]$FileType
    )
    $FileCategorys = @{
        Pictures = @{
            jpeg = 'jpeg'
            png = 'png'
            webp = 'webp'
            jfif = 'jfif'
            jpg = 'jpg'
        }
        Videos = @{
            mp4 = 'mp4'
            gif = 'gif'
        }
        Music = @{
            mp3 = 'mp3'
        }
        ThreeDModels = @{
            stl = 'stl'
            fbx = 'fbx'
            f3d = 'f3d'
            gx = 'gx'
        }
        Documents = @{
            pdf = 'pdf'
            cfg = 'cfg'
            docx = 'docx'
            txt = 'txt'
            rtf = 'rtf'
            xlsx = 'xlsx'
            htm = 'htm'
            log = 'log'
        }
        CompressedFiles = @{
            rar = 'rar'
            zip = 'zip'
        }
        Executables = @{
            exe = 'exe'
            msi = 'msi'
            jar = 'jar'
        }
        ThreeDPrinting = @{
            gcode = 'gcode'
        }
        Blender = @{
            blend = 'blend'
        }
        Unity = @{
            unitypackage = 'unitypackage'
        }
        Programming = @{
            py = 'py'
            cs = 'cs'
        }
    }
    foreach($FileCategoryKey in $FileCategorys.Keys){
        foreach($FileCategory in $FileCategorys[$FileCategoryKey].GetEnumerator()){
            if ($FileType.Equals($FileCategory.value)) {
                Write-Host $FileCategoryKey is the category we found
                return $FileCategoryKey
            }
        }
    }
    return ''
}
$AllFiles = Get-ChildItem($DesktopDir)
$SortedDictionary = New-Object System.Collections.Generic.Dictionary"[string,System.Collections.Generic.List[String]]"

foreach($File in $AllFiles){
    $FileName = $File.Name
    $SplitName = $FileName.Split('.')
    if($SplitName.Count -gt 1){
        $FileType = $SplitName[$SplitName.Lenght-1].ToLower();
        $DicExists=$false
        $FileCategory = Get-Filecategory -FileType $FileType
        Write-Host $FileCategory is the category
        Write-Host $FileType is the file type
        if ($FileCategory -ne '') {
            $FileType = $FileCategory
            }
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
    if ($FileList.Count -ne 1) {
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
}