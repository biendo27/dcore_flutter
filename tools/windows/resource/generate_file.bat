@echo off
setlocal

:: Define the root directory
set ROOT_DIR=%~dp0..\..\..

:: Define the build_runner command
set BUILD_RUNNER_CMD=dart run build_runner build --delete-conflicting-outputs

:: Define the clean command
set CLEAN_CMD="%~dp0clean.exe"

:: Navigate to the root directory
cd %ROOT_DIR%
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to navigate to the root directory.
    goto :end
)

:: Run the build_runner command
echo Running build_runner to generate api files...
echo Running build_runner to generate models files...
echo Running build_runner to generate resources files...
call %BUILD_RUNNER_CMD%
IF %ERRORLEVEL% NEQ 0 (
    echo build_runner command failed.
    goto :end
)

:: Run clean.exe in the same directory as the batch script
echo Running clean.exe...
call %CLEAN_CMD%
IF %ERRORLEVEL% NEQ 0 (
    echo clean.exe execution failed.
    goto :end
)

echo Build_runner generation and clean complete.

:end
endlocal

:: Wait for a key press before closing
echo.
echo Press any key to close this window...
pause >nul

:: Close the terminal window
exit
