#!/bin/bash

# @see: https://docs.aws.amazon.com/cli/latest/reference/codepipeline/update-pipeline.html

defaultPipeline="pipeline"
customPipelineChoice="custom"

# colors
red=$'\e[1;31m'
grn=$'\e[1;32m'
#yel=$'\e[1;33m'
#blu=$'\e[1;34m'
#mag=$'\e[1;35m'
#cyn=$'\e[1;36m'
end=$'\e[0m'

checkJQ() {
  # jq test
  type jq >/dev/null 2>&1
  exitCode=$?

  if [ "$exitCode" -ne 0 ]; then
    printf "  ${red}'jq' not found! (json parser)\n${end}"
    printf "    Ubuntu Installation: sudo apt install jq\n"
    printf "    Redhat Installation: sudo yum install jq\n"
    jqDependency=0
  else
    if [ "$DEBUG" -eq 1 ]; then
      printf "  ${grn}'jq' found!\n${end}"
    fi
  fi

  if [ "$jqDependency" -eq 0 ]; then
    printf "${red}Missing 'jq' dependency, exiting.\n${end}"
    exit 1
  fi
}

# perform checks:
checkJQ

echo -n "Enter a CodePipeline name (or $customPipelineChoice)(default: $defaultPipeline): "
read -r pipelineName

pipelineName=$(checkPipelineName "$pipelineName")

if [ "$pipelineName" = "$customPipelineChoice" ]; then
  echo -n "Enter a CodePipeline name: "
  read -r pipelineName
fi

defaultBranchName="develop"

echo -n "Enter a source branch to use (default: $defaultBranchName): "
read -r branchName
branchName=${branchName:-$defaultBranchName}

#echo "${pipelineName}"
#echo "${branchName}"

pipelineJson="pipeline.json"

# get pipeline metadata
#aws codepipeline get-pipeline --name "${pipelineName}" >"$pipelineJson" || exit 1

# upd source branch
jq --arg branchName "$branchName" '.pipeline.stages[0].actions[0].configuration.BranchName = $branchName' "$pipelineJson" >tmp.$$.json && mv tmp.$$.json "$pipelineJson"
# remove metadata
jq 'del(.metadata)' "$pipelineJson" > tmp.$$.json && mv tmp.$$.json "$pipelineJson"

#defaultProceedOpt="y"
#
#cat "$pipelineJson"
#echo -n "Proceed with ${pipelineName} pipeline update (y/n) (default: $defaultProceedOpt): "
#read -r doProceed
#
#doProceed=${doProceed:-$defaultProceedOpt}
#
#if [ "$doProceed" = "n" ]; then
#  echo "The ${pipelineName} pipeline update has been terminated."
#  exit 0
#fi

# update pipeline
#aws codepipeline update-pipeline --cli-input-json "file://${pipelineJson}"

#echo -n "The ${pipelineName} pipeline has been updated successfully."
#
#echo -n "Trigger the ${pipelineName} pipeline execution (y/n) (default: n):"
#read -r doExecute

# trigger or not the pipeline
#if [ "$doExecute" = "y" ]; then
#  aws codepipeline start-pipeline-execution --name "${pipelineName}"
#
#  echo "The ${pipelineName} pipeline has been successfully executed."
#else
#  echo "The ${pipelineName} pipeline execution has been terminated."
#fi

exit 0
