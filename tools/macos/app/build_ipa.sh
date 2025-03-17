#!/bin/bash

# Enable strict error handling
set -e

# Define the root directory relative to the current script location
ROOT_DIR=$(dirname $(realpath $0))/../../..
IPA_OUTPUT_PATH="$ROOT_DIR/build/ios/outputs/ipa"

# Define environment-specific configurations
DEV_API_BASE_URL="https://dev.venusshop.top/api/v1"
STG_API_BASE_URL="https://staging.venusshop.top/api/v1"
PROD_API_BASE_URL="https://venusshop.top/api/v1"

# Check if flavor is provided
if [ -z "$1" ]; then
  echo "Usage: build_ipa.sh [dev|stg|prod]"
  exit 1
fi

# Validate flavor and set environment variables
VALID_FLAVOR=0
if [ "$1" == "dev" ]; then
  VALID_FLAVOR=1
  API_BASE_URL=$DEV_API_BASE_URL
  APP_ENVIRONMENT="dev"
elif [ "$1" == "stg" ]; then
  VALID_FLAVOR=1
  API_BASE_URL=$STG_API_BASE_URL
  APP_ENVIRONMENT="stg"
elif [ "$1" == "prod" ]; then
  VALID_FLAVOR=1
  API_BASE_URL=$PROD_API_BASE_URL
  APP_ENVIRONMENT="prod"
fi

if [ $VALID_FLAVOR -eq 0 ]; then
  echo "Invalid flavor. Use dev, stg, or prod."
  exit 1
fi

# Navigate to the root directory
cd "$ROOT_DIR" || {
  echo "Failed to navigate to the project root directory."
  exit 1
}

# Create output directory if it doesn't exist
mkdir -p "$IPA_OUTPUT_PATH"

# Build IPA for specified flavor with environment variables
echo "Building IPA for $1 flavor..."
echo "API Base URL: $API_BASE_URL"
echo "App Environment: $APP_ENVIRONMENT"

flutter build ipa --release --no-tree-shake-icons --flavor "$1" \
  --dart-define API_BASE_URL="$API_BASE_URL" \
  --dart-define APP_ENVIRONMENT="$APP_ENVIRONMENT" \
  --dart-define CONNECT_TIMEOUT=30000 \
  --dart-define RECEIVE_TIMEOUT=30000

if [ $? -ne 0 ]; then
  echo "IPA build failed for $1 flavor."
  exit 1
fi

# Success message
echo "IPA built successfully for $1 flavor."
echo "You can find the IPA in $IPA_OUTPUT_PATH"

# Open the folder in file explorer (specific to Linux distros with xdg-open)
echo "Opening the IPA folder..."
xdg-open "$IPA_OUTPUT_PATH" || echo "Could not open file explorer. Navigate to $IPA_OUTPUT_PATH manually."

exit 0

# DEV Command
# flutter build ipa --release --no-tree-shake-icons --flavor dev --dart-define API_BASE_URL=https://dev.venusshop.top/api/v1 --dart-define APP_ENVIRONMENT=dev --dart-define CONNECT_TIMEOUT=30000 --dart-define RECEIVE_TIMEOUT=30000

# STAG Command
# flutter build ipa --release --no-tree-shake-icons --flavor stg --dart-define API_BASE_URL=https://staging.venusshop.top/api/v1 --dart-define APP_ENVIRONMENT=stg --dart-define CONNECT_TIMEOUT=30000 --dart-define RECEIVE_TIMEOUT=30000

# PROD Command
# flutter build ipa --release --no-tree-shake-icons --flavor prod --dart-define API_BASE_URL=https://venusshop.top/api/v1 --dart-define APP_ENVIRONMENT=prod --dart-define CONNECT_TIMEOUT=30000 --dart-define RECEIVE_TIMEOUT=30000