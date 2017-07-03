# Get-SQLDiagFeature

### SYNOPSIS
Returns the Features avaialble from teh SQL Server Diagnostic Recommendations API

### DESCRIPTION
This will connect to to the SQL Server Diagnostic Recommendations API and return the 
unique list of features for some or all of the Products 

### PARAMETER Recommendations
The recommendation object from the API - Use Get-SQLDiagRecommendations by default

### PARAMETER Product
The product or products that you want to filter by Get-SQLDiagProduct will show the options

### PARAMETER Feature
Wildcard case insensitive search for feature name

### EXAMPLE
Get-SQLDiagFeature

This will return a unique list of all of the Feature Areas that have fixes from the SQL Server Diagnostic API

### EXAMPLE
Get-SQLDiagFeature -Feature Always

This will return a unique list of all of the Feature Areas that have fixes from the SQL Server Diagnostic API 
with a name including Always (case insensitive)

### EXAMPLE
Get-SQLDiagFeature -Product 'SQL Server 2012 SP3'

This will return a unique list of all of the Feature Areas that have fixes for the product SQL Server 2012 SP3
from the SQL Server Diagnostic API

### EXAMPLE
Get-SQLDiagProduct 2016 | Get-SQLDiagFeature 

This will return a unique list of all of the Feature Areas that have fixes for products with 2016 in the name 
from the SQL Server Diagnostic API

### EXAMPLE
Get-SQLDiagProduct 2016 | Get-SQLDiagFeature Always

This will return a unique list of all of the Feature Areas that have fixes for products with 2016 in the name 
and features with Always in the name (case insensitive) from the SQL Server Diagnostic API

### NOTES
    AUTHOR  Rob Sewell @SQLDBAWithBeard https://sqldbawithabeard### com
    DATE    30/06/2017