#!/bin/bash

function validatePath {
    local FILE_JSON="$1"

    if [ ! -f "$FILE_JSON" ]; then
        echo "Error: Please provide the path to the pipeline definition JSON file."
        echo
        echo "Example: $0 <path/to/pipeline.json> --configuration production --owner boale --branch feat/cicd-lab --poll-for-source-changes true"
        echo
        exit 1
    fi
}
