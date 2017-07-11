<#
.SYNOPSIS
Returns the SQL Server dump file diagnosis history for this machine from the 
SQL Server Diagnostics API

.DESCRIPTION
Returns the SQL Server dump file diagnosis history for this machine from the 
SQL Server Diagnostics API
Details here https://ecsapi.portal.azure-api.net/

It requires the APIKey parameter or the APIKey to be stored using Export-CliXML in the users profile
in a file named SQLDiag.Cred

.PARAMETER Status
Status of the request - accepted values are Complete, Failed, In Progress

.PARAMETER Complete
Filter by Has the analysis completed requires $true or $false

.PARAMETER Since
Time paramater to filter the history - accepted values 'Today', 'Yesterday', 'This Week', 'This Month'

.PARAMETER APIKey
The APIKey used to authenticate against the API. You can get one from https://ecsapi.portal.azure-api.net/

.EXAMPLE
Get-SQLDiagAnalysisHistory

Returns the SQL Server dump file diagnosis history for this machine from the 
SQL Server Diagnostics API

.EXAMPLE
Get-SQLDiagAnalysisHistory -Status Complete

Returns the SQL Server dump file diagnosis history for completed dump Analysis for this machine from the 
SQL Server Diagnostics API

.EXAMPLE
Get-SQLDiagAnalysisHistory -Status Failed

Returns the SQL Server dump file diagnosis history for dump Analysis that have failed for this machine from the 
SQL Server Diagnostics API

.EXAMPLE
Get-SQLDiagAnalysisHistory -Status 'In Progress'

Returns the SQL Server dump file diagnosis history for dump Analysis that are in progress for this machine from the 
SQL Server Diagnostics API

.EXAMPLE
Get-SQLDiagAnalysisHistory -Since Today

Returns the SQL Server dump file diagnosis history for dump Analysis since midnight today for this machine from the 
SQL Server Diagnostics API

.EXAMPLE
Get-SQLDiagAnalysisHistory -Since Yesterday

Returns the SQL Server dump file diagnosis history for dump Analysis since midnight Yesterday for this machine from the 
SQL Server Diagnostics API

.EXAMPLE
Get-SQLDiagAnalysisHistory -Since 'This Week'

Returns the SQL Server dump file diagnosis history for dump Analysis since midnight on Monday morning of this week for 
this machine from the SQL Server Diagnostics API

.EXAMPLE
Get-SQLDiagAnalysisHistory -Since 'This Month'

Returns the SQL Server dump file diagnosis history for dump Analysis since midnight on the 1st of this month for 
this machine from the SQL Server Diagnostics API

.NOTES
    AUTHOR  Rob Sewell @SQLDBAWithBeard https://sqldbawithabeard.com
    DATE    28/06/2017
#>
function Get-SQLDiagAnalysisHistory {
    [cmdletbinding(SupportsShouldProcess = $true)]
    param( 
        [parameter(Mandatory = $false)]
        [ValidateSet('In Progress', 'Failed', 'Complete')]
        [string]$Status,
        [parameter(Mandatory = $false)]
        [ValidateSet('Today', 'Yesterday', 'This Week', 'This Month')]
        $Since,
        [parameter(Mandatory = $false)]
        $APIKey
    )
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
        $AnalysisHistoryUrl = 'https://ecsapi.azure-api.net/DiagnosticAnalysis/SQLAnalysis/GetAnalysisHistory/' + $MachineGUID
        $headers = @{ "Ocp-Apim-Subscription-Key" = $apiKey }
        <#
Swtich $Swtich {
put a swithc here for the inputs to be abel to combine them
}#>
    }
    Process {
                        
        try {
            Write-Verbose -Message "Getting the Analysis History from the API"
            if ($PSCmdlet.ShouldProcess('Analysis History APi', "Getting the Analysis History from the API")) { 
                $response = Invoke-RestMethod -Method Get -Uri $AnalysisHistoryUrl -Headers $headers -ContentType "application/json"  -ErrorAction Stop
            } 
        }
        catch {
            Write-Warning "Failed to get the Analysis History from the API"
            Write-Warning -Message "Analysis History URL = $AnalysisHistoryUrl" 
            Write-Warning -Message "Headers = $headers" 
            Write-Warning -Message "Body = $Body" 
            break
        }
        if ($status) {
            Write-Verbose -Message "Filtering By Status $Status"
            $response | Where-Object {$_.RequestStatus -eq $status}
        }
        elseif ($Since) {
            if ($Since -eq 'Today') {
                $Date = [datetime]::Today
            }
            elseif ($Since -eq 'Yesterday') {
                $Date = ([datetime]::Today).AddDays(-1)
            }
            elseif ($Since -eq 'This Week') {
                $n = 0
                do {
                    $date = (Get-Date -Hour 0 -Minute 0 -Second 0).AddDays( - $n)
                    $n++
                }
                Until ( $date.DayOfWeek -eq "Monday" )
            }
            elseif ($Since -eq 'This Month') {
                $Today = [datetime]::Today
                $Date = Get-Date -Year $today.Year -Month $today.Month -Day 1 -Hour 0 -Minute 0 -Second 0
            }
            Write-Verbose -Message "Filtering By Date since $Date"
            $response | Where-Object {[datetime]$_.CreateTime -gt $Date}
        }
        else {
            Write-Verbose -Message "Returning default response"
            $response
        }
    }
    End {

    }
}