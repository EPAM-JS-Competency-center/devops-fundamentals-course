#!/bin/bash

SCRIPT_DIR=`dirname "$(readlink -f "$BASH_SOURCE")"`
ROOT_DIR=${SCRIPT_DIR%/*}
CLIENT_BUILD_DIR=$ROOT_DIR/dist/static

clientBuildFile=$ROOT_DIR/dist/client-app.zip
# echo $clientBuildFile

# For testing environment variables from .env
# export $(grep -v '^#' $ROOT_DIR/.env | xargs -d '\n')
# For Mac OS usage
# export $(grep -v '^#' ../.env | xargs -n1 '\n')

if [ -e "$clientBuildFile" ]; then
  rm "$clientBuildFile"
  echo "$clientBuildFile was removed."
else
  echo "No zip file found."
fi

ENV_CONFIGURATION=production

# Install the app’s npm dependencies.
npm i
# Invoke the client app’s build command with the --configuration flag.
npm run build -- --configuration=$ENV_CONFIGURATION --output-path=$CLIENT_BUILD_DIR
echo "Client app was built with $ENV_CONFIGURATION configuration."
# Compress all built content/files in one client-app.zip file in the dist folder.
zip -r $clientBuildFile $CLIENT_BUILD_DIR/*
