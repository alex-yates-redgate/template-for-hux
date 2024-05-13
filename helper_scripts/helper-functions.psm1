Function Get-BuildYaml {
    param (
        $docker,
        $jdbc
    )

    # Data validation
    if ($docker -like "y") {
        Write-Error "Docker not implemented yet"
    } elseif ($docker -notlike "n") {
        Write-Error "Invalid input. Please enter 'y' or 'n'"
    }

    if ($jdbc -like "") {
        Write-Error "JDBC connection string cannot be empty"
    }

    if ($jdbc -notlike "jdbc:*") {
        Write-Error "JDBC connection string not in correct format"
    }

    # Getting the content of the sample build.yaml file
    $buildYamlRaw = Get-Content $psScriptRoot\sample-build.yaml -raw
    
    # Swapping out the placeholders with the user input
    $buildYaml = $buildYamlRaw -replace "_JDBC_", $jdbc

    # Returning sample build yaml
    return $buildYaml
}

Function Get-PipelineYaml {
    param (
        $buildYaml = "",
        $testYaml = ""
    )
    # Data validation
    if ($buildYaml -like "") {
        Write-Error "Build yaml cannot be empty"
    }
    if ($testYaml -notlike "") {
        Write-Error "Test YAML not implemented yet"
    }

    # Getting the content of the sample pipeline.yaml file
    $pipelineYamlRaw = Get-Content $psScriptRoot\sample-pipeline.yaml -raw

    # Swapping out the placeholders with the input
    $pipelineYaml = $pipelineYamlRaw -replace "_BUILD_STAGE_", $buildYaml

    # Returning sample build yaml
    return $pipelineYaml
}