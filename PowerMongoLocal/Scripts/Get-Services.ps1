param (
    [array]$ServerName
)
$array=@()

foreach($name IN $ServerName){
    $Services = Get-CimInstance Win32_service | Where-Object { $_.processId -ne 0 -and $_.startMode -eq "Auto"} | Select-Object -Property @{name="Servername";expression={$name} },name,startMode,State,Status
    $array += $Services
}

$array
  

