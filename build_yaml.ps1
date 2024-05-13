param (
    $outputDir = "output"
)

$ErrorActionPreference = 'stop'

# Importing functions from helper-functions.psm1
$helperFunctionsPath = "$PSScriptRoot\helper_scripts\helper-functions.psm1"
if (-not (Test-Path $helperFunctionsPath)){
    Write-Error "Helper functions not found at $helperFunctionsPath"
}
Write-Output "Importing module from $helperFunctionsPath"
Import-Module $helperFunctionsPath -Force

# Getting user input
$docker = Read-Host "Do you want to invoke flyway via a docker container? (y/n)"
if ($docker -eq "y") {
    Write-Error "Docker not implemented yet"
} elseif ($docker -ne "n") {
    Write-Error "Invalid input. Please enter 'y' or 'n'"
}
$jdbc = Read-Host "Enter the JDBC connection string for a build database. (Note: This database will be dropped and recreated. All data will be lost.)"

# Clue bat for users
Write-Warning "WARNING: The build database will be dropped and recreated. All data will be lost."

# Constructing the YAML pipeline
$buildYaml = Get-BuildYaml -docker $docker -jdbc $jdbc 
$pipelineYaml = Get-PipelineYaml -buildYaml $buildYaml  

# Exporting the YAML pipeline
if (-not (Test-Path $outputDir)){
    Write-Output "Creating output directory $outputDir"
    New-Item -ItemType Directory -Path $outputDir
}
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$outputFile = "$outputDir/pipeline-$timestamp.yaml"
$pipelineYaml | Set-Content $outputFile
