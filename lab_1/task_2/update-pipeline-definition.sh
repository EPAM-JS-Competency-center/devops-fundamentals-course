#!/bin/bash

source ./utils/validate-jq.sh
source ./utils/validate-JSON.sh
source ./utils/validate-path.sh
source ./utils/perfome-actions.sh

INPUT_JSON="$1"

validatePath $INPUT_JSON
validateJSON $INPUT_JSON

TIMESTAMP=$(date +"%Y%m%d%H%M%S")
OUTPUT_JSON="pipeline-$TIMESTAMP.json"
DEFAULT_BRANCH="main"
DEFAULT_POLL_FOR_SOURCE_CHANGES="false"

if [ "$#" -eq 1 ]; then
    performActions $INPUT_JSON
else
    while [[ "$#" -gt 1 ]]; do
        case $2 in
            --branch)
                BRANCH="$3"
                shift
                ;;
            --owner)
                OWNER="$3"
                shift
                ;;
            --poll-for-source-changes)
                POLL_FOR_SOURCE_CHANGES="$3"
                shift
                ;;
            --configuration)
                BUILD_CONFIGURATION="$3"
                shift
                ;;
            *)
                echo "Unknown parameter: $1"
                exit 1
                ;;
        esac
        shift
    done

    BRANCH="${BRANCH:-$DEFAULT_BRANCH}"
    POLL_FOR_SOURCE_CHANGES="${POLL_FOR_SOURCE_CHANGES:-$DEFAULT_POLL_FOR_SOURCE_CHANGES}"

    cd "$(dirname "$INPUT_JSON")"

    jq --arg branch "$BRANCH" --arg owner "$OWNER" --argjson pollForSourceChanges "$POLL_FOR_SOURCE_CHANGES" '.pipeline.stages[0].actions[0].configuration.Branch = $branch | .pipeline.stages[0].actions[0].configuration.Owner = $owner | .pipeline.stages[0].actions[0].configuration.PollForSourceChanges = $pollForSourceChanges | .pipeline.version += 1' "$(basename "$INPUT_JSON")" | jq 'del(.metadata)' > "$OUTPUT_JSON"

    jq --arg buildConfig "$BUILD_CONFIGURATION" '.pipeline.stages[1].actions[0].configuration.EnvironmentVariables = "[{\"name\":\"BUILD_CONFIGURATION\",\"value\": " + $buildConfig + ",\"type\":\"PLAINTEXT\"}]" | .pipeline.stages[3].actions[0].configuration.EnvironmentVariables = "[{\"name\":\"BUILD_CONFIGURATION\",\"value\": " + $buildConfig + ",\"type\":\"PLAINTEXT\"}]"' "$OUTPUT_JSON" > "$OUTPUT_JSON.tmp" && mv "$OUTPUT_JSON.tmp" "$OUTPUT_JSON"

    echo "Pipeline updated and new file is $OUTPUT_JSON"
fi
