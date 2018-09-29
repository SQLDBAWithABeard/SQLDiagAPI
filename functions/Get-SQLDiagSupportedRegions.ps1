<#
.SYNOPSIS
Returns the list of regions supported for the file upload URI from the SQL Server Diagnostic Analysis API 

.DESCRIPTION
This function connects to the SQL Server Diagnostic Analysis API and returns a list of supported regions
for the file upload URI
Details here https://ecsapi.portal.azure-api.net/

It requires the APIKey parameter or the APIKey to be stored using Export-CliXML in the users profile
in a file named SQLDiag.Cred

.PARAMETER ApiKey
The APIKey used to authenticate against the API. You can get one from https://ecsapi.portal.azure-api.net/

.EXAMPLE
Get-SQLDiagSupportedRegions

returns a list of supported regions for the file upload URI using an API Key stored in 
the users profile in a file named SQLDiag.Cred

.EXAMPLE
$APIKey = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
Get-SQLDiagSupportedRegions -ApiKey $APIKey

returns a list of supported regions for the file upload URI with the APIKey in the script

.NOTES
    AUTHOR  Rob Sewell @SQLDBAWithBeard https://sqldbawithabeard.com
    DATE    26/07/2017

#>
function Get-SQLDiagSupportedRegions {
    [cmdletbinding(SupportsShouldProcess = $true)]
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

    if ($MachineGUID.length -eq 0) {
        Write-Warning "Failed to get Machine GUID from HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\"
        break
    }

    Write-Verbose -Message "Getting the Supported Regions from the API"
    $apiUrl = "https://ecsapi.azure-api.net/DiagnosticAnalysis/SQLAnalysis/GetSupportedRegions?api-version=2017-06-01"
    $headers = @{ "Ocp-Apim-Subscription-Key" = $apiKey }
    try {
        if ($PSCmdlet.ShouldProcess($apiUrl, "Connecting to API to get Supported Regions")) { 
            $invokeRestMethodSplat = @{
                Uri = $apiUrl
                ContentType = "application/json"
                Method = 'Get'
                Headers = $headers
                ErrorAction = 'Stop'
            }
            Invoke-RestMethod @invokeRestMethodSplat
        }
    }
    catch {
        Write-Warning " Failed to get Supported Regions from the API $APIURL"
    }
    Write-Verbose -Message "Got the Supported Regions"
}