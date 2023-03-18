#!/bin/bash

defaultPipeline="pipeline"
customPipelineChoice="custom"
pipelinePath=$1

# colors
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

checkJQ() {
  # jq test
  type jq >/dev/null 2>&1
  exitCode=$?

  if [ "$exitCode" -ne 0 ]; then
    printf "  ${red}'jq' not found! (json parser)\n${end}"
    printf "    Ubuntu Installation: sudo apt install jq\n"
    printf "    Redhat Installation: sudo yum install jq\n"
    printf "    MacOS Installation: brew install jq\n"
    jqDependency=0
  fi
}

checkPipelineFile() {
  if [ -z "$pipelinePath" ]; then
    echo "Argument is missing."
    exit 1
  fi
  if [ ! -f "$1" ]; then
    echo "Argument is not a file."
    exit 1
  fi
}

joinBy() {
  local IFS="$1"
  shift
  echo "$*"
}

# perform checks
checkJQ
checkPipelineFile $1

echo "Removing metadata..."
timestamp=$(date "+%Y-%m-%d_%H-%M-%S")
outputFilename="pipeline-$timestamp.json"

branch="main"
configuration="debug"
owner=""
poll=false

while [ $# -gt 0 ] ; do
  case $1 in
    -b | --branch) branch="$2" ;;
    -c | --configuration) configuration="$2" ;;
    -o | --owner) owner="$2" ;;
    -p | --poll-for-source-changes) poll="$2" ;;

  esac
  shift
done

echo "$branch, $configuration, $owner, $poll"


# jq commands
jsonModifications=(
  "del(.metadata)" 
  ".pipeline.version += 1"
)
separator=' | '
joinedCommands=$(printf "${separator}%s" "${jsonModifications[@]}")
joinedCommands=${joinedCommands:${#separator}}

jq "$joinedCommands" "$pipelinePath" | tee "$outputFilename"

echo "✅ Successfully updated pipeline in $outputFilename"




exit 0
