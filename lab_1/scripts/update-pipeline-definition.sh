if ! command -v jq  &> /dev/null
then
    echo "jq could not be found, but can be easely installed with sudo"
    exit 0
fi

if [[ !($1 =~ pipeline\.json$) ]]
then
echo "Error: no path to pipeline file is provided"
exit 1
fi

if [[ $(jq '.pipeline.version' $1) == null ]]
then
    echo "Error: no .version field"
    exit 1
fi
if [[ $(jq '.pipeline.stages[1].actions[0].configuration.EnvironmentVariables' $1) == null ]]
then
    echo "Error: no .EnvironmentVariables field for stage 1"
    exit 1
fi
if [[ $(jq '.pipeline.stages[3].actions[0].configuration.EnvironmentVariables' $1) == null ]]
then
    echo "Error: no .EnvironmentVariables field for stage 2"
    exit 1
fi
if [[ $(jq '.metadata' $1) == null ]]
then
    echo "Error: no .metadata field"
    exit 1
fi
if [[ $(jq '.pipeline.stages[0].actions[0].configuration.Branch' $1) == null ]]
then
    echo "Error: no .Branch field"
    exit 1
fi
if [[ $(jq '.pipeline.stages[0].actions[0].configuration.Owner' $1) == null ]]
then
    echo "Error: no .Owner field"
    exit 1
fi
if [[ $(jq '.pipeline.stages[0].actions[0].configuration.PollForSourceChanges' $1) == null ]]
then
    echo "Error: no .PollForSourceChanges field"
    exit 1
fi

declare -i newVersion=$(jq .pipeline.version ../pipeline.json)+1
declare fileName="pipeline-$(date +"%Y-%m-%d").json"
touch $fileName

if [[ !($2) ]]
then
jq --arg version $newVersion 'del(.metadata) | .pipeline.version = $version' $1 > $fileName
exit 0
fi

declare BRANCH='main'
declare OWNER='boale'
declare POLL_FOR_SOURCE_CHANGES=false
declare BUILD_CONFIGURATION=''

declare currentParam
for i in "$@"
do
  case $currentParam in
    --branch) BRANCH=$i;;
    --owner) OWNER=$i;;
    --poll-for-source-changes) POLL_FOR_SOURCE_CHANGES=$i;;
    --configuration) BUILD_CONFIGURATION=$i;;
  esac
  currentParam=""
    
  case $i in
    --branch) currentParam="--branch";;
    --owner) currentParam="--owner";;
    --poll-for-source-changes) currentParam="--poll-for-source-changes";;
    --configuration) currentParam="--configuration";;
  esac
done

declare qualityGateValue=$(jq --arg configuration $BUILD_CONFIGURATION '.pipeline.stages[1].actions[0].configuration.EnvironmentVariables | fromjson | .[0].value = $configuration | tojson' $1)
declare buildStageValue=$(jq --arg configuration $BUILD_CONFIGURATION '.pipeline.stages[3].actions[0].configuration.EnvironmentVariables | fromjson | .[0].value = $configuration | tojson' $1)

jq --arg version $newVersion --arg branch $BRANCH --arg owner $OWNER --arg pollForSourceChanges $POLL_FOR_SOURCE_CHANGES --arg qualityGateValue $qualityGateValue --arg buildStageValue $buildStageValue 'del(.metadata) | .pipeline.version = $version | .pipeline.stages[0].actions[0].configuration.Branch = $branch | .pipeline.stages[0].actions[0].configuration.Owner = $owner | .pipeline.stages[0].actions[0].configuration.PollForSourceChanges = $pollForSourceChanges | .pipeline.stages[1].actions[0].configuration.EnvironmentVariables = $qualityGateValue | .pipeline.stages[3].actions[0].configuration.EnvironmentVariables = $buildStageValue' $1 > $fileName
