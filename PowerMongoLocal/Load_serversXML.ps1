$path = $PSScriptRoot+"\Servers.xml"
    [xml]$serversXML = Get-Content -Path $path
    $ServerName = @()
    $ServerName = $serversXML.Servers.Host.Name
