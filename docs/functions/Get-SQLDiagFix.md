# Get-SQLDiagFix

## SYNOPSIS
Returns the Fixes from the SQL Server Diagnostic recommnendations API

## SYNTAX

```
Get-SQLDiagFix [-Recommendations <PSObject>] [-Product <Object[]>] [[-Feature] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Returns the Product Name, Feature Name/Area, KB Number, Title and URL for the
Fixes in the Cumulative Updates returned from the SQL Server Diagnostics Recommendations API

## EXAMPLES

### EXAMPLE 1
```
Get-SQLDiagFix
```

Returns the Product Name, Feature Name/Area, KB Number, Title and URL for all of the
Fixes in the Cumulative Updates returned from the SQL Server Diagnostics Recommendations API

### EXAMPLE 2
```
Get-SQLDiagFix -Product 'SQL Server 2012 SP3'
```

Returns the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes for 
SQL Server 2012 SP3 in the Cumulative Updates returned from the SQL Server Diagnostics Recommendations API

### EXAMPLE 3
```
Get-SQLDiagFix -Feature 'Always On'
```

Returns the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes for the
Feature Area Always On in the Cumulative Updates returned from the SQL Server Diagnostics Recommendations API

### EXAMPLE 4
```
Get-SQLDiagFix 'Always On'
```

Returns the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes for the
Feature Area Always On in the Cumulative Updates returned from the SQL Server Diagnostics Recommendations API

### EXAMPLE 5
```
Get-SQLDiagFix -Product 'SQL Server 2012 SP3' -Feature 'Always On'
```

Returns the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes for the
Feature Area Always On for SQL Server 2012 SP3 in the Cumulative Updates returned from the SQL Server 
Diagnostics Recommendations API

### EXAMPLE 6
```
Get-SQLDiagProduct 2012 | Get-SQLDiagFix
```

Returns the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes for the
Feature Area Always On for products with 2012 in the name in the Cumulative Updates returned from 
the SQL Server Diagnostics Recommendations API

### EXAMPLE 7
```
Get-SQLDiagProduct SP1 | Get-SQLDiagFix
```

Returns the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes for the
Feature Area Always On for products with SP1 in the name in the Cumulative Updates returned from 
the SQL Server Diagnostics Recommendations API

### EXAMPLE 8
```
Get-SQLDiagProduct SP1 | Get-SQLDiagFix -Feature (Get-SQLDiagFeature -Feature AL)
```

Returns the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes for the
Feature Areas with AL in the name for products with SP1 in the name in the Cumulative Updates returned
from the SQL Server Diagnostics Recommendations API

### EXAMPLE 9
```
Get-SQLDiagProduct SP1 | Get-SQLDiagFix -Feature (Get-SQLDiagFeature -Feature AL) | Out-GridView
```

Returns the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes for the
Feature Areas with AL in the name for products with SP1 in the name in the Cumulative Updates returned
from the SQL Server Diagnostics Recommendations API and displays them in Out-GridView

### EXAMPLE 10
```
Get-SQLDiagFix | Export-Csv -Path C:\temp\Fixes.csv
```

Exports the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes in the 
Cumulative Updates returned from the SQL Server Diagnostics Recommendations API into a File

### EXAMPLE 11
```
$Fixes =  Get-SQLDiagFix | Out-DbaDataTable
```

Write-DbaDataTable -SqlServer $Server -Database $DB -InputObject $Fixes-Table Fixes -AutoCreateTable

Puts the Product Name, Feature Name/Area, KB Number, Title and URL for all of the Fixes in the 
Cumulative Updates returned from the SQL Server Diagnostics Recommendations API into a 
database table and creates the table - Requires dbatools https://dbatools.io

### EXAMPLE 12
```
Get-SQLDiagProduct SP1 | Get-SQLDiagFix -Feature (Get-SQLDiagFeature -Feature AL) | Out-GridView -PassThru | ForEach-Object {Start-Process $_.UR}
```

Opens the URL for a Fix that the user chooses from Out-GridView which is populated with all of the Fixes for the
Feature Areas with AL in the name for products with SP1 in the name in the Cumulative Updates returned
from the SQL Server Diagnostics Recommendations API

## PARAMETERS

### -Recommendations
The recommendation object from the API - Uses Get-SQLDiagRecommendations by default

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (Get-SQLDiagRecommendations)
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Product
The product or products that you want to filter by Get-SQLDiagProduct will show the options

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Feature
The Feature Name or Area that you want to filter by Get-SQLDiagFeature will show the options

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
AUTHOR  Rob Sewell @SQLDBAWithBeard https://sqldbawithabeard.com
DATE    03/07/2017

## RELATED LINKS
