# Invoke-SQLDiagDumpAnalysis

## SYNOPSIS
Uploads a dump file to the SQL Server Diagnostics API for Analysis

## SYNTAX

```
Invoke-SQLDiagDumpAnalysis [-File] <Object> [[-ApiKey] <String>] [-Region] <String> [[-Email] <Object>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uploads a dump file to the SQL Server Diagnostics API for Analysis
Details here https://ecsapi.portal.azure-api.net/

It requires the APIKey parameter or the APIKey to be stored using Export-CliXML in the users profile
in a file named SQLDiag.Cred

## EXAMPLES

### EXAMPLE 1
```
Invoke-SQLDiagDumpAnalysis -File c:\temp\SQLDump073.mdmp -Region 'West Us' -Email 'a@a.com'
```

Uploads the file to the API and emails when it has completed

### EXAMPLE 2
```
Get-SQLDiagDumpFile | Invoke-SQLDiagDumpAnalysis -Region 'West US' -Email a@a.com
```

opens a file picker to choose a file which is then uploaded to the West US Azure region
and analysed with the SQL Server Diagnostic API

## PARAMETERS

### -File
The File Path or File object of the dump file to be analysed

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ApiKey
The APIKey used to authenticate against the API.
You can get one from https://ecsapi.portal.azure-api.net/

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Region
The Azure Region to upload the file to.
Get-SQLDiagSupportedRegions shows the available regions

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Email
The email address to receive notification that analysis has completed and the recommendations

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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
DATE    10/07/2017

## RELATED LINKS
