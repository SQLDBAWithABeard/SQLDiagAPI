# Get-SQLDiagRecommendations

### SYNOPSIS
Uses the SQL Server Diagnostic Recommendations API to return latest CU information as an object

### DESCRIPTION
This function connects to the SQL Server Diagnostic Recommendations API and returns a PSCustomObject 
with information about the latest Cumulative Updates for various SQL Server Versions###  
Details here https://ecsapi### portal### azure-api### net/

It requires the APIKey parameter or the APIKey to be stored using Export-CliXML in the users profile
in a file named SQLDiag### Cred

### PARAMETER ApiKey
The APIKey used to authenticate against the API###  You can get one from https://ecsapi### portal### azure-api### net/

### EXAMPLE
Get-SQLDiagRecommendations 

Returns an object containing the information about the latest CUs for SQL Server using an API Key stored in 
the users profile in a file named SQLDiag### Cred

### EXAMPLE
$APIKey = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
Get-SQLDiagRecommendations -ApiKey $APIKey

Returns an object containing the information about the latest CUs for SQL Server 

### NOTES
    AUTHOR  Rob Sewell @SQLDBAWithBeard https://sqldbawithabeard### com
    DATE    28/06/2017