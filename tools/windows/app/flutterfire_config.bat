@echo off
setlocal

:: Check for parameters immediately
if "%~1"=="" (
    echo Error: No environment specified.
    echo Usage: %0 [dev^|stg^|prod]
    exit /b 1
)

:: Validate input environment
if not "%1"=="dev" if not "%1"=="stg" if not "%1"=="prod" (
    echo Error: Invalid environment '%1'.
    echo Supported environments: dev, stg, prod
    exit /b 1
)

:: Set environment-specific configurations
if "%1"=="dev" (
    set IOS_BUNDLE_ID=flutter.base.dcore.dev
    set ANDROID_PACKAGE=flutter.base.dcore.dev
    set PROJECT=dcore-dev-78baa
) else if "%1"=="stg" (
    set IOS_BUNDLE_ID=flutter.base.dcore.stg
    set ANDROID_PACKAGE=flutter.base.dcore.stg
    set PROJECT=dcore-stg
) else if "%1"=="prod" (
    set IOS_BUNDLE_ID=flutter.base.dcore
    set ANDROID_PACKAGE=flutter.base.dcore
    set PROJECT=dcore-prod
)

:: Execute FlutterFire configuration
echo Configuring Firebase for %1 environment...

flutterfire config ^
    --overwrite-firebase-options ^
    --project=%PROJECT% ^
    --out=lib/config/services/firebase/firebase_options_%1.dart ^
    --ios-bundle-id=%IOS_BUNDLE_ID% ^
    --ios-out=ios/flavors/%1/GoogleService-Info.plist ^
    --android-package-name=%ANDROID_PACKAGE% ^
    --android-out=android/app/src/%1/google-services.json ^
    --platforms=ios,android

if %errorlevel% neq 0 (
    echo Error: Firebase configuration for %1 failed.
    exit /b 1
)

echo Firebase configuration for %1 completed successfully.
exit /b 0 