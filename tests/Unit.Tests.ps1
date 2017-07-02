$script:ModuleName = 'SQLDiagAPI'
# Removes all versions of the module from the session before importing
Get-Module $ModuleName | Remove-Module
$ModuleBase = Split-Path -Parent $MyInvocation.MyCommand.Path
# For tests in .\Tests subdirectory
if ((Split-Path $ModuleBase -Leaf) -eq 'Tests') {
    $ModuleBase = Split-Path $ModuleBase -Parent
}

Import-Module $ModuleBase\$ModuleName.psd1 -ErrorAction Stop #| Out-Null
InModuleScope -ModuleName SQLDiagAPI {
    Describe "Get-SQLDiagRecommendations" -Tags Build , Unit, Recommendations {

        Context "Requirements" {
            BeforeAll {
                Mock Test-Path {$false}
                Mock Write-Warning {"Warning"}
            }
            It "Should throw a warning if there is no API Key XML File and the APIKey Parameter is not used" {
                Get-SQLDiagRecommendations -ErrorAction SilentlyContinue | Should Be "Warning"
            }
            It 'Checks the Mock was called for Test-Path' {
                $assertMockParams = @{
                    'CommandName' = 'Test-Path'
                    'Times'       = 1
                    'Exactly'     = $true
                }
                Assert-MockCalled @assertMockParams 
            }
            It 'Checks the Mock was called for Write-Warning' {
                $assertMockParams = @{
                    'CommandName' = 'Write-Warning'
                    'Times'       = 1
                    'Exactly'     = $true
                }
                Assert-MockCalled @assertMockParams 
            }

        }
        Context "Input" {

        }
        Context "Execution" {
            It "Returns a warning if unable to get Machine GUID" {
                Mock Get-MachineGUID {} -Verifiable
                Mock Write-Warning {"Warning"} -Verifiable
                Get-SQLDiagRecommendations -APIKey dummykey | Should Be "Warning"
                Assert-VerifiableMocks 
            }

        }
        Context "Output" {
        
        }
    }

    Describe "Get-SQLDiagLatestCU" -Tags Build , Unit,LatestCUs {
        BeforeAll {
            $Recommendations = (Get-Content $PSScriptRoot\json\recommendations.JSON) -join "`n" | ConvertFrom-Json
            Mock Get-SQLDiagRecommendations {$Recommendations}
            Mock Write-Warning {"warning"}
        }
        Context "Input" {
            It "Accepts Recommendations input via Pipeline" {
                Get-SQLDiagRecommendations | Get-SQLDiagLatestCU -ErrorAction SilentlyContinue| Should Not Be NullOrEmpty
                {Get-SQLDiagRecommendations | Get-SQLDiagLatestCU} | Should Not Throw
            }
            It "Accepts Recommendations input via Parameter" {
                Get-SQLDiagLatestCU -Recommendations $Recommendations -ErrorAction SilentlyContinue| Should Not Be NullOrEmpty
            }
            It "Accepts Product via Parameter" {
                Get-SQLDiagLatestCU -Product 'SQL Server 2012 SP3' | Should Not BeNullOrEmpty
                {Get-SQLDiagLatestCU -Product 'SQL Server 2012 SP3' } | Should Not throw
            }
            It "Accepts Product without a Parameter name" {
                                Get-SQLDiagLatestCU 'SQL Server 2012 SP3' | Should Not BeNullOrEmpty
                {Get-SQLDiagLatestCU  'SQL Server 2012 SP3' } | Should Not throw
            }
            It "Accepts single product from the pipeline" {
                Get-SQLDiagProduct 2012 | Get-SQLDiagLatestCU | Should Not BeNullOrEmpty
                {Get-SQLDiagProduct 2012 | Get-SQLDiagLatestCU} | Should Not throw
            }
            It "Accepts multiple products from the pipeline" {
                Get-SQLDiagProduct 2014 | Get-SQLDiagLatestCU | Should Not BeNullOrEmpty
                {Get-SQLDiagProduct 2014 | Get-SQLDiagLatestCU} | Should Not throw
            }
            It "Learnmore switch throws a warning if no Product specified" {
                Get-SQLDiagLatestCU -LearnMore | Should Be "warning"
            }
            It "Learnmore switch throws a warning if multiple Products specified" {
                Get-SQLDiagLatestCU -Product 'SQL Server 2012 SP3', 'SQL Server 2014 SP1' -LearnMore | Should Be "warning"
            }
            It "Download switch throws a warning if no Product specified" {
                Get-SQLDiagLatestCU -Download | Should Be "warning"
            }
            It "Download switch throws a warning if multiple Products specified" {
                Get-SQLDiagLatestCU -Product 'SQL Server 2012 SP3','SQL Server 2014 SP1' -Download | Should Be "warning"
            }
            It 'Checks the Mock was called for Write-Warning' {
                $assertMockParams = @{
                    'CommandName' = 'Write-Warning'
                    'Times'       = 4
                    'Exactly'     = $true
                }
                Assert-MockCalled @assertMockParams 
            }
            It 'Checks the Mock was called for Get-SQLDiagRecommendations' {
                $assertMockParams = @{
                    'CommandName' = 'Get-SQLDiagRecommendations'
                    'Times'       = 36
                    'Exactly'     = $true
                }
                Assert-MockCalled @assertMockParams 
            }
        }
        Context "Execution" {

        }
        Context "Output" {
            BeforeAll {
                $NoProductParameters = (Get-Content $PSScriptRoot\json\LatestCuProductDefault.JSON) -join "`n" | ConvertFrom-Json
                Mock Start-Process {"browser"}
            }
            It "Returns expected values with no Product Parameter" {
                
                Compare-Object (Get-SQLDiagLatestCU -Recommendations (Get-SQLDiagRecommendations)) $NoProductParameters | Should BeNullOrEmpty
            }
            $TestCases = @{ ProductName = 'SQL Server 2012 SP3'},
            @{ ProductName = 'SQL Server 2016 SP1'},
            @{ ProductName = 'SQL Server 2016 RTM'},
            @{ ProductName = 'SQL Server 2014 SP1'}, 
            @{ ProductName = 'SQL Server 2014 SP2'} 
            It "Should Return only the filtered Product CU for <ProductName>" -TestCases $TestCases {
                Param($ProductName)
                $Results = $NoProductParameters.Where{$_.Product -eq $ProductName}
                Compare-Object (Get-SQLDiagLatestCU -Recommendations (Get-SQLDiagRecommendations) -Product $ProductName) $Results |Should BeNullOrEmpty
            }
            $TestCases = @{ ProductName = 'SQL Server 2012 SP3', 'SQL Server 2016 SP1'},
            @{ ProductName = 'SQL Server 2012 SP3', 'SQL Server 2016 SP1', 'SQL Server 2016 RTM'},
            @{ ProductName = 'SQL Server 2012 SP3', 'SQL Server 2016 SP1', 'SQL Server 2016 RTM', 'SQL Server 2014 SP1'},
            @{ ProductName = 'SQL Server 2012 SP3', 'SQL Server 2016 SP1', 'SQL Server 2016 RTM', 'SQL Server 2014 SP1', 'SQL Server 2014 SP2'}
            It "Should Return only the filtered Product CU for multiple Products <ProductName>" -TestCases $TestCases {
                Param($ProductName)
                $Results = $NoProductParameters.Where{$_.Product -in $ProductName}
                Compare-Object (Get-SQLDiagLatestCU -Recommendations (Get-SQLDiagRecommendations) -Product $ProductName) $Results |Should BeNullOrEmpty
            }
            It "LearnMore switch opens a browser with a Product specified" {
                Get-SQLDiagLatestCU -Product 'SQL Server 2012 SP3' -LearnMore | Should Be "browser"
            }
            It "Download switch opens a browser with a Product specified" {
                Get-SQLDiagLatestCU -Product 'SQL Server 2012 SP3' -Download | Should Be "browser"
            }
            It 'Checks the Mock was called for Get-SQLDiagRecommendations' {
                $assertMockParams = @{
                    'CommandName' = 'Get-SQLDiagRecommendations'
                    'Times'       = 33
                    'Exactly'     = $true
                }
                Assert-MockCalled @assertMockParams 
            }
            It 'Checks the Mock was called for Start-Process' {
                $assertMockParams = @{
                    'CommandName' = 'Start-Process'
                    'Times'       = 2
                    'Exactly'     = $true
                }
                Assert-MockCalled @assertMockParams 
            }
        }
    }

    Describe "Get-SQLDiagProduct" -Tags Build , Unit,Product {
        BeforeAll {
            $Recommendations = (Get-Content $PSScriptRoot\json\recommendations.JSON) -join "`n" | ConvertFrom-Json
            Mock Get-SQLDiagRecommendations {$Recommendations}
        }
        Context "Input" {
            It "Uses the default value for Recommendations" {
                Get-SQLDiagProduct -ErrorAction SilentlyContinue| Should Not Be NullOrEmpty
            }
            It "Accepts Recommendations input via Pipeline" {
                Get-SQLDiagRecommendations | Get-SQLDiagProduct -ErrorAction SilentlyContinue| Should Not Be NullOrEmpty
                {Get-SQLDiagRecommendations | Get-SQLDiagProduct} | Should Not Throw
            }
            It "Accepts Recommendations input via Parameter" {
                Get-SQLDiagProduct -Recommendations $Recommendations -ErrorAction SilentlyContinue| Should Not Be NullOrEmpty
            }
            It "Accepts Product Search without a parameter name" {
                Get-SQLDiagProduct 2012 | Should Be "SQL Server 2012 SP3"
            }
            It "It accepts a string for Product" {
                {Get-SQLDiagRecommendations | Get-SQLDiagProduct -Product SQL} | Should Not Throw
            }
            It 'Checks the Mock was called for Get-SQLDiagRecommendations' {
                $assertMockParams = @{
                    'CommandName' = 'Get-SQLDiagRecommendations'
                    'Times'       = 8
                    'Exactly'     = $true
                }
                Assert-MockCalled @assertMockParams 
            }

        }
        Context "Execution" {

        }
        Context "Output" {
            It "Returns the correct data without a product" {
                Compare-Object (Get-SQLDiagProduct) $Recommendations.Recommendations.Product | Should BeNullOrEmpty
            }
            It "Returns a single object for a search" {
                $Results = $Recommendations.Recommendations.Product.Where{$_ -like '*2012*'}
                Compare-Object (Get-SQLDiagRecommendations | Get-SQLDiagProduct -Product 2012) $results | Should BeNullOrEmpty
            }
            It "Returns multiple object for a search" {
                $Results = $Recommendations.Recommendations.Product.Where{$_ -like '*2014*'}
                Compare-Object (Get-SQLDiagRecommendations | Get-SQLDiagProduct -Product 2014) $results | Should BeNullOrEmpty
            }    
            It 'Checks the Mock was called for Get-SQLDiagRecommendations' {
                $assertMockParams = @{
                    'CommandName' = 'Get-SQLDiagRecommendations'
                    'Times'       = 5
                    'Exactly'     = $true
                }
                Assert-MockCalled @assertMockParams 
            }
        }
    }
    Describe "Get-SQLDiagFeature" -Tags Build , Unit, Feature {
        BeforeAll {
            $Recommendations = (Get-Content $PSScriptRoot\json\recommendations.JSON) -join "`n" | ConvertFrom-Json
            Mock Get-SQLDiagRecommendations {$Recommendations}
        }
        Context "Input" {
            It "Uses the default value for Recommendations" {
                Get-SQLDiagFeature -ErrorAction SilentlyContinue| Should Not Be NullOrEmpty
            }
            It "Accepts Recommendations input via Pipeline" {
                Get-SQLDiagRecommendations | Get-SQLDiagFeature -ErrorAction SilentlyContinue| Should Not Be NullOrEmpty
                {Get-SQLDiagRecommendations | Get-SQLDiagFeature} | Should Not Throw
            }
            It "Accepts Recommendations input via Parameter" {
                Get-SQLDiagFeature -Recommendations $Recommendations -ErrorAction SilentlyContinue| Should Not Be NullOrEmpty
            }
            It "Accepts Product via Parameter" {
                Get-SQLDiagFeature -Product 'SQL Server 2012 SP3' | Should Not BeNullOrEmpty
                {Get-SQLDiagFeature -Product 'SQL Server 2012 SP3' } | Should Not throw
            }
            It "Accepts single product from the pipeline" {
                Get-SQLDiagProduct 2012 | Get-SQLDiagFeature | Should Not BeNullOrEmpty
                {Get-SQLDiagProduct 2012 | Get-SQLDiagFeature} | Should Not throw
            }
            It "Accepts multiple products from the pipeline" {
                Get-SQLDiagProduct 2014 | Get-SQLDiagFeature | Should Not BeNullOrEmpty
                {Get-SQLDiagProduct 2014 | Get-SQLDiagFeature} | Should Not throw
            }
            It "Accepts Feature search by Parameter" {
                Get-SQLDiagFeature -Feature Always | Should Not BeNullOrEmpty
                {Get-SQLDiagFeature -Feature Always } | Should Not throw
            }
            It "Accepts Feature search by Parameter with Product by pipeline" {
                Get-SQLDiagProduct 2012 | Get-SQLDiagFeature -Feature Always | Should Not BeNullOrEmpty
                {Get-SQLDiagProduct 2012 |Get-SQLDiagFeature -Feature Always } | Should Not throw
            }
            It "Accepts Product and Feature search by Parameter" {
                Get-SQLDiagFeature -Product 'SQL Server 2012 SP3' -Feature Always | Should Not BeNullOrEmpty
                {Get-SQLDiagFeature -Product 'SQL Server 2012 SP3' -Feature Always } | Should Not throw
            }
            It "Accepts Product and Feature search without Parameter" {
                Get-SQLDiagFeature -Product 'SQL Server 2012 SP3' Always | Should Not BeNullOrEmpty
                {Get-SQLDiagFeature -Product 'SQL Server 2012 SP3' Always } | Should Not throw
            }
            It "Accepts Feature search without Parameter with Product by pipeline" {
                Get-SQLDiagProduct 2012 | Get-SQLDiagFeature Always | Should Not BeNullOrEmpty
                {Get-SQLDiagProduct 2012 |Get-SQLDiagFeature Always } | Should Not throw
            }
            It 'Checks the Mock was called for Get-SQLDiagRecommendations' {
                $assertMockParams = @{
                    'CommandName' = 'Get-SQLDiagRecommendations'
                    'Times'       = 47
                    'Exactly'     = $true
                }
                Assert-MockCalled @assertMockParams 
            }

        }
        Context "Execution" {

        }
        Context "Output" {     

            It "With No parameter returns a unique list of features" {
                $Results = (Get-Content $PSScriptRoot\json\Features.JSON) -join "`n" | ConvertFrom-Json
                Compare-Object (Get-SQLDiagFeature) $results | Should BeNullOrEmpty
            }
            $TestCases = @{ ProductName = 'SQL Server 2012 SP3'},
            @{ ProductName = 'SQL Server 2016 SP1'},
            @{ ProductName = 'SQL Server 2016 RTM'},
            @{ ProductName = 'SQL Server 2014 SP1'}, 
            @{ ProductName = 'SQL Server 2014 SP2'} 
            It "Returns the features for a single product <ProductName>" -TestCases $TestCases {
                Param($ProductName)
                $Features = (Get-Content $PSScriptRoot\json\ProductFeatures.JSON) -join "`n" | ConvertFrom-Json
                $results = $features.Where{$_.Product -eq $ProductName}.Feature
                Compare-Object (Get-SQLDiagFeature -Product $ProductName) $results | Should BeNullOrEmpty
            }
            $TestCases = @{ ProductName = 'SQL Server 2012 SP3', 'SQL Server 2016 SP1'},
            @{ ProductName = 'SQL Server 2012 SP3', 'SQL Server 2016 SP1', 'SQL Server 2016 RTM'},
            @{ ProductName = 'SQL Server 2012 SP3', 'SQL Server 2016 SP1', 'SQL Server 2016 RTM', 'SQL Server 2014 SP1'},
            @{ ProductName = 'SQL Server 2012 SP3', 'SQL Server 2016 SP1', 'SQL Server 2016 RTM', 'SQL Server 2014 SP1', 'SQL Server 2014 SP2'}
            It "Should Return only the filtered features for multiple Products <ProductName>" -TestCases $TestCases {
                Param($ProductName)
                $Features = (Get-Content $PSScriptRoot\json\ProductFeatures.JSON) -join "`n" | ConvertFrom-Json
                $results = $features.Where{$_.Product -in $ProductName} | Select-Object Feature -Unique -ExpandProperty Feature 
                Compare-Object (Get-SQLDiagFeature -Product $ProductName) $results | Should BeNullOrEmpty}
            It "Should return the correct result for a feature search without a product"{
                $Features = (Get-Content $PSScriptRoot\json\ProductFeatures.JSON) -join "`n" | ConvertFrom-Json
                $results = $features.Where{$_.Feature -like '*Al*'} | Select-Object Feature -Unique -ExpandProperty Feature
                Compare-Object (Get-SQLDiagFeature -Feature Al) $results | Should BeNullOrEmpty
            }
            $TestCases = @{ ProductName = 'SQL Server 2012 SP3'},
            @{ ProductName = 'SQL Server 2016 SP1'},
            @{ ProductName = 'SQL Server 2016 RTM'},
            @{ ProductName = 'SQL Server 2014 SP1'}, 
            @{ ProductName = 'SQL Server 2014 SP2'} 
            It "Should return the correct result for a feature search with a single product <ProductName>" -TestCases $TestCases{
                param($productname)
                $Features = (Get-Content $PSScriptRoot\json\ProductFeatures.JSON) -join "`n" | ConvertFrom-Json
                $results = $features.Where{$_.Product -in $ProductName -and $_.Feature -like '*Al*'} | Select-Object Feature -Unique -ExpandProperty Feature
                Compare-Object (Get-SQLDiagProduct $productname | Get-SQLDiagFeature -Feature Al) $results | Should BeNullOrEmpty
            }
            $TestCases = @{ ProductName = '2012'},
            @{ ProductName = '2014'},
            @{ ProductName = '2016'}
            It "Should Return the correct result for a feature search for multiple Products <ProductName>" -TestCases $TestCases {
                Param($ProductName)
                $Features = (Get-Content $PSScriptRoot\json\ProductFeatures.JSON) -join "`n" | ConvertFrom-Json
                $results = $features.Where{$_.Product -like "*$($ProductName)*" -and $_.Feature -like '*Al*'} | Select-Object Feature -Unique -ExpandProperty Feature
                Compare-Object (Get-SQLDiagProduct $productname | Get-SQLDiagFeature -Feature Al) $results | Should BeNullOrEmpty
            }
            It 'Checks the Mock was called for Get-SQLDiagRecommendations' {
                $assertMockParams = @{
                    'CommandName' = 'Get-SQLDiagRecommendations'
                    'Times'       = 56
                    'Exactly'     = $true
                }
                Assert-MockCalled @assertMockParams 
            }
        }
    }


}
