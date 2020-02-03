param (
    [array]$ServerName
)
$array=@()
$date =  $date =  Get-Date -Format "MM/dd/yyyy HH:mm:ss"

foreach($name IN $ServerName){

    $disks = Get-CimInstance win32_logicaldisk 
    foreach($disk IN $disks)
    {
        $object= New-Object -TypeName psobject
        $object |  Add-Member -Name 'ServerName' -MemberType Noteproperty -Value $name
        $object |  Add-Member -Name 'DriveID' -MemberType Noteproperty -Value $disk.DeviceID
        $object |  Add-Member -Name 'DiskSize' -MemberType Noteproperty -Value ([Math]::round(($disk.Size/1024/1024/1024),1))
        $object |  Add-Member -Name 'FreeSpace' -MemberType Noteproperty -Value  ([Math]::round(($disk.FreeSpace/1024/1024/1024),1))
        $object |  Add-Member -Name 'Date' -MemberType Noteproperty -Value $date
        $array += $object

    }

}
$array