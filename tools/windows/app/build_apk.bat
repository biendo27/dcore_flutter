@echo off
setlocal enabledelayedexpansion

:: Navigate to the root directory relative to the current script location
set ROOT_DIR=%~dp0..\..\..
cd %ROOT_DIR%
if %errorlevel% neq 0 (
    echo Failed to navigate to the project root directory.
    goto :end
)

:: Define the APK output path and debug info output path
set APK_OUTPUT_PATH=build\app\outputs\flutter-apk
set DEBUG_INFO_OUTPUT_PATH=.obfuscation

:: Check if flavor is provided
if "%1"=="" (
    echo Usage: build_apk.bat [dev^|stg^|prod]
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
if not exist "%APK_OUTPUT_PATH%" mkdir "%APK_OUTPUT_PATH%"

:: Display the contents of the environment file
echo Building APK for %1 flavor...
echo Using environment variables from file: %ENV_FILE%
echo Contents of %ENV_FILE%:
type "%ENV_FILE%"
echo.

:: Build APK for specified flavor with environment variables from file
call flutter build apk ^
    --release ^
    --no-tree-shake-icons ^
    --obfuscate ^
    --split-debug-info=%DEBUG_INFO_OUTPUT_PATH% ^
    --flavor %1 ^
    --dart-define-from-file=%ENV_FILE% ^
    -t lib/main_%1.dart 

if %errorlevel% neq 0 (
    echo APK build failed for %1 flavor.
    goto :end
)

:: Success message
echo APK built successfully for %1 flavor.
echo You can find the APK in %APK_OUTPUT_PATH%

:: Open the folder in Explorer
echo Opening the APK folder...
start explorer "%APK_OUTPUT_PATH%"

:end
endlocal

:: Wait for a key press before closing
echo.
echo Press any key to close this window...
pause >nul
