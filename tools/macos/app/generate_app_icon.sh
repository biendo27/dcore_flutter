#!/bin/bash

# Define the root directory relative to the current script location
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

# Define the flutter_launcher_icons command
FLUTTER_LAUNCHER_ICON_CMD="dart run flutter_launcher_icons"

# Navigate to the root directory
cd "$ROOT_DIR" || {
    echo "Failed to navigate to the project root directory."
    exit 1
}

# Run the flutter_launcher_icons command
echo "Running flutter_launcher_icons..."
$FLUTTER_LAUNCHER_ICON_CMD || {
    echo "flutter_launcher_icons command failed."
    exit 1
}

# Success message
echo "All platform icon generation complete."

# Exit the script
exit 0
