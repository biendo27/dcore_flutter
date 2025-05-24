@echo off
setlocal

:: Define the root directory relative to the current script location
set ROOT_DIR=%~dp0..\..\..

:: Define the flutter_launcher_icons command
set FLUTTER_LAUNCHER_ICON_CMD=dart run flutter_launcher_icons

:: Navigate to the root directory
cd %ROOT_DIR%
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to navigate to the project root directory.
    goto :end
)

:: Run the flutter_launcher_icons command
echo Running flutter_launcher_icons...
call %FLUTTER_LAUNCHER_ICON_CMD%
IF %ERRORLEVEL% NEQ 0 (
    echo flutter_launcher_icons command failed.
    goto :end
)

:: Success message
echo All platform icon generation complete.

:end
:: End the local environment changes
endlocal

:: Wait for a key press before closing
echo.
echo Press any key to close this window...
pause >nul

:: Close the terminal window
exit
