# Contributing.md
This is the contribute.md of our project. 

Great to have you here! 

You are welcome to fork this repository do some work and create a pull request. If you do not know how to do this do not worry. Chrissy LeMaire has written an [excellent guide](https://github.com/sqlcollaborative/dbatools/wiki/Your-First-Pull-Request) and even a [video](https://www.youtube.com/watch?v=-OJdRhfV4Xg) to show you the steps to take

I highly recommend that you use visual Studio Code to develop this module

For the SQLDiagAPI module there are a number of Pester Tests. To understand how the module was created and the steps that I have taken to develop the initial commands you can read my [blog post](http://sqldbawithabeard.com/2017/06/30/creating-a-powershell-module-and-tdd-for-get-sqldiagrecommendations/)

In simple terms if you are writing a new command you should edit the [Unit.Tests.ps1](functions\Unit.Tests.ps1) file and add the scaffolding for the tests for the new command. You can copy and paste from existing commands.

You can see examples in that file of mocking other commands and asserting that the mocks have been called

The tests\json folder has a number of json files which are used to validate the results of the code without needing to be online

When writing code I will write a test and then from the root of the module run

    Invoke-Pester .\tests -Show Fails -Tag Unit

This will only run the tests that are tagged Unit (the ones in the Unit.Tests.ps1 file) and only display to the screen the Describe and Context titles and the failed tests. If you want to see all of the test results you can remove the -Show Fails but this will take longer to run

I will then write the code to pass the tests. The commit history will show this process in action

Repeat that until the command has been written and then run 

    Invoke-Pester .\tests -Show Fails -Tag ScriptAnalyzer

this will run the tests tagged ScriptAnalyzer in the Project.Tests.ps1 file to check that the code follows best guidelines according to the Script Analyzer Rules. If you want to see all of the test results you can remove the -Show Fails but this will take longer to run. If you get errors you can run

    Invoke-ScriptAnalyzer -Path PATHTOSCRIPTFILE

which will give you more information about the reason for the failure and the line numbers

Once that has passed then I run 

    Invoke-Pester .\tests -Tag Help -Show Fails

To run the tests to see if the help is correct for the functions.If you want to see all of the test results you can remove the -Show Fails but this will take longer to run.

Good help should include plenty of detailed examples. You can easily add help in Visual Studio Code. See [this blog post](https://sqldbawithabeard.com/2017/06/12/vs-code-automatic-dynamic-powershell-help/) for instructions

Then I run 

    Invoke-Pester .\tests -Tag Help -Show Fails

and then sync the repository