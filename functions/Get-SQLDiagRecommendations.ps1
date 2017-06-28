function Get-SQLDiagRecommendations {
    [cmdletbinding()]
    Param([string]$ApiKey)
    if (!$ApiKey) {
        if (!(Test-Path "${env:\userprofile}\SQLDiag.Cred")) {
            Write-Warning "You have not created an XML File to hold the API Key or provided the API Key as a parameter
         You can export the key to an XML file using Get-Credential | Export-CliXml -Path `"`${env:\userprofile}\SQLDiag.Cred`"
         You can get a key by following the steps here https://ecsapi.portal.azure-api.net/ "
        }
        else {
            $APIKey = (Import-Clixml -Path "${env:\userprofile}\SQLDiag.Cred").GetNetworkCredential().Password
        }
    }

    $MachineGUID = Get-MachineGUID

    if($MachineGUID.length -eq 0)
    {
        Write-Warning "Failed to get Machine GUID from HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\"
        break
    }

    $apiUrl = "https://ecsapi.azure-api.net/SQLServer/recommendations/latestcus/" + $MachineGUID + "?api-version=2017-06-01"
    $headers = @{ "Ocp-Apim-Subscription-Key" = $apiKey }

    Invoke-RestMethod -Method Get -Uri $apiUrl -Headers $headers -ContentType "application/json"  -ErrorAction Stop
}