##############################
#.SYNOPSIS
# Internal Function to upload file 
#
#.PARAMETER Uri
# URL from Get-UploadURL
#
#.PARAMETER File
# File Object
##############################
function Start-FileUpload {
    [cmdletbinding(SupportsShouldProcess = $true)]
    param([string]$Uri,
        [object]$File)
        Write-Warning "There is no progress bar at present on the file upload"
    if (!(Get-Module Azure.Storage -ListAvailable)) {
        
            Write-Warning -Message "This requires the Azure.Storage Module - Please run Install-Module Azure.Storage -Scope CurrentUser to install from the PowerShell Gallery"
    }
    else {
        Write-Verbose -Message "Import Azure.Storage Module"
        try {
            if ($PSCmdlet.ShouldProcess("Azure.Storage Module", "Importing")) { 
               Import-Module -Name Azure.Storage
            }
        }
        catch {
            Write-Warning -Message "Failed to import Azure.Storage module - quitting"
            break
        }
    }
    <#
    if we could use async upload then use this but I cannot get it to work
    $blobContent = System.IO.File.ReadAllBytes($file.FullName)
    $blob = New-Object Microsoft.WindowsAzure.Storage.Blob.CloudBlockBlob ($uri)
    $Blob.UploadFromByteArrayAsync($blobContent, 0, $File.Size)
    #>
    $blob = New-Object Microsoft.WindowsAzure.Storage.Blob.CloudBlockBlob ($uri)
    try {
        Write-verbose -Message "Uploading the file $File for analysis"
        if ($PSCmdlet.ShouldProcess($File.FullName, "Uploading the File for analysis")) { 
            $blob.UploadFromFile($file.FullName, $null, $null, $null)
        }
    }
    catch {
        Write-Warning -Message "Failed to upload File $($File.FullName)"
        break
    }
}