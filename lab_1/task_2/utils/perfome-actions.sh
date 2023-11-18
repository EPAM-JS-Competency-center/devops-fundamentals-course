#!/bin/bash

function performActions {
    local FILE_JSON="$1"

    jq 'del(.metadata)' "$FILE_JSON" > "${FILE_JSON}_temp" && mv "${FILE_JSON}_temp" "$FILE_JSON"
    jq '.pipeline.version += 1' "$FILE_JSON" > "${FILE_JSON}_temp" && mv "${FILE_JSON}_temp" "$FILE_JSON"

    echo "Actions 1.1 and 1.2 performed."
}