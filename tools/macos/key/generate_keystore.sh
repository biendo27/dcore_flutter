#!/bin/bash

# Define the root directory relative to the current script location
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

# Set the path to the key.properties file
PROPERTIES_FILE="$ROOT_DIR/android/key.properties"

# Set the path for the new keystore
KEYSTORE_PATH="$ROOT_DIR/android/app/upload-keystore.jks"

# Read values from key.properties
if [ -f "$PROPERTIES_FILE" ]; then
    source "$PROPERTIES_FILE"
else
    echo "Error: key.properties file not found at $PROPERTIES_FILE"
    exit 1
fi

# Check if keystore already exists
if [ -f "$KEYSTORE_PATH" ]; then
    read -p "Keystore already exists. Do you want to overwrite it? (y/N): " OVERWRITE
    if [[ ! $OVERWRITE =~ ^[Yy]$ ]]; then
        echo "Operation cancelled."
        exit 0
    fi
fi

# Generate the keystore
echo "Generating keystore..."
keytool -genkeypair \
    -keystore "$KEYSTORE_PATH" \
    -alias "$keyAlias" \
    -keyalg RSA \
    -keysize 2048 \
    -validity 10000 \
    -storepass "$storePassword" \
    -keypass "$keyPassword" \
    -dname "CN=Your Name, OU=Your Organizational Unit, O=Your Organization, L=Your City, S=Your State, C=Your Country Code" \
    -noprompt

if [ $? -ne 0 ]; then
    echo "Failed to generate keystore."
    exit 1
fi

echo "Keystore generated successfully at: $KEYSTORE_PATH"
echo
echo "Please update your build.gradle file with the keystore information if not already done."
