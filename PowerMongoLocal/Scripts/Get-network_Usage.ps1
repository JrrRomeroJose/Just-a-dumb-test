#(get-counter -list "Network Interface").paths
param (
    [array]$ServerName
)
$array=@()

$date =  $date =  Get-Date -Format "MM/dd/yyyy HH:mm:ss"

foreach($name IN $ServerName){
    $networkSent = (Get-Counter "\Network Interface(*)\Bytes Sent/sec").counterSamples | Select-Object -Property @{Name="ServerName";Expression={$name}},@{Name="type";Expression={"Sent bytes"}},instanceName,CookedValue,@{Name="Date";Expression={$date}}
    $networkReceive = (Get-Counter "\Network Interface(*)\Bytes Received/sec").counterSamples | Select-Object -Property @{Name="ServerName";Expression={$name}},@{Name="type";Expression={"Received bytes"}},instanceName,CookedValue,@{Name="Date";Expression={$date}}

    $array += $networkSent
    $array += $networkReceive
}
$array

