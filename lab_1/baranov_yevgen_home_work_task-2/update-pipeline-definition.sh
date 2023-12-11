#!/bin/bash

# Check for the presence of JQ
jq_path=$(command -v jq)

if [ -z "$jq_path" ]; then
    echo "JQ not found. To install JQ:"
    echo "On Ubuntu/Debian: sudo apt-get install jq"
    echo "On CentOS/Fedora: sudo yum install jq"
    echo "On macOS (via Homebrew): brew install jq"
    echo "On Windows (via Chocolatey): choco install jq"
    exit 1
fi

# Function to display usage help for the script
show_help() {
    echo "Usage: $0 <path_to_JSON_file> [additional_options]"
    echo "Additional options:"
    echo "  -b, --branch <value>                     Set the Branch property value"
    echo "  -o, --owner <value>                      Set the Owner property value"
    echo "  -r, --repo <value>                       Set the Repo property value"
    echo "  -p, --poll-for-source-changes <value>    Set the PollForSourceChanges property value (true/false)"
    echo "  -c, --configuration <value>              Set the BUILD_CONFIGURATION property value"
    echo "  --help                                   Display this help message"
    echo
    echo "Usage Examples:"
    echo "  $0 ./pipeline.json --branch feat/cicd-lab --poll-for-source-changes true"
}

# If --help argument is passed, show help and exit the script
if [ "$1" == "--help" ]; then
    show_help
    exit 0
fi

# Check if the argument with the path to JSON file is passed
if [ $# -lt 1 ]; then
    echo "Executing only actions 1.1 and 1.2: removing the metadata property and incrementing the version property"
    echo "Usage: $0 <path_to_JSON_file> [additional_options]"
    echo "Use '$0 --help' for instructions on script usage."
    exit 1
fi

input_file="$1"

# Check if the file with the specified path exists
if [ ! -f "$input_file" ]; then
    echo "File $input_file not found."
    exit 1
fi

# Request for the pipeline’s definitions file path
read -p "Please enter the pipeline’s definitions file path (default: pipeline.json): " input_file
input_file=${input_file:-"pipeline.json"}

# Request for the BUILD_CONFIGURATION name
read -p "Which BUILD_CONFIGURATION name are you going to use (default: \"\"):" configuration

# Request for the GitHub repository owner/account
read -p "Enter a GitHub owner/account: " owner

# Request for the GitHub repository name
read -p "Enter a GitHub repository name: " repo

# Request for the GitHub branch name (with a default value)
read -p "Enter a GitHub branch name (default: develop): " branch
branch=${branch:-"develop"}

# Prompt for checking whether to poll for changes (yes/no)
read -p "Do you want the pipeline to poll for changes (yes/no) (default: no)?: " poll_for_source_changes
poll_for_source_changes=${poll_for_source_changes:-"no"}

# Prompt for saving changes (yes/no)
read -p "Do you want to save changes (yes/no) (default: yes)?: " save_changes
save_changes=${save_changes:-"yes"}

# Check for JQ existence again
jq_path=$(command -v jq)

if [ -z "$jq_path" ]; then
    echo "JQ not found. To install JQ:"
    echo "On Ubuntu/Debian: sudo apt-get install jq"
    echo "On CentOS/Fedora: sudo yum install jq"
    echo "On macOS (via Homebrew): brew install jq"
    echo "On Windows (via Chocolatey): choco install jq"
    exit 1
fi

# Check if the argument with the path to JSON file is passed
if [ $# -lt 1 ]; then
    echo "Executing only actions 1.1 and 1.2: removing the metadata property and incrementing the version property"
    echo "Usage: $0 <path_to_JSON_file> [additional_options]"
    exit 1
fi

input_file="$1"

# Check if the file with the specified path exists
if [ ! -f "$input_file" ]; then
    echo "File $input_file not found."
    exit 1
fi

# Check for additional parameters
if [ $# -eq 1 ]; then
    jq_filter='
        del(.metadata) |
        walk(if type == "object" and has("version") then .version += 1 else . end)
    '

    jq "$jq_filter" "$input_file" > output.json

    echo "The metadata property was removed, the value of the version property was incremented by 1, and saved to the file output.json"
    exit 0
fi

# Default parameter values
branch="main"
owner=""
repo=""
poll_for_source_changes="false"
configuration=""

# Read other parameters if passed to the script
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -b|--branch) branch="$2"; shift ;;
        -o|--owner) owner="$2"; shift ;;
        -r|--repo) repo="$2"; shift ;;
        -p|--poll-for-source-changes) poll_for_source_changes="$2"; shift ;;
        -c|--configuration) configuration="$2"; shift ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

jq_filter='
    del(.metadata) |
    walk(if type == "object" and has("version") then .version += 1 else . end) |
    .pipeline.stages[] |
    select(.name == "Source") |
    .actions[].configuration |=
        if has("Branch") then
            .Branch = $branch
        else
            . + { "Branch": $branch }
        end |
        if has("Owner") then
            .Owner = $owner
        else
            . + { "Owner": $owner }
        end |
        if has("Repo") then
            .Repo = $repo
        else
            . + { "Repo": $repo }
        end |
        .PollForSourceChanges = ($poll_for_source_changes | test("true"; "i")) |
        .EnvironmentVariables = [{ "name": "BUILD_CONFIGURATION", "value": $configuration, "type": "PLAINTEXT" }]
'

jq --arg branch "$branch" --arg owner "$owner" --arg repo "$repo" --arg poll_for_source_changes "$poll_for_source_changes" --arg configuration "$configuration" "$jq_filter" "$input_file" > output.json

echo "The metadata property was removed, the value of the version property was incremented by 1, properties Branch, Owner, Repo, PollForSourceChanges, and EnvironmentVariables were modified, and saved to the file output.json"
