# Get-SQLDiagLatestCU

## SYNOPSIS
Gets The Latest Cumulative Updates and Date from the SQL Server Diagnostic API

## SYNTAX

```
Get-SQLDiagLatestCU [-Recommendations <PSObject>] [[-Product] <String[]>] [-LearnMore] [-Download] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Returns Product Name, Cumulative Update Name and Date created from the SQL Server Diagnostic API
Opens the Learn More webpage with the LearnMore switch
Downloads the CU with the Download Switch

## EXAMPLES

### EXAMPLE 1
```
Get-SQLDiagLatestCU
```

Returns Product Name, Cumulative Update Name and Date created for all products from the SQL Server Diagnostic API

### EXAMPLE 2
```
Get-SQLDiagRecommendations | Get-SQLDiagLatestCU
```

Returns Product Name, Cumulative Update Name and Date created for all products from the SQL Server Diagnostic API

### EXAMPLE 3
```
Get-SQLDiagLatestCU -Recommendations (Get-SQLDiagRecommendations)
```

Returns Product Name, Cumulative Update Name and Date created for all products from the SQL Server Diagnostic API

### EXAMPLE 4
```
Get-SQLDiagProduct 2012 | Get-SQLDiagLatestCU
```

Returns Product Name, Cumulative Update Name and Date created for products named 2012 from the SQL Server Diagnostic API

### EXAMPLE 5
```
Get-SQLDiagLatestCU -Product 'SQL Server 2012 SP3'
```

Returns Product Name, Cumulative Update Name and Date created for SQL Server 2012 SP3 from the SQL Server Diagnostic API

### EXAMPLE 6
```
Get-SQLDiagLatestCU -Product 'SQL Server 2012 SP3','SQL Server 2014 SP1'
```

Returns Product Name, Cumulative Update Name and Date created for SQL Server 2012 SP3 and SQL Server 2014 SP1 from the 
SQL Server Diagnostic API

### EXAMPLE 7
```
Get-SQLDiagLatestCU -Product 'SQL Server 2012 SP3' -LearnMore
```

Opens the Cumulative Update for SQL Server 2012 SP3 information webpage in the default browser

### EXAMPLE 8
```
Get-SQLDiagLatestCU -Product 'SQL Server 2012 SP3' -Download
```

Opens the Cumulative Update for SQL Server 2012 SP3 download webpage in the default browser

### EXAMPLE 9
```
Get-SQLDiagProduct 2012 | Get-SQLDiagLatestCU -LearnMore
```

Opens the Cumulative Update for SQL Server 2012 SP3 information webpage in the default browser

### EXAMPLE 10
```
Get-SQLDiagProduct 2012 | Get-SQLDiagLatestCU -Download
```

Opens the Cumulative Update for SQL Server 2012 SP3 download webpage in the default browser

### EXAMPLE 11
```
Get-SQLDiagLatestCU -Product 'SQL Server 2012 SP3','SQL Server 2014 SP1' | Out-GridView
```

Returns Product Name, Cumulative Update Name and Date created for SQL Server 2012 SP3 and SQL Server 2014 SP1 from the 
SQL Server Diagnostic API and outputs to Out-GridView

### EXAMPLE 12
```
Get-SQLDiagLatestCU -Product 'SQL Server 2012 SP3','SQL Server 2014 SP1' | Out-File C:\Temp\LatestCU.txt
```

Returns Product Name, Cumulative Update Name and Date created for SQL Server 2012 SP3 and SQL Server 2014 SP1 from the 
SQL Server Diagnostic API and outputs to a File C:\Temp\LatestCU.txt

### EXAMPLE 13
```
$LatestCu =  Get-SQLDiagLatestCU | Out-DbaDataTable
```

Write-DbaDataTable -SqlServer $Server -Database $DB -InputObject $LatestCu-Table $LatestCu -AutoCreateTable

Puts Product Name, Cumulative Update Name and Date created for all products from the 
SQL Server Diagnostic API into a database table and creates the table - Requires dbatools https://dbatools.io

## PARAMETERS

### -Recommendations
The recommendation object from the API - Use Get-SQLDiagRecommendations by default

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
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -LearnMore
Opens the Information web-page for the Cumulative Update for the product specified in the default browser

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Download
Opens the Download page for the Cumulative Update for the product specified in the default browser

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
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
DATE    30/06/2017

## RELATED LINKS
