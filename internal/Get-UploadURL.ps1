function Get-UploadURL{
    [cmdletbinding(SupportsShouldProcess = $true)]
    param( 
        [string]$APIKey,
        [string]$MachineGUID,
        [object]$File,
        [string]$Region,
        [string]$Email
        )
            $UploadAPIURL = 'https://ecsapi.azure-api.net/DiagnosticAnalysis/SQLAnalysis/GetUploadUrl'
        $headers = @{ "Ocp-Apim-Subscription-Key" = $apiKey }        
        $Body = 
        @{
            clientId          = $MachineGUID
            fileName          = $File.FilePath
            region            = $Region
            notificationEmail = $Email
            metadata          = @{
                fileSize = "$($File.Size) MB"
            }
        } | ConvertTo-Json

        Write-Verbose -Message "Getting the Upload URL for $File with GetUploadURL API $UploadAPIUR"
        if ($PSCmdlet.ShouldProcess('SQL Analysis GetUploadURL', "UGetting the Upload URL for $File with $UploadAPIURL")) { 
            try {
                $UploadResponse = Invoke-RestMethod -Method Post -Uri $UploadAPIURL -Headers $headers -Body $Body -ContentType "application/json"  -ErrorAction Stop
                Write-Verbose -Message "Uploaded $File to GetUplaodURL API $UploadAPIUR"
            }
            catch {
                Write-Warning -Message "Failed to upload $File to GetUploadURL API $UploadAPiURL" 
                Write-Warning -Message "UplaodAPI URL = $UploadAPIURL" 
                Write-Warning -Message "Headers = $headers" 
                Write-Warning -Message "Body = $Body" 
                break
            }
        }

        $UploadResponse 
}