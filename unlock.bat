@echo off
title Cam Masters Save Editor
cd /d "%~dp0"
if not exist "unlock.ps1" (
    echo [ERROR] unlock.ps1 not found! Make sure both files are in the same folder.
    pause
    exit /b
)
powershell -NoProfile -ExecutionPolicy Bypass -File "unlock.ps1"
