param (
    [array]$ServerName
)
$array=@()
$date =  $date =  Get-Date -Format "MM/dd/yyyy HH:mm:ss"

foreach($name IN $ServerName){

    $os = Get-Ciminstance Win32_OperatingSystem
    $usedMemory = [Math]::round(($os.TotalVisibleMemorySize/1024/1024) - ($os.FreePhysicalMemory/1024/1024),1)

    $object= New-Object -TypeName psobject
    $object |  Add-Member -Name 'ServerName' -MemberType Noteproperty -Value $name
    $object |  Add-Member -Name 'UsedMemory' -MemberType Noteproperty -Value $usedMemory
    $object |  Add-Member -Name 'Date' -MemberType Noteproperty -Value $date
    $array += $object
}

$array