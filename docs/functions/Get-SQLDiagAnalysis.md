# Get-SQLDiagAnalysis

## SYNOPSIS
Returns the detail of an analysis from the SQL Server Diagnostics API

## SYNTAX

```
Get-SQLDiagAnalysis [-APIKey <String>] [-RequestID] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Connects to the SQL Server Diagnostics API and returns the details of a 
single analysis

## EXAMPLES

### EXAMPLE 1
```
Get-SQLDiagAnalysis -RequestID 4b36a572-3925-4f7f-8f5a-bf964582b986
```

Returns the Diagnosis analysis for the request id specified

### EXAMPLE 2
```
Get-SQLDiagAnalysisHistory -Since Yesterday | Out-GridView -PassThru |  Get-SQLDiagAnalysis
```

Gets the Diagnosis history, displays it in Out-GridView and then gets the analysis for the 
chosen request

## PARAMETERS

### -APIKey
The APIKey used to authenticate against the API.
You can get one from https://ecsapi.portal.azure-api.net/

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequestID
The request ID for analysis - You can get this from Get-SQLDiagHistory

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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
DATE    11/07/2017

## RELATED LINKS
