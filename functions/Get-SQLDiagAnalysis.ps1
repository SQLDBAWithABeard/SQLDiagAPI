<#
.SYNOPSIS
Returns the detail of an analysis from the SQL Server Diagnostics API

.DESCRIPTION
Connects to the SQL Server Diagnostics API and returns the details of a 
single analysis

.PARAMETER RequestID
The request ID for analysis - You can get this from Get-SQLDiagHistory

.PARAMETER APIKey
The APIKey used to authenticate against the API. You can get one from https://ecsapi.portal.azure-api.net/

.EXAMPLE
Get-SQLDiagAnalysis -RequestID 4b36a572-3925-4f7f-8f5a-bf964582b986

Returns the Diagnosis analysis for the request id specified

.EXAMPLE
Get-SQLDiagAnalysisHistory -Since Yesterday | Out-GridView -PassThru |  Get-SQLDiagAnalysis

Gets the Diagnosis history, displays it in Out-GridView and then gets the analysis for the 
chosen request 

.NOTES
    AUTHOR  Rob Sewell @SQLDBAWithBeard https://sqldbawithabeard.com
    DATE    11/07/2017
#>
function Get-SQLDiagAnalysis {
    [cmdletbinding(SupportsShouldProcess = $true)]
    param( 
        [parameter(Mandatory = $false)]
        [string]$APIKey,
        [parameter(Position = 0,
            ValueFromPipelineByPropertyName = $true, 
            ValueFromPipeline = $true,
            Mandatory = $true)]
        [string]$RequestID)
    Begin {
        if (!$ApiKey) {
            Write-Verbose -Message "Getting the APIKEY"
            if (!(Test-Path "${env:\userprofile}\SQLDiag.Cred")) {
                Write-Warning "You have not created an XML File to hold the API Key or provided the API Key as a parameter
         You can export the key to an XML file using Get-Credential | Export-CliXml -Path `"`${env:\userprofile}\SQLDiag.Cred`"
         You can get a key by following the steps here https://ecsapi.portal.azure-api.net/ "
                break
            }
            else {
                if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME, "Get the APIKey from ${env:\userprofile}\SQLDiag.Cred ")) { 
                    $APIKey = (Import-Clixml -Path "${env:\userprofile}\SQLDiag.Cred").GetNetworkCredential().Password
                }
                Write-Verbose -Message "Using the APIKEY $APIKey"
            }
        }
        Write-Verbose -Message "Getting the Machine GUID"
        $MachineGUID = Get-MachineGUID

        if ($MachineGUID.length -eq 0) {
            Write-Warning "Failed to get Machine GUID from HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\"
            break
        }
        $headers = @{ "Ocp-Apim-Subscription-Key" = $apiKey }        
        $AnalysisURL = 'https://ecsapi.azure-api.net/DiagnosticAnalysis/SQLAnalysis/GetAnalysisDetails'
    }
    Process {
        $Body = 
        @{
            clientId  = $MachineGUID
            RequestID = $RequestID
        } | ConvertTo-Json
        try {
            Write-Verbose -Message "Getting the Analysis from the API for RequestID $RequestID"
            if ($PSCmdlet.ShouldProcess('Analysis Detail APi', "Getting the Analysis History from the API")) { 
                $invokeRestMethodSplat = @{
                    ContentType = "application/json"
                    ErrorAction = 'Stop'
                    Headers = $headers
                    Method = 'Post'
                    Body = $Body
                    Uri = $AnalysisURL
                }
                $Response = Invoke-RestMethod @invokeRestMethodSplat
            } 
        }
        catch {
            Write-Warning "Failed to get the Analysis History from the API"
            Write-Warning -Message "Analysis History URL = $AnalysisUrl" 
            Write-Warning -Message "Headers = $headers" 
            Write-Warning -Message "Body = $Body" 
            break
        }
    }
    End {
        Write-Verbose -Message "Returning the Analysis Detail from the API for $RequestId"
        $Response
    }

}