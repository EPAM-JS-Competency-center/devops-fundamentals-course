#!/bin/bash

# To execute this script, you need to add execute permissions:
# chmod +x update-pipeline-definition.sh

set -e # stop on first error

if ! [ -x "$(command -v jq)" ]; then
  echo 'Error: jq is not installed. Install it using:
    - Debian/Ubuntu: sudo apt-get install jq
    - MacOS: brew install jq' >&2
  exit 1
fi

if [ $# -eq 0 ]; then
    echo "No arguments provided"
    echo "Usage: ./update-pipeline-definition.sh ./pipeline.json --configuration production --owner boale --branch feat/cicd-lab --poll-for-source-changes true"
    exit 1
fi

FILE=$1
DATE=$(date +"%Y%m%d%H%M%S")
OUTPUT_FILE="pipeline-${DATE}.json"
BRANCH="main"
OWNER=""
REPO=""
POLL_FOR_SOURCE_CHANGES="false"
BUILD_CONFIGURATION=""

# Parse optional parameters
while (( "$#" )); do
  case "$1" in
    --branch)
      BRANCH=$2
      shift 2
      ;;
    --owner)
      OWNER=$2
      shift 2
      ;;
    --repo)
      REPO=$2
      shift 2
      ;;
    --poll-for-source-changes)
      POLL_FOR_SOURCE_CHANGES=$2
      shift 2
      ;;
    --configuration)
      BUILD_CONFIGURATION=$2
      shift 2
      ;;
    *)
      shift
      ;;
  esac
done

# Check if the necessary properties are present
if jq -e '.pipeline' "$FILE" > /dev/null 2>&1; then
    echo "Pipeline property exists"
else
    echo "Pipeline property does not exist"
    exit 1
fi

if jq -e '.metadata' "$FILE" > /dev/null 2>&1; then
    echo "Metadata property exists"
else
    echo "Metadata property does not exist"
    exit 1
fi

# Remove metadata, increment version
jq 'del(.metadata) | .pipeline.version += 1' "$FILE" > $OUTPUT_FILE

# Apply additional parameters
if [ -n "$BRANCH" ]; then
    jq --arg BRANCH "$BRANCH" '.pipeline.stages[] | select(.name=="Source") | .actions[].configuration.Branch = $BRANCH' $OUTPUT_FILE > tmp.json && mv tmp.json $OUTPUT_FILE
fi

if [ -n "$OWNER" ]; then
    jq --arg OWNER "$OWNER" '.pipeline.stages[] | select(.name=="Source") | .actions[].configuration.Owner = $OWNER' $OUTPUT_FILE > tmp.json && mv tmp.json $OUTPUT_FILE
fi

if [ -n "$REPO" ]; then
    jq --arg REPO "$REPO" '.pipeline.stages[] | select(.name=="Source") | .actions[].configuration.Repo = $REPO' $OUTPUT_FILE > tmp.json && mv tmp.json $OUTPUT_FILE
fi

if [ -n "$POLL_FOR_SOURCE_CHANGES" ]; then
    jq --arg POLL_FOR_SOURCE_CHANGES "$POLL_FOR_SOURCE_CHANGES" '.pipeline.stages[] | select(.name=="Source") | .actions[].configuration.PollForSourceChanges = $POLL_FOR_SOURCE_CHANGES' $OUTPUT_FILE > tmp.json && mv tmp.json $OUTPUT_FILE
fi

if [ -n "$BUILD_CONFIGURATION" ]; then
    jq --arg BUILD_CONFIGURATION "$BUILD_CONFIGURATION" '.pipeline.stages[] | .actions[].configuration.EnvironmentVariables = "[{\"name\":\"BUILD_CONFIGURATION\",\"value\": $BUILD_CONFIGURATION, \"type\":\"PLAINTEXT\"}]"' $OUTPUT_FILE > tmp.json && mv tmp.json $OUTPUT_FILE
fi

echo "Pipeline JSON successfully updated and saved as $OUTPUT_FILE"
