function Get-SQLDiagAnalysisHistory {
        [cmdletbinding(SupportsShouldProcess = $true)]
    param( 
        [parameter(Mandatory = $false)]
        [ValidateSet('In Progress', 'Failed', 'Suceeded')]
        [string]$status,
        [parameter(Mandatory = $false)]
        [ValidateSet($true, $False)]
        [string]$complete,
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
        $AnalysisHistoryUrl = 'https://ecsapi.azure-api.net/DiagnosticAnalysis/SQLAnalysis/GetAnalysisHistory/' + $MachineGUID
        $headers = @{ "Ocp-Apim-Subscription-Key" = $apiKey }
        <#
Swtich $Swtich {
put a swithc here for the inputs to be abel to combine them
}#>
    }
    Process {
                        
                            try{
                                Write-Verbose -Message "Getting the Analysis History from the API"
                                if ($PSCmdlet.ShouldProcess('Analysis History APi', "Getting the Analysis History from the API")) { 
        $response = Invoke-RestMethod -Method Get -Uri $AnalysisHistoryUrl -Headers $headers -ContentType "application/json"  -ErrorAction Stop
                             } }
                            catch{
                                Write-Warning "Failed to get the Analysis History form the API"
                Write-Warning -Message "Analysis History URL = $AnalysisHistoryUrl" 
                Write-Warning -Message "Headers = $headers" 
                Write-Warning -Message "Body = $Body" 
                            }
        if ($status) {
                Write-Verbose -Message "Filtering By Status $Status"
            $response | Where-Object {$_.RequestStatus -eq $status}
        }
        elseif ($complete) {
            Write-Verbose -Message "Filtering By Completion $Complete"
                $response | Where-Object {$_.IsComplete -eq $complete}

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