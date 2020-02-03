. "$PSScriptRoot\Load_settingsXML.ps1"

$Files = Get-ChildItem -Path $ImportPath | Where-Object {$_.Name -match "Imported_*"}

$Name = "CompressedMetrics"+(Get-Date -Format "MM-dd-yyyy_hh-mm-ss")+".zip"


try
{
    Compress-Archive $Files -DestinationPath "$($ImportPath)\$($Name)" -ErrorAction Stop
    Remove-Item $Files
}
catch
{
    Write-Host "An error occurred:"
    Write-Host $_
}