# Get-SQLDiagDumpFile

## SYNOPSIS
Gets a SQL Server Dump File for uploading to the API

## SYNTAX

```
Get-SQLDiagDumpFile [[-file] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Gets a SQL Server Dump File for uploading to the API.
Opens a graphical file picker if no file specified

## EXAMPLES

### EXAMPLE 1
```
Get-SQLDiagDumpFile | Invoke-SQLDiagDumpAnalysis -Region 'West US' -Email a@a.com
```

opens a file picker to choose a file which is then uploaded to teh West US Azure region
and analysed with the SQL Server Diagnostic API

## PARAMETERS

### -file
Path to file

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
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
DATE    07/07/2017

## RELATED LINKS
