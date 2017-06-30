function Get-SQLDiagLatestCU {
    [cmdletbinding()]
    Param(
        [parameter(ValueFromPipelineByPropertyName, 
            ValueFromPipeline,
            Mandatory=$true)]
        [ValidateNotNull()]
        [pscustomobject]$Recommendations)

        $Recommendations
}