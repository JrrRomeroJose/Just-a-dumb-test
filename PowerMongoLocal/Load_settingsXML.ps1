$path = $PSScriptRoot+"\settings.xml"
    [xml]$SettingsXML = Get-Content -Path $path
         $ScriptPath = $SettingsXML.Settings.ScriptsPath
         $DataPath = $SettingsXML.Settings.DataPath
         $IsJobMonitoredEnabled = $SettingsXML.Settings.IsJobMonitored
         $ImportPath = $SettingsXML.Settings.ImportPath