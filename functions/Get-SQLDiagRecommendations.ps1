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
    DATE    28/06/2017

#>
function Get-SQLDiagRecommendations {
    [cmdletbinding(SupportsShouldProcess)]
    Param([string]$ApiKey)
    if (!$ApiKey) {
        Write-Verbose -Message "Getting the APIKey"
        if (!(Test-Path "${env:\userprofile}\SQLDiag.Cred")) {
            Write-Warning "You have not created an XML File to hold the API Key or provided the API Key as a parameter
         You can export the key to an XML file using Get-Credential | Export-CliXml -Path `"`${env:\userprofile}\SQLDiag.Cred`"
         You can get a key by following the steps here https://ecsapi.portal.azure-api.net/ "
         break
        }
        else {
            $APIKey = (Import-Clixml -Path "${env:\userprofile}\SQLDiag.Cred").GetNetworkCredential().Password
            Write-Verbose -Message "Got the API Key $APIKey"
        }
    }
    Write-Verbose -Message "Getting the Machine GUID"
    $MachineGUID = Get-MachineGUID

    if($MachineGUID.length -eq 0)
    {
        Write-Warning "Failed to get Machine GUID from HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\"
        break
    }
    Write-Verbose -Message "Getting the LatestCUs from the API"
    $apiUrl = "https://ecsapi.azure-api.net/SQLServer/recommendations/latestcus/" + $MachineGUID + "?api-version=2017-06-01"
    $headers = @{ "Ocp-Apim-Subscription-Key" = $apiKey }
    try {
        if ($PSCmdlet.ShouldProcess($apiUrl, "Connecting to API to get Latest CUs")) { 
    $invokeRestMethodSplat = @{
        Method = 'Get'
        Uri = $apiUrl
        ContentType = "application/json"
        Headers = $headers
        ErrorAction = 'Stop'
    }
    Invoke-RestMethod @invokeRestMethodSplat
        }
    }
    catch {
        Write-Warning "Failed to get Latest CUs from the API $APIURL"
    }
    Write-Verbose -Message "Got the Latest CUs"
}