#Create XML config file
param (
    [string]$ScriptsPath = $PSScriptRoot+"\Scripts",
    [string]$DataPath = $PSScriptRoot+"\Data",
    [string]$ImportPath = $PSScriptRoot+"\Import",
    [Int16]$IsJobMonitoredEnabled = 1
)
$FileName = "settings.xml" 

"<Settings>" | out-file -FilePath $FileName -Encoding utf8
"<ScriptsPath>"+$ScriptsPath+"</ScriptsPath>" | out-file -FilePath $FileName -Append -NoClobber
"<DataPath>"+$DataPath+"</DataPath>" | out-file -FilePath $FileName -Append -NoClobber
"<ImportPath>"+$ImportPath+"</ImportPath>" | out-file -FilePath $FileName -Append -NoClobber
"<IsJobMonitored>"+$IsJobMonitoredEnabled+"</IsJobMonitored>" | out-file -FilePath $FileName -Append -NoClobber
"</Settings>" | out-file -FilePath $FileName -Append -NoClobber