function Get-SQLDiagAnalysisDetail {
    param($RequestID)
$APIKey = (Import-Clixml -Path "${env:\userprofile}\SQLDiag.Cred").GetNetworkCredential().Password
$headers = @{ "Ocp-Apim-Subscription-Key" = $apiKey }        
$Body = 
@{
    clientId  = $MachineGUID
    RequestID = $RequestID
} | ConvertTo-Json

$AnalysisURL = 'https://ecsapi.azure-api.net/DiagnosticAnalysis/SQLAnalysis/GetAnalysisDetails'
Invoke-RestMethod -Method Post -Uri $AnalysisURL -Headers $headers -Body $Body -ContentType "application/json"  -ErrorAction Stop
}