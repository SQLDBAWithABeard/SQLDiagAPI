function Get-SQLDiagLatestAnalysis{
    $history = Get-SQLDiagAnalysisHistory
    $RequestID = ($History | Sort-Object CreateTime -Descending | Select-Object -First 1).RequestID
    Get-SQLDiagAnalysis -RequestID $RequestID 
}