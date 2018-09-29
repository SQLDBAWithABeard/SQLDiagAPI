# Get-SQLDiagFeature

## SYNOPSIS
Returns the Features avaialble from teh SQL Server Diagnostic Recommendations API

## SYNTAX

```
Get-SQLDiagFeature [-Recommendations <PSObject>] [-Product <Object[]>] [[-Feature] <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION
This will connect to to the SQL Server Diagnostic Recommendations API and return the 
unique list of features for some or all of the Products

## EXAMPLES

### EXAMPLE 1
```
Get-SQLDiagFeature
```

This will return a unique list of all of the Feature Areas that have fixes from the SQL Server Diagnostic API

### EXAMPLE 2
```
Get-SQLDiagFeature -Feature Always
```

This will return a unique list of all of the Feature Areas that have fixes from the SQL Server Diagnostic API 
with a name including Always (case insensitive)

### EXAMPLE 3
```
Get-SQLDiagFeature -Product 'SQL Server 2012 SP3'
```

This will return a unique list of all of the Feature Areas that have fixes for the product SQL Server 2012 SP3
from the SQL Server Diagnostic API

### EXAMPLE 4
```
Get-SQLDiagProduct 2016 | Get-SQLDiagFeature
```

This will return a unique list of all of the Feature Areas that have fixes for products with 2016 in the name 
from the SQL Server Diagnostic API

### EXAMPLE 5
```
Get-SQLDiagProduct 2016 | Get-SQLDiagFeature Always
```

This will return a unique list of all of the Feature Areas that have fixes for products with 2016 in the name 
and features with Always in the name (case insensitive) from the SQL Server Diagnostic API

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
Wildcard case insensitive search for feature name

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
DATE    30/06/2017

## RELATED LINKS
