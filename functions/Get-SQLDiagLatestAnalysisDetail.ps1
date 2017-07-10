function Get-SQLDiagLatestAnalysisDetail{
    $history = Get-SQLDiagAnalysisHistory
    $RequestID = ($History | Sort-Object CreateTime -Descending | Select-Object -First 1).RequestID
    Get-SQLDiagAnalysisDetail -RequestID $RequestID
}