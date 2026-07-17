@echo off
title Premium Unlock Patcher
echo ==================================================
echo       Cam Masters: Private Desires - Patcher
echo                 github.com/homychokk
echo ==================================================
echo.

set "DLL_PATH="

:: Try checking common paths
FOR /F "tokens=2* skip=2" %%a in ('reg query "HKLM\SOFTWARE\Wow6432Node\Valve\Steam" /v InstallPath 2^>nul') do set "STEAM_DIR=%%b"
if exist "%STEAM_DIR%\steamapps\common\Cam Master Private Desires\Cam Masters Private Desires_Data\Managed\Assembly-CSharp.dll" (
    set "DLL_PATH=%STEAM_DIR%\steamapps\common\Cam Master Private Desires\Cam Masters Private Desires_Data\Managed\Assembly-CSharp.dll"
) else if exist "D:\steam\steamapps\common\Cam Master Private Desires\Cam Masters Private Desires_Data\Managed\Assembly-CSharp.dll" (
    set "DLL_PATH=D:\steam\steamapps\common\Cam Master Private Desires\Cam Masters Private Desires_Data\Managed\Assembly-CSharp.dll"
) else if exist "Cam Masters Private Desires_Data\Managed\Assembly-CSharp.dll" (
    set "DLL_PATH=Cam Masters Private Desires_Data\Managed\Assembly-CSharp.dll"
) else if exist "Assembly-CSharp.dll" (
    set "DLL_PATH=Assembly-CSharp.dll"
)

if "%DLL_PATH%"=="" (
    echo [ERROR] Game files not found!
    echo Please move all files ^(install_patch.bat, GamePatcher.exe, Mono.Cecil.dll^)
    echo inside your game folder and run it again!
    echo.
    pause
    exit /b
)

echo Found game file: %DLL_PATH%
echo.
echo Creating Backup...
if not exist "%DLL_PATH%.bak" (
    copy /Y "%DLL_PATH%" "%DLL_PATH%.bak" >nul
    echo Backup created at: %DLL_PATH%.bak
) else (
    echo Backup already exists.
)

echo.
echo Injecting Premium Unlock code...
GamePatcher.exe "%DLL_PATH%"

echo.
echo ==================================================
echo DONE! You can now close this window and launch the game.
echo The Battle Pass Premium will unlock as soon as you open it.
echo ==================================================
pause
