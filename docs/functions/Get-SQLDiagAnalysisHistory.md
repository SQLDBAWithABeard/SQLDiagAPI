# Get-SQLDiagAnalysisHistory

## SYNOPSIS
Returns the SQL Server dump file diagnosis history for this machine from the 
SQL Server Diagnostics API

## SYNTAX

```
Get-SQLDiagAnalysisHistory [[-Status] <String>] [[-Since] <Object>] [[-APIKey] <Object>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the SQL Server dump file diagnosis history for this machine from the 
SQL Server Diagnostics API
Details here https://ecsapi.portal.azure-api.net/

It requires the APIKey parameter or the APIKey to be stored using Export-CliXML in the users profile
in a file named SQLDiag.Cred

## EXAMPLES

### EXAMPLE 1
```
Get-SQLDiagAnalysisHistory
```

Returns the SQL Server dump file diagnosis history for this machine from the 
SQL Server Diagnostics API

### EXAMPLE 2
```
Get-SQLDiagAnalysisHistory -Status Complete
```

Returns the SQL Server dump file diagnosis history for completed dump Analysis for this machine from the 
SQL Server Diagnostics API

### EXAMPLE 3
```
Get-SQLDiagAnalysisHistory -Status Failed
```

Returns the SQL Server dump file diagnosis history for dump Analysis that have failed for this machine from the 
SQL Server Diagnostics API

### EXAMPLE 4
```
Get-SQLDiagAnalysisHistory -Status 'In Progress'
```

Returns the SQL Server dump file diagnosis history for dump Analysis that are in progress for this machine from the 
SQL Server Diagnostics API

### EXAMPLE 5
```
Get-SQLDiagAnalysisHistory -Since Today
```

Returns the SQL Server dump file diagnosis history for dump Analysis since midnight today for this machine from the 
SQL Server Diagnostics API

### EXAMPLE 6
```
Get-SQLDiagAnalysisHistory -Since Yesterday
```

Returns the SQL Server dump file diagnosis history for dump Analysis since midnight Yesterday for this machine from the 
SQL Server Diagnostics API

### EXAMPLE 7
```
Get-SQLDiagAnalysisHistory -Since 'This Week'
```

Returns the SQL Server dump file diagnosis history for dump Analysis since midnight on Monday morning of this week for 
this machine from the SQL Server Diagnostics API

### EXAMPLE 8
```
Get-SQLDiagAnalysisHistory -Since 'This Month'
```

Returns the SQL Server dump file diagnosis history for dump Analysis since midnight on the 1st of this month for 
this machine from the SQL Server Diagnostics API

## PARAMETERS

### -Status
Status of the request - accepted values are Complete, Failed, In Progress

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

### -Since
Time paramater to filter the history - accepted values 'Today', 'Yesterday', 'This Week', 'This Month'

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -APIKey
The APIKey used to authenticate against the API.
You can get one from https://ecsapi.portal.azure-api.net/

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
