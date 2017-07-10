function Invoke-SQLDiagDumpAnalysis {
    [cmdletbinding(SupportsShouldProcess = $true)]
    param(
        [parameter(ValueFromPipelineByPropertyName, 
            Mandatory = $true)]
        [ValidateNotNull()]
        [object]$File,
        [parameter( Mandatory = $false)]
        [string]$ApiKey,
        [parameter( Mandatory = $true)]
        [ValidateScript( {Get-SQLDiagSupportedRegions})]
        [string]$Region,
        [parameter( Mandatory = $true)]
        [ValidatePattern('\w+@\w+\.\w+')]
        $Email
    )
    Begin {
        # Get the Machine Guid and the APIKey and the file information
        Write-Verbose -Message "Getting the Machine GUID"
        if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME, "Get the GUID from the registry")) { 
            $MachineGUID = Get-MachineGUID    
        }
        Write-Verbose -Message "Got the Machine GUID - $MachineGUID"
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
        
        if ($file.GetType() -eq [string]) {
            Write-Verbose "Getting File Information about $file"
            try {
                if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME, "Get information about $File")) { 
                    Get-SQLDiagDumpFile -file $File
                    }
                    Write-Verbose "Got File Information FileName = $File.FilePath Fie Size = $file.FileSize"
                }
            }
            catch {
                Write-Warning -Message "Failed to get File Information about $File - Quitting"
                $error[0] | FL -Force
                break
            }
        }

    }
    Process {

        try {
            Write-Verbose "Get the UploadURL from the API"
            if ($PSCmdlet.ShouldProcess($($File.FullPath), "Get the UploadURL from the API")) { 
                $UploadResponse = Get-UploadURL -APIKey $APIKey -MachineGUID $MachineGUID -File $File -Region $Region -Email $Email 
                Write-Verbose "Got the UploadURL $($UploadResponse.UploadURL) for RequestID $($UploadResponse.RequestID) from the API"
            }
        }
        catch {
            Write-Warning -Message "Failed to get the Upload URL for the File $($File.FullPath)"
            break
        }
        $RequestID = $UploadResponse.RequestID
        $UploadURL = $UploadResponse.UploadURL
        try{
        Write-verbose -Message "Upload the File to storage for analysis"
        if ($PSCmdlet.ShouldProcess($($File.FullPath), "Upload the File to storage for analysis")) { 
                Invoke-FileUpload -Uri $UploadURL -File $File.FullPath -FileSize $File.Size
        }
        catch{
                Write-Warning -Message "Failed to upload the File $($File.FullPath) for RequestID $RequestID"
            break
        }
            $InitiateAnalysisAPIURL = 'https://ecsapi.azure-api.net/DiagnosticAnalysis/SQLAnalysis/InitiateAnalysis'

            $headers = @{ "Ocp-Apim-Subscription-Key" = $apiKey }        
            $Body = 
            @{
                clientId  = $MachineGUID
                RequestID = $RequestID
            } | ConvertTo-Json
            Write-Verbose -Message "Intiating Analysis of Dump File $File"
            if ($PSCmdlet.ShouldProcess('SQL Analysis Initiate Analysis', "Intiating Analysis of Dump File $File with $InitiateAnalysisAPIURL")) { 
                try {
                    $response = Invoke-RestMethod -Method Post -Uri $InitiateAnalysisAPIURL -Headers $headers -Body $Body -ContentType "application/json"  -ErrorAction Stop
                    Write-Verbose -Message "Intiated Analysis of Dump File $File - waiting for response"
                }
                catch {
                    Write-Warning -Message "Failed to initiate analysis of $Fiel with API $InitiateAnalysisAPIURL" 
                    break
                }
            }
        }
        End {

            If ($response) {
                Write-Verbose "Success"
            } 
            else {
                Write-Warning "Failed"
            }
        }

    
    }
    #$MachineGUID = "f8fa8213-e978-424d-b939-5afa37cb2144"
    ## $file = [PSCustomObject]@{FilePath = 'C:\temp\database.json'
    ##     Size                           = 100
    ## }