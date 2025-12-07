@echo off
REM This script publishes the documentation to the homelab server
REM Ensure the rclone configuration is set up correctly before running this script
hugo --minify --destination public
rclone copy public\ homelab:/opt/docs/web/
if %ERRORLEVEL% neq 0 (
    echo Failed to publish documentation. Please check your rclone configuration and try again.
    exit /b %ERRORLEVEL%
)
echo Documentation published successfully to homelab server.
