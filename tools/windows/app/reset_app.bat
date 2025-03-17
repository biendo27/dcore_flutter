@echo off
setlocal

:: Define the root directory
set ROOT_DIR=%~dp0..\..\..

:: Check if Flutter is installed
where flutter >nul 2>nul
if %errorlevel% neq 0 (
    echo Flutter is not installed or not added to PATH.
    echo Please ensure that Flutter is installed and added to your system PATH.
    goto :end
)

:: Navigate to the root directory
cd %ROOT_DIR%
if %errorlevel% neq 0 (
    echo Failed to navigate to the project root directory.
    goto :end
)

:: Clean the Flutter project
echo Cleaning Flutter project...
:: First try to remove build directory manually
rd /s /q "%ROOT_DIR%\build" 2>nul
call flutter clean
if %errorlevel% neq 0 (
    echo Flutter clean failed.
    goto :end
)

:: Get Flutter dependencies (pub get)
echo Fetching Flutter packages...
call flutter pub get
if %errorlevel% neq 0 (
    echo Flutter pub get failed.
    goto :end
)

:: Success message
echo Flutter project reset successfully: cleaned and packages fetched.

:end
endlocal

:: Wait for a key press before closing
echo.
echo Press any key to close this window...
pause >nul
