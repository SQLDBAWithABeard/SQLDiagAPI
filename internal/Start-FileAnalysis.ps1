##############################
#.SYNOPSIS
#Starts the dump analysis
#
#
#.PARAMETER ApiKey
# The APIKey used to authenticate against the API. You can get one from https://ecsapi.portal.azure-api.net/
#
#.PARAMETER MachineGUID
# GUID from Get-MachineGuid
#
#.PARAMETER RequestID
# RequestID to start analysis for
#
#.NOTES
# AUTHOR  Rob Sewell @SQLDBAWithBeard https://sqldbawithabeard.com
#   DATE    11/07/2017
##############################
function Start-FileAnalysis {
    [cmdletbinding(SupportsShouldProcess = $true)]
    param(
        [parameter(ValueFromPipelineByPropertyName = $true, 
            ValueFromPipeline = $true,
            Mandatory = $false)]
        [string]$ApiKey,
        [parameter(ValueFromPipelineByPropertyName = $true, 
            ValueFromPipeline = $true,
            Mandatory = $false)]
        [string]$MachineGUID,
        [parameter(ValueFromPipelineByPropertyName = $true, 
            ValueFromPipeline = $true,
            Mandatory = $false)]
        [string]$RequestID
    )
    Begin {
        $InitiateAnalysisAPIURL = 'https://ecsapi.azure-api.net/DiagnosticAnalysis/SQLAnalysis/InitiateAnalysis'

        $headers = @{ "Ocp-Apim-Subscription-Key" = $apiKey }        
        $Body = 
        @{
            clientId  = $MachineGUID
            RequestID = $RequestID
        } | ConvertTo-Json
    }
    Process {
        Write-Verbose -Message "Intiating Analysis of Dump File $File"
        if ($PSCmdlet.ShouldProcess('SQL Analysis Initiate Analysis', "Intiating Analysis of Dump File $File with $InitiateAnalysisAPIURL")) { 
            try {
                $invokeRestMethodSplat = @{
                    Body = $Body
                    Uri = $InitiateAnalysisAPIURL
                    Method = 'Post'
                    Headers = $headers
                    ErrorAction = 'Stop'
                    ContentType = "application/json"
                }
                $response = Invoke-RestMethod @invokeRestMethodSplat
                Write-Verbose -Message "Intiated Analysis of Dump File $File"
            }
            catch {
                Write-Warning -Message "Failed to initiate analysis of $Fiel with API $InitiateAnalysisAPIURL" 
                break
            }
        }
    }
    End {
        $response
    }
}