@echo off
REM This script publishes the documentation to the cloudia server
REM Ensure the rclone configuration is set up correctly before running this script
hugo --minify --destination public
rclone copy public\ cloudia:/opt/docs/
if %ERRORLEVEL% neq 0 (
    echo Failed to publish documentation. Please check your rclone configuration and try again.
    exit /b %ERRORLEVEL%
)
echo Documentation published successfully to cloudia server.
