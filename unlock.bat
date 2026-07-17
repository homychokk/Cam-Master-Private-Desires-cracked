@echo off
title Cam Masters: Private Desires - Save Editor
color 0A

:MENU
cls
echo ==================================================
echo      Cam Masters: Private Desires - Save Editor
echo                 github.com/homychokk
echo ==================================================
echo.
echo Searching for save file...

set "SAVEPATH=%APPDATA%\..\LocalLow\Butchers Games\Cam Masters_ Private Desires\GameData.json"

if exist "%SAVEPATH%" (
    echo [FOUND] Save file located automatically at:
    echo %SAVEPATH%
    echo.
    goto CHOOSE_ACTION
) else (
    echo [WARNING] Save file not found automatically.
    echo.
    echo Please enter the directory path where your save file is located.
    echo Example: C:\Users\YourName\AppData\LocalLow\Butchers Games\Cam Masters_ Private Desires
    echo.
    set /p "SAVEDIR=Path: "
    set "SAVEPATH=%SAVEDIR%\GameData.json"
    if exist "%SAVEPATH%" (
        echo.
        echo [FOUND] Save file located at: %SAVEPATH%
        echo.
        goto CHOOSE_ACTION
    ) else (
        echo.
        echo [ERROR] GameData.json not found in that directory!
        echo Make sure the game has been run at least once.
        echo.
        pause
        goto MENU
    )
)

:CHOOSE_ACTION
echo ==================================================
echo                  CHOOSE ACTION
echo ==================================================
echo   [1] Add Coins + Diamonds + Stars + Energy
echo   [2] Unlock All Girls + Skins
echo   [3] Unlock All Streams + Chats
echo   [4] Get Battle Pass Premium (Level 100)
echo   [5] Get All Abilities (x99)
echo   [6] UNLOCK EVERYTHING (Recommended)
echo   [7] Remove file read-only lock
echo   [0] Exit
echo ==================================================
echo.
set /p "CHOICE=Select option (0-7): "

if "%CHOICE%"=="1" goto DO_COINS
if "%CHOICE%"=="2" goto DO_GIRLS
if "%CHOICE%"=="3" goto DO_STREAMS
if "%CHOICE%"=="4" goto DO_BP
if "%CHOICE%"=="5" goto DO_ABILITIES
if "%CHOICE%"=="6" goto DO_ALL
if "%CHOICE%"=="7" goto DO_UNLOCK
if "%CHOICE%"=="0" goto EXIT
goto CHOOSE_ACTION

:DO_COINS
echo.
echo Modifying save...
powershell -ExecutionPolicy Bypass -Command "$p='%SAVEPATH%'; attrib -r $p 2>$null; $j=Get-Content $p -Raw|ConvertFrom-Json; $j.Coins=9999999; $j.Diamonds=99999; $j.Stars=99999; $j.Energy=999; $j.EventCoins=999999; $j|ConvertTo-Json -Depth 15|Set-Content $p -Encoding UTF8; Write-Host '[OK] Resources updated!'"
goto DONE

:DO_GIRLS
echo.
echo Modifying save...
powershell -ExecutionPolicy Bypass -Command "$p='%SAVEPATH%'; attrib -r $p 2>$null; $j=Get-Content $p -Raw|ConvertFrom-Json; foreach($g in $j.Girls.PSObject.Properties){ $g.Value.Lvl=10; $g.Value.LvlScore=9999; $g.Value.UnlockSkins=@(0,1,2,3,4,5); $g.Value.RewardCount=99 }; $j|ConvertTo-Json -Depth 15|Set-Content $p -Encoding UTF8; Write-Host '[OK] Girls and skins unlocked!'"
goto DONE

:DO_STREAMS
echo.
echo Modifying save...
powershell -ExecutionPolicy Bypass -Command "$p='%SAVEPATH%'; attrib -r $p 2>$null; $j=Get-Content $p -Raw|ConvertFrom-Json; foreach($s in $j.StreamGirls.PSObject.Properties){ $s.Value.OpenOnStream=$true; $s.Value.CurReadPrivateChatPart=99; $s.Value.CurReadPrivateChatMessage=999; $s.Value.YourPrivateChatMessages=@(1,1,1,1,1,1,1,1,1,1) }; $j|ConvertTo-Json -Depth 15|Set-Content $p -Encoding UTF8; Write-Host '[OK] Streams and chats unlocked!'"
goto DONE

:DO_BP
echo.
echo Modifying save...
powershell -ExecutionPolicy Bypass -Command "$p='%SAVEPATH%'; attrib -r $p 2>$null; $j=Get-Content $p -Raw|ConvertFrom-Json; $j.BattlePassPremium=$true; $j.CurBattlePassLvl=100; $j.CurBattlePassScore=9999999; $j.CurCollectedBattlePassScore=9999999; $j.BattlePassNotCollectedRewards=@(); $j.BattlePassNotCollectedPremiumRewards=@(); $j|ConvertTo-Json -Depth 15|Set-Content $p -Encoding UTF8; Write-Host '[OK] Battle Pass Premium Level 100 unlocked!'"
goto DONE

:DO_ABILITIES
echo.
echo Modifying save...
powershell -ExecutionPolicy Bypass -Command "$p='%SAVEPATH%'; attrib -r $p 2>$null; $j=Get-Content $p -Raw|ConvertFrom-Json; $j.AbilityCount=@(99,99,99,99,99,99); $j.EventAbilityCount=@(99,99,99,99,99,99); $j.InfinityEnergyTime='2099-12-31T23:59:59'; $j.InfinityThunderTime='2099-12-31T23:59:59'; $j.InfinityAddTimeTime='2099-12-31T23:59:59'; $j|ConvertTo-Json -Depth 15|Set-Content $p -Encoding UTF8; Write-Host '[OK] Abilities and infinite energy unlocked!'"
goto DONE

:DO_ALL
echo.
echo Modifying save...
powershell -ExecutionPolicy Bypass -Command "$p='%SAVEPATH%'; attrib -r $p 2>$null; $j=Get-Content $p -Raw|ConvertFrom-Json; $j.Coins=9999999; $j.Diamonds=99999; $j.Stars=99999; $j.Energy=999; $j.EventCoins=999999; $j.AbilityCount=@(99,99,99,99,99,99); $j.EventAbilityCount=@(99,99,99,99,99,99); $j.InfinityEnergyTime='2099-12-31T23:59:59'; $j.InfinityThunderTime='2099-12-31T23:59:59'; $j.InfinityAddTimeTime='2099-12-31T23:59:59'; $j.BattlePassPremium=$true; $j.CurBattlePassLvl=100; $j.CurBattlePassScore=9999999; $j.CurCollectedBattlePassScore=9999999; $j.BattlePassNotCollectedRewards=@(); $j.BattlePassNotCollectedPremiumRewards=@(); foreach($g in $j.Girls.PSObject.Properties){ $g.Value.Lvl=10; $g.Value.LvlScore=9999; $g.Value.UnlockSkins=@(0,1,2,3,4,5); $g.Value.RewardCount=99 }; foreach($s in $j.StreamGirls.PSObject.Properties){ $s.Value.OpenOnStream=$true; $s.Value.CurReadPrivateChatPart=99; $s.Value.CurReadPrivateChatMessage=999; $s.Value.YourPrivateChatMessages=@(1,1,1,1,1,1,1,1,1,1) }; $j|ConvertTo-Json -Depth 15|Set-Content $p -Encoding UTF8; Write-Host '[OK] EVERYTHING HAS BEEN UNLOCKED!'"
goto DONE

:DO_UNLOCK
echo.
powershell -ExecutionPolicy Bypass -Command "attrib -r '%SAVEPATH%' 2>$null; Write-Host '[OK] Read-only restriction removed.'"
goto DONE

:DONE
echo.
echo ==================================================
echo              Success! Enjoy the game.
echo ==================================================
echo.
set /p "BACK=Return to menu? (y/n): "
if /i "%BACK%"=="y" goto CHOOSE_ACTION
goto EXIT

:EXIT
cls
echo.
echo Goodbye! github.com/homychokk/Cam-Master-Private-Desires-cracked
echo.
timeout /t 2 >nul
exit
