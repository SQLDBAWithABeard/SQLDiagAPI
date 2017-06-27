function Get-SQLDiagRecommendations {

if(!(Get-ChildItem Env:MS_SQLDiag_APIKey -ErrorAction SilentlyContinue)){
        Write-Warning "You have not created an Environment Variable MS_SQLDiag_APIKey to hold the APIKey
         You can do this using [Environment]::SetEnvironmentVariable(`"MS_SQLDiag_APIKey`", `"APIKEYGOESHERE`", `"User`") 
         You can get a key by following the steps here https://ecsapi.portal.azure-api.net/ "
}
}