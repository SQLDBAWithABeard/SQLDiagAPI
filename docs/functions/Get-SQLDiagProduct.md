# Get-SQLDiagProduct

## SYNOPSIS
Returns the Products avaiable in the SQL Server Diagnostic API

## SYNTAX

```
Get-SQLDiagProduct [-Recommendations <PSObject>] [[-Product] <String>] [<CommonParameters>]
```

## DESCRIPTION
Enables you to search for the products that are available in the SQL Server Diagnostic API

## EXAMPLES

### EXAMPLE 1
```
Get-SQLDiagProduct
```

Returns all of the Product Names in the SQL Server Diagnostic API

### EXAMPLE 2
```
Get-SQLDiagRecommendations | Get-SQLDiagProduct
```

Returns all of the Product Names in the SQL Server Diagnostic API

### EXAMPLE 3
```
Get-SQLDiagProduct -Product 2012
```

Returns all of the Product Names in the SQL Server Diagnostic API with 2012 in the name

### EXAMPLE 4
```
Get-SQLDiagProduct -Product SP1
```

Returns all of the Product Names in the SQL Server Diagnostic API with SP1 in the name

### EXAMPLE 5
```
Get-SQLDiagProduct SP1
```

Returns all of the Product Names in the SQL Server Diagnostic API with SP1 in the name

### EXAMPLE 6
```
$product = Get-SQLDiagProduct -Product 2016
```

Get-SQLDiagLatestCU -Product $product

Returns Product Name, Cumulative Update Name and Date created for products with 2016 in the name from the 
SQL Server Diagnostic API

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
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Product
The search for the product you do not need to enter wildcards

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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
