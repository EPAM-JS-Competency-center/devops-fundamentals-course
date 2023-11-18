#!/bin/bash

function validateJSON {
    local FILE_JSON="$1"

    required_properties=(
        ".pipeline.stages[0].actions[0].configuration.Branch"
        ".pipeline.stages[0].actions[0].configuration.Owner"
        ".pipeline.version"
        ".pipeline.stages[1].actions[0].configuration.EnvironmentVariables"
        ".pipeline.stages[3].actions[0].configuration.EnvironmentVariables"
    )

    for property in "${required_properties[@]}"; do
        result=$(jq -e "$property" "$FILE_JSON")
        if [ "$result" == "null" ]; then
            echo "Error: $property is missing or has a null value in the JSON definition."
            exit 1
        fi
    done
}
