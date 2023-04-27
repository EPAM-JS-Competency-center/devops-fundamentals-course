#!/bin/bash

lab1Dir="/Users/$USER/Desktop/DOF/devops-fundamentals-course/lab_1"
defaultBranchName="main"

echo -n "Enter a source branch to use (default: $defaultBranchName): "
read -r branchName
branchName=${branchName:-$defaultBranchName}

cd "$lab1Dir" || exit

cp "$lab1Dir"/pipeline.json "$lab1Dir"/pipeline-"$(date +'%m-%d-%Y')".json

jq 'del(.metadata)' pipeline-"$(date +'%m-%d-%Y')".json > tmp.$$.json && mv tmp.$$.json pipeline-"$(date +'%m-%d-%Y')".json
jq '.pipeline.version = .pipeline.version + 1' pipeline-"$(date +'%m-%d-%Y')".json > tmp.$$.json && mv tmp.$$.json pipeline-"$(date +'%m-%d-%Y')".json
jq --arg branchName "$branchName" '.pipeline.stages[0].actions[0].configuration.Branch = $branchName' pipeline-"$(date +'%m-%d-%Y')".json > tmp.$$.json && mv tmp.$$.json pipeline-"$(date +'%m-%d-%Y')".json
