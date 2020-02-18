#THIS IS JUST A TEST DO NOT FORGET IT!!!!!





#load settings.xml
. "$PSScriptRoot\Load_settingsXML.ps1"
. "$PSScriptRoot\Load_serversXML.ps1"
#Test var should be changed by servers.xml 
$ServerName

#execute every script placed on SctiptsPath
Get-ChildItem -Path $SettingsXML.settings.ScriptsPath | ForEach-Object -process `
{
    Start-ThreadJob -Name ($_.Name.Replace(".ps1","")) -FilePath "$($ScriptPath)\$($_.Name)" -ArgumentList (,$ServerName)
}

while((Get-job | measure-object | Select-Object -Property Count).Count -gt 0) 
{ 
    (Get-Job) | where-object { $_.State -eq 'Completed' } | ForEach-Object -process `
    {
        $jobName = $_.Name
        Receive-Job $_ ` | ForEach-Object -Process `
        {
            $_ `
            | ConvertTo-Json -Compress `
            | out-file -filepath "$($DataPath)\$($jobName).json" -Append -NoClobber -Encoding utf8
        }
        #collect job running time in case this is needed
        if($IsJobMonitoredEnabled -eq 1)
        {
          Write-Host "Saving Job running time, job name: $jobName" -ForegroundColor Yellow 
          $_ `
          | Select-Object -Property Name,@{name='JobStartDate';expression={'{0:MM/dd/yyyy hh:mm:ss}' -f $_.PSBeginTime}},@{name='JobEndDate';expression={'{0:MM/dd/yyyy hh:mm:ss}' -f $_.PSEndTime}} `
          | ConvertTo-Json -Compress `
          | out-file -FilePath "$($DataPath)\Get-JobPerformance.json" -Append -NoClobber -Encoding utf8 
        }
        write-host "Procesed job:" $jobName -ForegroundColor Green
        $_ | remove-job

    Start-Sleep -Seconds 3
    }

}