# Get-SQLDiagRecommendations

## SYNOPSIS
Uses the SQL Server Diagnostic Recommendations API to return latest CU information as an object

## SYNTAX

```
Get-SQLDiagRecommendations [[-ApiKey] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This function connects to the SQL Server Diagnostic Recommendations API and returns a PSCustomObject 
with information about the latest Cumulative Updates for various SQL Server Versions. 
Details here https://ecsapi.portal.azure-api.net/

It requires the APIKey parameter or the APIKey to be stored using Export-CliXML in the users profile
in a file named SQLDiag.Cred

## EXAMPLES

### EXAMPLE 1
```
Get-SQLDiagRecommendations
```

Returns an object containing the information about the latest CUs for SQL Server using an API Key stored in 
the users profile in a file named SQLDiag.Cred

### EXAMPLE 2
```
$APIKey = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
```

Get-SQLDiagRecommendations -ApiKey $APIKey

Returns an object containing the information about the latest CUs for SQL Server

## PARAMETERS

### -ApiKey
The APIKey used to authenticate against the API.
You can get one from https://ecsapi.portal.azure-api.net/

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
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
DATE    28/06/2017

## RELATED LINKS
