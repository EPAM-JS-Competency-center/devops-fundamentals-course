#!/bin/bash

REPOSITORY="https://github.com/EPAM-JS-Competency-center/shop-angular-cloudfront.git"
COMPRESSED_APP="dist/client-app.zip"

# Assign value to ENV_CONFIGURATION based on user input or leave empty for development
read -p "Enter configuration (production or leave empty for development): " ENV_CONFIGURATION

git clone "$REPOSITORY"

cd shop-angular-cloudfront || exit

npm install
npm run build --configuration="$ENV_CONFIGURATION"

cd dist || exit

if [ -f "$COMPRESSED_APP" ]; then
  echo "We've already have compressed file"
  rm -i "$COMPRESSED_APP"
  echo "Compressed client app was deleted"
fi

zip -r client-app.zip *

echo "Client app was built with $ENV_CONFIGURATION configuration."