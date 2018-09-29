##############################
#.SYNOPSIS
# Internal Function to return the URL from the API for uploading the file
#
##############################
function Get-UploadURL{
    [cmdletbinding(SupportsShouldProcess = $true)]
    param( 
        [parameter(ValueFromPipelineByPropertyName = $true, 
            ValueFromPipeline = $true,
            Mandatory = $true)]
        [string]$APIKey,
        [parameter(ValueFromPipelineByPropertyName = $true, 
            ValueFromPipeline = $true,
            Mandatory = $true)]
        [string]$MachineGUID,
        [parameter(ValueFromPipelineByPropertyName = $true, 
            ValueFromPipeline = $true,
            Mandatory = $true)]
        [object]$File,
        [parameter(ValueFromPipelineByPropertyName = $true, 
            ValueFromPipeline = $true,
            Mandatory = $true)]
        [string]$Region,
        [parameter(ValueFromPipelineByPropertyName = $true, 
            ValueFromPipeline = $true,
            Mandatory = $false)]
        [string]$Email
        )
            $size = $File.Length/1MB
            $UploadAPIURL = 'https://ecsapi.azure-api.net/DiagnosticAnalysis/SQLAnalysis/GetUploadUrl'
        $headers = @{ "Ocp-Apim-Subscription-Key" = $apiKey }        
        $Body = 
        @{
            clientId          = $MachineGUID
            fileName          = $File.FullName
            region            = $Region
            notificationEmail = $Email
            metadata          = @{
                fileSize = "$size MB"
            }
        } | ConvertTo-Json

        Write-Verbose -Message "Getting the Upload URL for $($File.FullName) with GetUploadURL API $UploadAPIURL"
        if ($PSCmdlet.ShouldProcess('SQL Analysis GetUploadURL', "Getting the Upload URL for $File with $UploadAPIURL")) { 
            try {
                $invokeRestMethodSplat = @{
                    Uri = $UploadAPIURL
                    ContentType = "application/json"
                    Headers = $headers
                    Method = 'Post'
                    ErrorAction = 'Stop'
                    Body = $Body
                }
                $UploadResponse = Invoke-RestMethod @invokeRestMethodSplat
                Write-Verbose -Message "Got the Upload URL $UploadResponse"
            }
            catch {
                Write-Warning -Message "Failed to get the Upload URL from API $UploadAPiURL" 
                break
            }
        }

        $UploadResponse 
}