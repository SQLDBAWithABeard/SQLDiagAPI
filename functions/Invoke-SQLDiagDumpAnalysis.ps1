<#
.SYNOPSIS
Uploads a dump file to the SQL Server Diagnostics API for Analysis

.DESCRIPTION
Uploads a dump file to the SQL Server Diagnostics API for Analysis
Details here https://ecsapi.portal.azure-api.net/

It requires the APIKey parameter or the APIKey to be stored using Export-CliXML in the users profile
in a file named SQLDiag.Cred

.PARAMETER File
The Fiile Path or File object of the dump file to be analysed

.PARAMETER ApiKey
The APIKey used to authenticate against the API. You can get one from https://ecsapi.portal.azure-api.net/

.PARAMETER Region
The Azure Region to upload the file to. Get-SQLDiagSupportedRegions shows the available regions

.PARAMETER Email
The email address to receive notification that analysis has completed and the recommendations

.EXAMPLE
Invoke-SQLDiagDumpAnalysis -File c:\temp\SQLDump073.mdmp -Region 'West Us' -Email 'a@a.com'

Uploads the file to the API and emails when it has completed

.EXAMPLE
Get-SQLDiagDumpFile | Invoke-SQLDiagDumpAnalysis -Region 'West US' -Email a@a.com

opens a file picker to choose a file which is then uploaded to teh West US Azure region
and analysed with the SQL Server Diagnostic API

.NOTES
    AUTHOR  Rob Sewell @SQLDBAWithBeard https://sqldbawithabeard.com
    DATE    10/07/2017
#>
function Invoke-SQLDiagDumpAnalysis {
    [cmdletbinding(SupportsShouldProcess = $true)]
    param(
        [parameter(ValueFromPipelineByPropertyName, 
            ValueFromPipeline,
            Mandatory = $true)]
        [ValidateNotNull()]
        [object]$File,
        [parameter( Mandatory = $false)]
        [string]$ApiKey,
        [parameter( Mandatory = $true)]
        [ValidateScript( {Get-SQLDiagSupportedRegions})]
        [string]$Region,
        [parameter( Mandatory = $false)]
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
                Write-Verbose "Got File Information FileName = $File.FileName File Size = $file.FileSize"
            }
            catch {
                Write-Warning -Message "Failed to get File Information about $File - Quitting"
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
        try {
            Write-verbose -Message "Upload the File to storage for analysis"
            if ($PSCmdlet.ShouldProcess($($File.FullPath), "Upload the File to storage for analysis")) { 
                Start-FileUpload -Uri $UploadURL -File $File.FullPath -FileSize $File.Size
            }
        }
        catch {
            Write-Warning -Message "Failed to upload the File $($File.FullPath) for RequestID $RequestID"
            break
        }
        Write-Verbose -Message "Intiating Analysis of Dump File $File"
        try {
            if ($PSCmdlet.ShouldProcess('SQL Analysis Initiate Analysis', "Intiating Analysis of Dump File $File")) { 
            
                Start-FileAnalysis -APIKey $ApiKey -MachineGUID $MachineGUID -RequestID $RequestID
            }
        }
        catch {
            Write-Warning -Message "File analysis Initiation for $File Failed"
            break
        }
    }
    End {

        If ($response) {
            Write-Verbose "Successfully invoked Analysis of file $File.FullName with RequestID $RequestID"
        } 
        else {
            Write-Warning "Failed to Invoke analysis of File $File.FullName"
        }
    }
}
