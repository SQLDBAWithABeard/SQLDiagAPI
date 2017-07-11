<#
.SYNOPSIS
Returns information about the latest diagnosis from the SQL Server Diagnostic API   

.DESCRIPTION
Returns information about the latest diagnosis from the SQL Server Diagnostic API

.EXAMPLE
 Get-SQLDiagLatestAnalysis

 Returns information about the latest diagnosis from the SQL Server Diagnostic API

.NOTES
    AUTHOR  Rob Sewell @SQLDBAWithBeard https://sqldbawithabeard.com
    DATE    11/07/2017

#>
function Get-SQLDiagLatestAnalysis {
    Write-Verbose -Message "Getting all of the Diagnosis history"
    try {
        $history = Get-SQLDiagAnalysisHistory
        Write-Verbose -Message "got all of the diagnosis history"
    }
    catch {
        Write-Warning "Failed to get all of the diagnosis history"
        break
    }
    Write-Verbose -Message "Filtering history by latest"
    $RequestID = ($History | Sort-Object CreateTime -Descending | Select-Object -First 1).RequestID
    Write-Verbose -Message "Getting the latest Diagnosis"
    Get-SQLDiagAnalysis -RequestID $RequestID 
    Write-Verbose -Message "Got the latest Diagnosis"
}