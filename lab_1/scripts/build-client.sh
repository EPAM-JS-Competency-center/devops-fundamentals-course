#!/bin/bash

SCRIPT_DIR=`dirname "$(readlink -f "$BASH_SOURCE")"`
ROOT_DIR="${SCRIPT_DIR%/*}/app"
CLIENT_BUILD_DIR=$ROOT_DIR/dist/static

ENV_CONFIGURATION=production

clientBuildFile=$ROOT_DIR/dist/client-app.zip

#if [ ! $(test -f $ROOT_DIR/.env) ]; then
#  echo "Please configure the environment variables."
#  exit 0;
#fi

if [ -e "$clientBuildFile" ]; then
  rm "$clientBuildFile"
  echo "$clientBuildFile was removed."
fi

#export $(grep -v '^#' $ROOT_DIR/.env | xargs -d '\n')

cd $ROOT_DIR

echo "Installing npm packages..."
npm ci
echo "✅ npm packages installed"

echo "Building for $ENV_CONFIGURATION..."
npm run build -- --configuration=$ENV_CONFIGURATION --output-path=$CLIENT_BUILD_DIR
echo "✅ Build complete in $CLIENT_BUILD_DIR"

echo "Creating build file..."
zip -r $clientBuildFile $CLIENT_BUILD_DIR/*
echo "✅ Build file created at $clientBuildFile"
