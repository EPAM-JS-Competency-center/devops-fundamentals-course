#!/bin/bash 
#===============================================================================
#
#          FILE: update-pipeline-definition.sh
# 
#         USAGE: ./update-pipeline-definition.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 03/15/2023 23:45
#     i REVISION:  ---
#===============================================================================

defaultPipeline="pipeline"
customPipelineChoice="custom"
defaultBranchName="develop"

# colors
red=$'\e[1;31m'
grn=$'\e[1;32m'
end=$'\e[0m'

printColorfulString() {
	local color=${2:-'\e[1;31m'};
	printf "  ${color}${1}\n${end}"
}

checkJQ() {
  # jq test
  type jq >/dev/null 2>&1
  exitCode=$?

  if [[ "$exitCode" -ne 0 ]]; then
    printColorfulString "'jq' not found! (json parser)"
    printf "    Ubuntu Installation: sudo apt install jq\n"
    printf "    Redhat Installation: sudo yum install jq\n"
    printColorfulString "Missing 'jq' dependency, exiting."
    exit 1
  else
    if [[ "$DEBUG" -eq 1 ]]; then
       printColorfulString "  'jq' found!" $grn
    fi   
  fi
}

# perform checks:
checkJQ

echo -n "Enter a CodePipeline name (or $customPipelineChoice)(default: $defaultPipeline): "
read -r pipelineName

pipelineJson=${pipeline:-"./$defaultPipeline.json"};

if [[ ! -f $pipelineJson ]]; then
   printColorfulString "$pipelineJson doesn't exists in current directory";
   exit 1;
fi

echo -n "Which BUILD_CONFIGURATION name are you going to use (default: “”): "
read -r buildConfiguration
buildConfiguration=${buildConfiguration:-""};

echo -n "Enter a GitHub owner/account: "
read -r owner

echo -n "Enter a source branch to use (default: $defaultBranchName): "
read -r branchName
branchName=${branchName:-$defaultBranchName};

echo -n "Do you want the pipeline to poll for changes (yes/no) (default: no)?: "
read -r shouldPollForChanges

if [[ ! $shouldPollForChanges =~ ^(Yes|yes)$ ]]; then
  shouldPollForChanges=true;
else 
  shouldPollForChanges=false;
fi

echo -n "Do you want to save changes (yes/no) (default: yes)?: "
read -r shouldSaveUpdates
shouldSaveUpdates=${shouldSaveUpdates:-'Yes'};

if [[ ! $shouldSaveUpdates =~ ^(Yes|yes)$ ]]; then
  echo "Exit";
  exit 0;
fi

targetJson="pipeline-$(date +%d-%m-%Y).json";

cat "$pipelineJson" > "$targetJson";

deleteMetadata(){
  local metaData=$(jq '.metadata' "$1");
  if [[ $metaData == null ]]; then
    printColorfulString "Error .metadata property doesn't exist in $1";
    exit 1;
  else
    jq 'del(.metadata)' "$1" > tmp.$$.json && mv tmp.$$.json "$1";
  fi
} 

updateVersion() {
  local version=$(jq '.pipeline.version' "$1");
  if [[ $version == null ]]; then
    printColorfulString "Unable to update version because .pipeline.version property doesn't exist in $1";
    exit 1;
  else
    jq '.pipeline.version += 1' "$1" > tmp.$$.json && mv tmp.$$.json "$1";
  fi
}

updateSourceBranch(){
  local branch=$(jq '.pipeline.stages[0].actions[0].configuration.Branch' "$1");
  if [[ $branch == null ]]; then
    printColorfulString "Unable to update branch because it property doesn't exist in $1";
    exit 1;
  else
   jq --arg branchName "$2" '.pipeline.stages[0].actions[0].configuration.Branch = $branchName' "$1" > tmp.$$.json && mv tmp.$$.json "$1";
  fi
}


updateOwner() {
  local owner=$(jq '.pipeline.stages[0].actions[0].configuration.Owner' "$1");
  if [[ $owner == null ]]; then
    printColorfulString "Unable to update owner because it property doesn't exist in $1";
    exit 1;
  else
    jq --arg owner "$2" '.pipeline.stages[0].actions[0].configuration.Owner = $owner' "$1" > tmp.$$.json && mv tmp.$$.json "$1";
 fi
}

updatePollForSourceChanges(){
  local pollForSourceChanges=$(jq '.pipeline.stages[0].actions[0].configuration.PollForSourceChanges' "$1");
  if [[ $pollForSourceChanges == null ]]; then
     printColorfulString "Unable to update poll for sources changes flag because it property doesn't exist in $1";
     exit 1;
  else
    jq --argjson pollForSourceChanges $2 '.pipeline.stages[0].actions[0].configuration.PollForSourceChanges = $pollForSourceChanges' "$1" > tmp.$$.json && mv tmp.$$.json "$1";
  fi
}

updateEnvValue(){
  local firstEnv=$(jq '.pipeline.stages[1].actions[0].configuration.EnvironmentVariables' "$1");
  local secondEnv=$(jq '.pipeline.stages[3].actions[0].configuration.EnvironmentVariables' "$1");
  if [[ $firstEnv == null || $secondEnv == null ]]; then
    printColorfulString "Unable to update env because it property doesn't exist in $1";
    exit 1;
  else
    jq --arg value "$2" '.pipeline.stages[].actions[].configuration.EnvironmentVariables |= (select(. != null) | sub("\"value\":\".*?\""; "\"value\":\"\($value)\""))' "$1" > tmp.$$.json && mv tmp.$$.json "$1";
  fi
}

deleteMetadata $targetJson;

updateVersion $targetJson;

updateSourceBranch $targetJson $branchName;

updateOwner $targetJson $owner;

updatePollForSourceChanges $targetJson $shouldPollForChanges;

updateEnvValue $targetJson $buildConfiguration;

printColorfulString "Executed successfuly. Pipeline file: $targetJson" $grn;
exit 0;
