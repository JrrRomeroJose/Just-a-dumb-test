 . "$PSScriptRoot\Load_settingsXML.ps1"

$db = "ServerMonitoring"

#Move files to Import directory

try {
    Get-ChildItem -Path $DataPath | Move-Item -Destination $ImportPath -ErrorAction Stop
}
catch {
    #If the file already exists on the path he will not be able to move the new file. Next iteration will import the file
    Get-ChildItem -Path $DataPath | ForEach-Object { if((Test-Path  "$ImportPath\$($_.Name)") -eq $true ){Write-Host "The File $($_.Name) already exists on the import directory" -ForegroundColor Red }}
}

#Start import task foreach file
Get-ChildItem -Path $ImportPath -Exclude "Imported_*" | Where-Object {$_.Name -match "Get-"}  |  ForEach-Object -Parallel `
{
    $Collection = $_.Name.Replace(".json","")
    $NewName = "Imported_"+$_.Name.Replace(".json","")+"_"+(Get-Date -Format "MM-dd-yyyy_HH-mm-ss")+".json"
    Write-Host "Importing file $($_.Name)" -ForegroundColor Green
    try
    {
        & "C:\Program Files\MongoDB\Server\4.2\bin\mongoimport.exe" --db=$($using:db) --collection=$($Collection) --file=$($_.FullName)
        Rename-Item -Path $_.FullName -NewName $NewName
    }
    catch
    {
        Write-Host "An error occurred:"
        Write-Host $_
    }
    
}