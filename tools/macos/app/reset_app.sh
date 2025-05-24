#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

# Define the root directory
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}Flutter is not installed or not added to PATH.${RESET}"
    echo -e "${YELLOW}Please ensure that Flutter is installed and added to your system PATH.${RESET}"
    exit 1
fi

# Navigate to the root directory
cd "$ROOT_DIR" || {
    echo -e "${RED}Failed to navigate to the project root directory.${RESET}"
    exit 1
}

# Clean the Flutter project
echo -e "${BLUE}Cleaning Flutter project...${RESET}"
flutter clean || {
    echo -e "${RED}Flutter clean failed.${RESET}"
    exit 1
}

# Get Flutter dependencies (pub get)
echo -e "${BLUE}Fetching Flutter packages...${RESET}"
flutter pub get || {
    echo -e "${RED}Flutter pub get failed.${RESET}"
    exit 1
}

# Success message
echo -e "${GREEN}Flutter project cleaned and packages fetched successfully.${RESET}"

# Exit the script
exit 0
