param (
    [array]$ServerName
)
$array=@()

$date =  $date =  Get-Date -Format "MM/dd/yyyy HH:mm:ss"

foreach($name IN $ServerName){
    $DiskData = Get-Counter -Counter '\LogicalDisk(*)\Avg. Disk sec/Read','\LogicalDisk(*)\Avg. Disk sec/Write'
    $DiskReadSec = $DiskData.CounterSamples | Where-Object {$_.InstanceName -notmatch "harddiskvolume" -and $_.InstanceName -ne "_total" } `
    | Select-Object -Property @{Name="ServerName";Expression={$name}},Path,InstanceName,CookedValue,@{Name="Date";Expression={$date}}

    $array+= $DiskReadSec
}

$array