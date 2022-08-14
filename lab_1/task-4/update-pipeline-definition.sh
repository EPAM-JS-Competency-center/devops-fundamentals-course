#!/bin/bash

defaultPipeline="pipeline"
defaultBranchName="develop"

pipelineJsonCopy="pipeline-$(date +'%m-%d-%Y').json"

## Colors
red=$'\e[1;31m'
grn=$'\e[1;32m'
end=$'\e[0m'

## Check if jq is installed
checkJQ() {
  type jq >/dev/null 2>/dev/null
  jqCheckResult=$?

  if [ "$jqCheckResult" -ne 0 ]; then
    printf "  ${red}'jq' not found! (json parser)\n${end}"
    printf "  MacOS Installation: brew install jq\n"
    printf "  Ubuntu Installation: sudo apt install jq\n"
    exit 1
  else
    printf "  ${grn}'jq' found!\n${end}"
  fi
}

checkFirstParam() {
  local command=$1
  ## -z tests if the expansion of "$1" is a null string
  if [[ -z $command ]]; then
    echo "No path to the pipeline definition JSON file is provided!"
    exit 1
  fi
}

pipelineJson=$1

# Perform checks:
checkJQ
checkFirstParam $pipelineJson

## Remove metadata
echo "Removing metadata..."
jq 'del(.metadata)' "$pipelineJson" > tmp.$$.json && mv tmp.$$.json "$pipelineJsonCopy"

## Perform only metadata delete and version upgrade if there is only one param provided.
if [ "$#" -eq "1" ]; then
  exit 0
fi

exit 0
