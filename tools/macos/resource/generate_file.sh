#!/bin/bash

# Define the root directory
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

# Define the build_runner command
BUILD_RUNNER_CMD="dart run build_runner build --delete-conflicting-outputs"

# Navigate to the root directory
cd "$ROOT_DIR" || {
    echo "Failed to navigate to the root directory."
    exit 1
}

# Run the build_runner command
echo "Running build_runner to generate api files..."
echo "Running build_runner to generate models files..."
echo "Running build_runner to generate resources files..."
$BUILD_RUNNER_CMD || {
    echo "build_runner command failed."
    exit 1
}

echo "Build_runner generation complete."

# Exit the script
exit 0
