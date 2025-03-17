@echo off
setlocal enabledelayedexpansion

:: Set the root directory relative to the current script location
set "ROOT_DIR=%~dp0..\..\.."

:: Navigate to the root directory
pushd "%ROOT_DIR%"
if %errorlevel% neq 0 (
    echo Failed to navigate to the project root directory.
    goto :end
)

:: Define the App Bundle output path and debug info output path
set BUNDLE_OUTPUT_PATH=build\app\outputs\bundle
set DEBUG_INFO_OUTPUT_PATH=.obfuscation


:: Check if flavor is provided
if "%1"=="" (
    echo Usage: build_appbundle.bat [dev^|stg^|prod]
    goto :end
)

:: Validate flavor and set environment file path
set VALID_FLAVOR=0
if "%1"=="dev" (
    set VALID_FLAVOR=1
    set ENV_FILE=".env\.env.dev"
)
if "%1"=="stg" (
    set VALID_FLAVOR=1
    set ENV_FILE=".env\.env.stg"
)
if "%1"=="prod" (
    set VALID_FLAVOR=1
    set ENV_FILE=".env\.env.prod"
)

if "%VALID_FLAVOR%"=="0" (
    echo Invalid flavor. Use dev, stg, or prod.
    goto :end
)

:: Create output directory if it doesn't exist
if not exist "%BUNDLE_OUTPUT_PATH%" mkdir "%BUNDLE_OUTPUT_PATH%"

:: Display the contents of the environment file
echo Building App Bundle for %1 flavor...
echo Using environment variables from file: %ENV_FILE%
echo Contents of %ENV_FILE%:
type "%ENV_FILE%"
echo.

:: Build App Bundle for specified flavor with environment variables from file
call flutter build appbundle ^
    --release ^
    --no-tree-shake-icons ^
    --obfuscate ^
    --split-debug-info=%DEBUG_INFO_OUTPUT_PATH% ^
    --flavor %1 ^
    --dart-define-from-file=%ENV_FILE% ^
    -t lib/main_%1.dart


if %errorlevel% neq 0 (
    echo App Bundle build failed for %1 flavor.
    goto :end
)

:: Success message
echo App Bundle built successfully for %1 flavor.
echo You can find the App Bundle in %BUNDLE_OUTPUT_PATH%

:: Open the folder in Explorer
echo Opening the App Bundle folder...
start explorer "%BUNDLE_OUTPUT_PATH%"

:end
popd
endlocal

:: Wait for a key press before closing
echo.
echo Press any key to close this window...
pause >nul
