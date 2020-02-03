param (
    [array]$ServerName
)
$array=@()
$date =  $date =  Get-Date -Format "MM/dd/yyyy HH:mm:ss"

foreach($name IN $ServerName){
    $object= New-Object -TypeName psobject
    $object |  Add-Member -Name 'ServerName' -MemberType Noteproperty -Value $name
    $object |  Add-Member -Name 'CPU' -MemberType Noteproperty -Value (Get-CimInstance Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -Property Average).Average
    $object |  Add-Member -Name 'Date' -MemberType Noteproperty -Value $date
    $array += $object
}

$array
  

