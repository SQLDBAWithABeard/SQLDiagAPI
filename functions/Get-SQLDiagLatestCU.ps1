function Get-SQLDiagLatestCU {
    [cmdletbinding()]
    Param(
        [parameter(ValueFromPipelineByPropertyName, 
            ValueFromPipeline,
            Mandatory = $true)]
        [ValidateNotNull()]
        [pscustomobject]$Recommendations,
        [parameter(Mandatory = $false)]
        [ValidateSet('SQL Server 2012 SP3',
            'SQL Server 2016 SP1',
            'SQL Server 2016 RTM',
            'SQL Server 2014 SP1',
            'SQL Server 2014 SP2')]
        [String[]]$Product
    )
    ## Much as I would love to have Products dynamically populated from the Recommendations parameter, this will not work for the pipeline
    ## I can make it work if Recommentations is a parameter but it need to work for the pipeline too
    ## If anyone know how to do this I would be grateful
    Begin {}
    Process {
        if (!($Product)) {
            foreach ($recommendation in $recommendations.Recommendations) {
                $ProductName = $recommendation.Product
                $CU = $recommendation.Title
                $CreatedOn = $recommendation.CreatedOn
                [PSCustomObject]@{
                    Product   = $ProductName
                    CU        = $CU
                    CreatedOn = $CreatedOn
                }
            }
        }
        else {
            foreach ($recommendation in $recommendations.Recommendations.Where{$_.Product -in $Product}) {
                $ProductName = $recommendation.Product
                $CU = $recommendation.Title
                $CreatedOn = $recommendation.CreatedOn
                [PSCustomObject]@{
                    Product   = $ProductName
                    CU        = $CU
                    CreatedOn = $CreatedOn
                }
            }
        }
    }
}
