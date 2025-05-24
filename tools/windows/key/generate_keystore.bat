@echo off
setlocal enabledelayedexpansion

:: Navigate to the root directory relative to the current script location
set ROOT_DIR=%~dp0..\..\..
cd %ROOT_DIR%
if %errorlevel% neq 0 (
    echo Failed to navigate to the project root directory.
    goto :end
)

:: Set the path to the key.properties file
set "PROPERTIES_FILE=android\key.properties"

:: Set the path for the new keystore
set "KEYSTORE_PATH=android\app\upload-keystore.jks"

:: Read values from key.properties
for /f "usebackq tokens=1,* delims==" %%G in ("%PROPERTIES_FILE%") do (
    set "%%G=%%H"
)

:: Check if keystore already exists
if exist "%KEYSTORE_PATH%" (
    echo Keystore already exists at: %KEYSTORE_PATH%
    set /p OVERWRITE="Do you want to overwrite it? (Y/N): "
    if /i "!OVERWRITE!" neq "Y" (
        echo Operation cancelled.
        exit /b 0
    )
)

:: Generate the keystore
echo Generating keystore...
keytool -genkeypair ^
    -keystore "%KEYSTORE_PATH%" ^
    -alias %keyAlias% ^
    -keyalg %keyAlgorithm% ^
    -keysize %keySize% ^
    -validity %validity% ^
    -storepass %storePassword% ^
    -keypass %keyPassword% ^
    -dname "CN=%keyCN%, OU=%keyOU%, O=%keyO%, L=%keyL%, S=%keyS%, C=%keyC%" ^
    -noprompt

if %errorlevel% neq 0 (
    echo Failed to generate keystore.
    exit /b 1
)

echo Keystore generated successfully at: %KEYSTORE_PATH%
echo.
echo Please update your build.gradle file with the keystore information if not already done.
echo.
pause
