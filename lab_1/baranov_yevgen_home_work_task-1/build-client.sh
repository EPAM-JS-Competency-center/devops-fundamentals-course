#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

CURRENT_TIME=$(date +"%Y-%m-%d %H:%M:%S")

if ! command -v node &> /dev/null; then
    echo -e "${RED}Error:${NC} Node.js is not installed. Please install Node.js to proceed."
    exit 1
fi

if ! command -v ng &> /dev/null; then
    echo -e "${RED}Error:${NC} Angular CLI is not installed. Please install Angular CLI to proceed."
    exit 1
fi

APP_DIR="."
if [ -n "$1" ]; then
    APP_DIR="$1"
fi

echo -e "${GREEN}Using directory:${NC} $APP_DIR"

if [ -f "$APP_DIR/client-app.zip" ]; then
    echo -e "${YELLOW}Warning:${NC} Removing existing client-app.zip..."
    rm "$APP_DIR/client-app.zip"
fi

echo -e "${GREEN}Cleaning previous build artifacts...${NC}"
ng clean

echo -e "${GREEN}Installing npm dependencies...${NC}"
cd "$APP_DIR" || exit 1
if [ -f "package-lock.json" ]; then
    echo -e "${GREEN}package-lock.json found.${NC} Installing npm dependencies using 'npm ci'..."
    npm ci --quiet
else
    echo -e "${YELLOW}package-lock.json not found.${NC} Installing npm dependencies using 'npm install'..."
    npm install --quiet
fi

echo -e "${GREEN}Dependency installation complete.${NC}"

if [ -z "$ENV_CONFIGURATION" ]; then
    echo -e "${YELLOW}Warning:${NC} ENV_CONFIGURATION is not set. Building the Angular application without a specific configuration flag."
    ng build
    echo -e "${GREEN}Angular build complete without a specific configuration flag.${NC}"
else
    echo -e "${GREEN}Building Angular application with configuration:${NC} $ENV_CONFIGURATION..."
    ng build --configuration="$ENV_CONFIGURATION"
    echo -e "${GREEN}Angular build complete.${NC}"
fi

echo -e "${GREEN}Compressing the build output into client-app.zip...${NC}"
cd "$APP_DIR" || exit 1
if [ -d "dist" ]; then
    cd "dist" || exit 1
    zip -r "../client-app.zip" ./*
    echo -e "${GREEN}Compression complete:${NC} client-app.zip created in the root folder."
else
    echo -e "${RED}Error:${NC} 'dist' directory not found. Couldn't create client-app.zip."
fi

echo -e "${GREEN}Build script executed successfully.${NC}"