@echo off
setlocal enabledelayedexpansion

:: Define the root directory relative to the current script location
set ROOT_DIR=%~dp0..\..\..
cd %ROOT_DIR%
if %errorlevel% neq 0 (
    echo Failed to navigate to the project root directory.
    goto :end
)

:: Define the APK output path
set APK_OUTPUT_PATH=build\app\outputs\flutter-apk

:: Check if flavor is provided
if "%1"=="" (
    echo Usage: install_app.bat [dev^|stg^|prod]
    goto :end
)

:: Validate flavor
set "VALID_FLAVOR=0"
if "%1"=="dev" set "VALID_FLAVOR=1"
if "%1"=="stg" set "VALID_FLAVOR=1"
if "%1"=="prod" set "VALID_FLAVOR=1"

if "%VALID_FLAVOR%"=="0" (
    echo Invalid flavor. Use dev, stg, or prod.
    goto :end
)

:: Find the APK file
set "APK_FILE=%APK_OUTPUT_PATH%\app-%1-release.apk"

:: Install the APK using adb
echo Installing APK: %APK_FILE%
flutter install --flavor %1
if %errorlevel% neq 0 (
    echo Failed to install APK.
    goto :end
)
echo APK installed successfully.

:end
endlocal
