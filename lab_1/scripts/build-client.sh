#!/bin/bash

PROJECT="shop-angular-cloudfront"
ENV_CONFIGURATION="production"
ZIP_FILE="client-app.zip"
DIST_FOLDER="dist"

if [ -d "$PROJECT" ]; then
    echo "Navigating to existing directory: $PROJECT"
    cd "$PROJECT" || exit

    echo "Update the existing repository"
    git pull origin

    if [ -f "$DIST_FOLDER/$ZIP_FILE" ]; then
        echo "Removing existing $ZIP_FILE in $DIST_FOLDER"
        rm "$DIST_FOLDER/$ZIP_FILE"
    fi
else
    echo "Clone the GitHub repository"
    git clone "https://github.com/EPAM-JS-Competency-center/$PROJECT.git"

    echo "Navigating to directory $PROJECT"
    cd "$PROJECT" || exit
fi

echo "Install npm dependencies"
# npm ci

echo "Invoke the client app's build command with the $ENV_CONFIGURATION configuration."
# ng build --configuration="$ENV_CONFIGURATION"

if [ -d "$DIST_FOLDER" ]; then
    echo "Creating $ZIP_FILE in $DIST_FOLDER"
    zip -r "$DIST_FOLDER/$ZIP_FILE" "$DIST_FOLDER"
    echo "The file $ZIP_FILE was compressed"
else
    echo "Error: The $DIST_FOLDER directory does not exist."
fi
