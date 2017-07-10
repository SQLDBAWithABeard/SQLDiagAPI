##############################
#.SYNOPSIS
# Internal Function to upload file 
#
#.PARAMETER Uri
# URL from Get-UploadURL
#
#.PARAMETER File
# File Path
##############################
function Start-FileUpload {
    [cmdletbinding(SupportsShouldProcess = $true)]
    param([string]$Uri,
        [string]$File)
## Needs the Azure.Storage dll file from the Azure.Storage Module
## Dont know if I can put it in here or it needs to come from the module
    if (!(Get-Module Azure.Storage -ListAvailable)) {
        $Base = (Get-Module -Name SQLDiagAPI).ModuleBase
        Add-Type -Path $Base\internal\Microsoft.WindowsAzure.Storage.dll
    }
    else {
        $Base = (Get-Module -Name Azure.Storage -ListAvailable).ModuleBase
        $StorageDll = (Get-ChildItem -Path $Base -Recurse Microsoft.WindowsAzure.Storage.dll).FullName
        Add-Type $StorageDll
    }
    <#
    if we could use async upload then use this
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