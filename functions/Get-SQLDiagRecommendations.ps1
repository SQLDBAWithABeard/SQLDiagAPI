<#
.SYNOPSIS
Uses the SQL Server Diagnostic Recommendations API to return latest CU information as an object

.DESCRIPTION
This function connects to the SQL Server Diagnostic Recommendations API and returns a PSCustomObject 
with information about the latest Cumulative Updates for various SQL Server Versions. 
Details here https://ecsapi.portal.azure-api.net/

It requires the APIKey parameter or the APIKey to be stored using Export-CliXML in the users profile
in a file named SQLDiag.Cred

.PARAMETER ApiKey
The APIKey used to authenticate against the API. You can get one from https://ecsapi.portal.azure-api.net/

.EXAMPLE
Get-SQLDiagRecommendations 

Returns an object containing the information about the latest CUs for SQL Server using an API Key stored in 
the users profile in a file named SQLDiag.Cred

.EXAMPLE
$APIKey = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
Get-SQLDiagRecommendations -ApiKey $APIKey

Returns an object containing the information about the latest CUs for SQL Server 

.NOTES
    AUTHOR  Rob Sewell @SQLDBAWithBeard https://sqldbawithabeard.com
    DATE    28/05/2017

#>
function Get-SQLDiagRecommendations {
    [cmdletbinding()]
    Param([string]$ApiKey)
    if (!$ApiKey) {
        if (!(Test-Path "${env:\userprofile}\SQLDiag.Cred")) {
            Write-Warning "You have not created an XML File to hold the API Key or provided the API Key as a parameter
         You can export the key to an XML file using Get-Credential | Export-CliXml -Path `"`${env:\userprofile}\SQLDiag.Cred`"
         You can get a key by following the steps here https://ecsapi.portal.azure-api.net/ "
         break
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