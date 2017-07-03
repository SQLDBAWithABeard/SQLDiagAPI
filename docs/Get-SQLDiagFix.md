# Get-SQLDiagFix 

### SYNOPSIS
Returns the Fixes from the SQL Server Diagnostic recommnendations API 

### DESCRIPTION
Returns the Product Name, Feature Name/Area, KB Number, Title and URL for the
Fixes in the Cumulative Updates returned from the SQL Server Diagnostics Recommendations API

### PARAMETER Recommendations
The recommendation object from the API - Uses Get-SQLDiagRecommendations by default

### PARAMETER Product
The product or products that you want to filter by Get-SQLDiagProduct will show the options

### PARAMETER Feature
The Feature Name or Area that you want to filter by Get-SQLDiagFeature will show the options

### EXAMPLE
Get-SQLDiagFix

Returns the Product Name, Feature Name/Area, KB Number, Title and URL for all of the
Fixes in the Cumulative Updates returned from the SQL Server Diagnostics Recommendations API

### EXAMPLE
Get-SQLDiagFix -Product 'SQL Server 2012 SP3'

Returns the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes for 
SQL Server 2012 SP3 in the Cumulative Updates returned from the SQL Server Diagnostics Recommendations API

### EXAMPLE
Get-SQLDiagFix -Feature 'Always On'

Returns the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes for the
Feature Area Always On in the Cumulative Updates returned from the SQL Server Diagnostics Recommendations API

### EXAMPLE
Get-SQLDiagFix 'Always On'

Returns the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes for the
Feature Area Always On in the Cumulative Updates returned from the SQL Server Diagnostics Recommendations API

### EXAMPLE
Get-SQLDiagFix -Product 'SQL Server 2012 SP3' -Feature 'Always On'

Returns the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes for the
Feature Area Always On for SQL Server 2012 SP3 in the Cumulative Updates returned from the SQL Server 
Diagnostics Recommendations API

### EXAMPLE
Get-SQLDiagProduct 2012 | Get-SQLDiagFix 

Returns the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes for the
Feature Area Always On for products with 2012 in the name in the Cumulative Updates returned from 
the SQL Server Diagnostics Recommendations API

### EXAMPLE
Get-SQLDiagProduct SP1 | Get-SQLDiagFix 

Returns the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes for the
Feature Area Always On for products with SP1 in the name in the Cumulative Updates returned from 
the SQL Server Diagnostics Recommendations API

### EXAMPLE
Get-SQLDiagProduct SP1 | Get-SQLDiagFix -Feature (Get-SQLDiagFeature -Feature AL)

Returns the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes for the
Feature Areas with AL in the name for products with SP1 in the name in the Cumulative Updates returned
from the SQL Server Diagnostics Recommendations API

### EXAMPLE
Get-SQLDiagProduct SP1 | Get-SQLDiagFix -Feature (Get-SQLDiagFeature -Feature AL) | Out-GridView

Returns the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes for the
Feature Areas with AL in the name for products with SP1 in the name in the Cumulative Updates returned
from the SQL Server Diagnostics Recommendations API and displays them in Out-GridView

### EXAMPLE
Get-SQLDiagFix | Export-Csv -Path C:\temp\Fixes### csv

Exports the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes in the 
Cumulative Updates returned from the SQL Server Diagnostics Recommendations API into a File

### EXAMPLE
$Fixes =  Get-SQLDiagFix | Out-DbaDataTable
Write-DbaDataTable -SqlServer $Server -Database $DB -InputObject $Fixes-Table Fixes -AutoCreateTable

Puts the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes in the 
Cumulative Updates returned from the SQL Server Diagnostics Recommendations API into a 
database table and creates the table - Requires dbatools https://dbatools### io

### EXAMPLE
Get-SQLDiagProduct SP1 | Get-SQLDiagFix -Feature (Get-SQLDiagFeature -Feature AL) | Out-GridView -PassThru | ForEach-Object {Start-Process $_### UR}

Opens the URL for a Fix that the user chooses from Out-GridView which is populated with all of the Fixes for the
Feature Areas with AL in the name for products with SP1 in the name in the Cumulative Updates returned
from the SQL Server Diagnostics Recommendations API 

### NOTES
    AUTHOR  Rob Sewell @SQLDBAWithBeard https://sqldbawithabeard### com
    DATE    03/07/2017