@echo off
chcp 65001 >nul
title Cam Masters: Private Desires — Save Editor
color 0A

:MENU
cls
echo.
echo  ╔══════════════════════════════════════════════════════════╗
echo  ║      Cam Masters: Private Desires — Save Editor         ║
echo  ║                  github.com/homychokk                   ║
echo  ╚══════════════════════════════════════════════════════════╝
echo.
echo  Найден сейв по стандартному пути?
echo  Проверяю...

set "SAVEPATH=%APPDATA%\..\LocalLow\Butchers Games\Cam Masters_ Private Desires\GameData.json"

if exist "%SAVEPATH%" (
    echo.
    echo  [✓] Сейв найден автоматически:
    echo      %SAVEPATH%
    echo.
    goto CHOOSE_ACTION
) else (
    echo.
    echo  [!] Сейв не найден автоматически.
    echo.
    echo  Введите полный путь к папке с сохранением
    echo  Пример: C:\Users\ВАШ_НИК\AppData\LocalLow\Butchers Games\Cam Masters_ Private Desires
    echo.
    set /p "SAVEDIR=  Путь: "
    set "SAVEPATH=%SAVEDIR%\GameData.json"
    if exist "%SAVEPATH%" (
        echo.
        echo  [✓] Файл найден: %SAVEPATH%
        echo.
        goto CHOOSE_ACTION
    ) else (
        echo.
        echo  [✗] Файл GameData.json не найден по указанному пути!
        echo  Убедитесь что игра хоть раз запускалась.
        echo.
        pause
        goto MENU
    )
)

:CHOOSE_ACTION
echo  ╔══════════════════════════════════════════════════════════╗
echo  ║                    ЧТО ВЫДАТЬ?                          ║
echo  ╠══════════════════════════════════════════════════════════╣
echo  ║  [1]  💰  Монеты + Алмазы + Звёзды + Энергия           ║
echo  ║  [2]  👧  Разблокировать всех девушек + скины           ║
echo  ║  [3]  📺  Открыть все стримы и приватные чаты           ║
echo  ║  [4]  🎟️  Battle Pass Premium (уровень 100)             ║
echo  ║  [5]  ⚡  Все способности (99 штук каждая)              ║
echo  ║  [6]  🚀  ВСЁ СРАЗУ (рекомендуется)                    ║
echo  ║  [7]  🔓  Только снять блокировку файла (read-only)     ║
echo  ║  [0]  ❌  Выход                                         ║
echo  ╚══════════════════════════════════════════════════════════╝
echo.
set /p "CHOICE=  Выберите пункт (0-7): "

if "%CHOICE%"=="1" goto DO_COINS
if "%CHOICE%"=="2" goto DO_GIRLS
if "%CHOICE%"=="3" goto DO_STREAMS
if "%CHOICE%"=="4" goto DO_BP
if "%CHOICE%"=="5" goto DO_ABILITIES
if "%CHOICE%"=="6" goto DO_ALL
if "%CHOICE%"=="7" goto DO_UNLOCK
if "%CHOICE%"=="0" goto EXIT
goto CHOOSE_ACTION

:CHECK_GAME
tasklist /FI "IMAGENAME eq Cam Masters Private Desires.exe" 2>nul | find /I "Cam Masters" >nul
if not errorlevel 1 (
    echo.
    echo  ╔══════════════════════════════════════════════════════════╗
    echo  ║  ⚠️  ИГРА ЗАПУЩЕНА! Закройте игру перед редактированием  ║
    echo  ║     Иначе изменения будут перезаписаны!                  ║
    echo  ╚══════════════════════════════════════════════════════════╝
    echo.
    set /p "CONT=  Продолжить всё равно? (д/н): "
    if /i "%CONT%"=="н" goto CHOOSE_ACTION
    if /i "%CONT%"=="n" goto CHOOSE_ACTION
)
goto :EOF

:DO_COINS
call :CHECK_GAME
echo.
echo  Выдаю монеты, алмазы, звёзды, энергию...
powershell -ExecutionPolicy Bypass -Command ^
    "$p='%SAVEPATH%';" ^
    "attrib -r $p 2>$null;" ^
    "$j=Get-Content $p -Raw|ConvertFrom-Json;" ^
    "$j.Coins=9999999;" ^
    "$j.Diamonds=99999;" ^
    "$j.Stars=99999;" ^
    "$j.Energy=999;" ^
    "$j.EventCoins=999999;" ^
    "$j|ConvertTo-Json -Depth 15|Set-Content $p -Encoding UTF8;" ^
    "Write-Host '[OK] Coins=9999999  Diamonds=99999  Stars=99999  Energy=999'"
goto DONE

:DO_GIRLS
call :CHECK_GAME
echo.
echo  Разблокирую всех девушек и скины...
powershell -ExecutionPolicy Bypass -Command ^
    "$p='%SAVEPATH%';" ^
    "attrib -r $p 2>$null;" ^
    "$j=Get-Content $p -Raw|ConvertFrom-Json;" ^
    "foreach($g in $j.Girls.PSObject.Properties){" ^
    "  $g.Value.Lvl=10;" ^
    "  $g.Value.LvlScore=9999;" ^
    "  $g.Value.UnlockSkins=@(0,1,2,3,4,5);" ^
    "  $g.Value.RewardCount=99" ^
    "};" ^
    "$j|ConvertTo-Json -Depth 15|Set-Content $p -Encoding UTF8;" ^
    "Write-Host '[OK] Все девушки разблокированы! Скины 0-5 выданы.'"
goto DONE

:DO_STREAMS
call :CHECK_GAME
echo.
echo  Открываю все стримы и приватные чаты...
powershell -ExecutionPolicy Bypass -Command ^
    "$p='%SAVEPATH%';" ^
    "attrib -r $p 2>$null;" ^
    "$j=Get-Content $p -Raw|ConvertFrom-Json;" ^
    "foreach($s in $j.StreamGirls.PSObject.Properties){" ^
    "  $s.Value.OpenOnStream=$true;" ^
    "  $s.Value.CurReadPrivateChatPart=99;" ^
    "  $s.Value.CurReadPrivateChatMessage=999;" ^
    "  $s.Value.YourPrivateChatMessages=@(1,1,1,1,1,1,1,1,1,1)" ^
    "};" ^
    "$j|ConvertTo-Json -Depth 15|Set-Content $p -Encoding UTF8;" ^
    "Write-Host '[OK] Все стримы и чаты открыты!'"
goto DONE

:DO_BP
call :CHECK_GAME
echo.
echo  Активирую Battle Pass Premium...
powershell -ExecutionPolicy Bypass -Command ^
    "$p='%SAVEPATH%';" ^
    "attrib -r $p 2>$null;" ^
    "$j=Get-Content $p -Raw|ConvertFrom-Json;" ^
    "$j.BattlePassPremium=$true;" ^
    "$j.CurBattlePassLvl=100;" ^
    "$j.CurBattlePassScore=9999999;" ^
    "$j.CurCollectedBattlePassScore=9999999;" ^
    "$j.BattlePassNotCollectedRewards=@();" ^
    "$j.BattlePassNotCollectedPremiumRewards=@();" ^
    "$j|ConvertTo-Json -Depth 15|Set-Content $p -Encoding UTF8;" ^
    "Write-Host '[OK] Battle Pass Premium! Level 100!'"
goto DONE

:DO_ABILITIES
call :CHECK_GAME
echo.
echo  Выдаю все способности...
powershell -ExecutionPolicy Bypass -Command ^
    "$p='%SAVEPATH%';" ^
    "attrib -r $p 2>$null;" ^
    "$j=Get-Content $p -Raw|ConvertFrom-Json;" ^
    "$j.AbilityCount=@(99,99,99,99,99,99);" ^
    "$j.EventAbilityCount=@(99,99,99,99,99,99);" ^
    "$j.InfinityEnergyTime='2099-12-31T23:59:59';" ^
    "$j.InfinityThunderTime='2099-12-31T23:59:59';" ^
    "$j.InfinityAddTimeTime='2099-12-31T23:59:59';" ^
    "$j|ConvertTo-Json -Depth 15|Set-Content $p -Encoding UTF8;" ^
    "Write-Host '[OK] Все способности x99 + бесконечная энергия до 2099!'"
goto DONE

:DO_ALL
call :CHECK_GAME
echo.
echo  Выдаю всё сразу, подождите...
powershell -ExecutionPolicy Bypass -Command ^
    "$p='%SAVEPATH%';" ^
    "attrib -r $p 2>$null;" ^
    "$j=Get-Content $p -Raw|ConvertFrom-Json;" ^
    "$j.Coins=9999999;" ^
    "$j.Diamonds=99999;" ^
    "$j.Stars=99999;" ^
    "$j.Energy=999;" ^
    "$j.EventCoins=999999;" ^
    "$j.AbilityCount=@(99,99,99,99,99,99);" ^
    "$j.EventAbilityCount=@(99,99,99,99,99,99);" ^
    "$j.InfinityEnergyTime='2099-12-31T23:59:59';" ^
    "$j.InfinityThunderTime='2099-12-31T23:59:59';" ^
    "$j.InfinityAddTimeTime='2099-12-31T23:59:59';" ^
    "$j.BattlePassPremium=$true;" ^
    "$j.CurBattlePassLvl=100;" ^
    "$j.CurBattlePassScore=9999999;" ^
    "$j.CurCollectedBattlePassScore=9999999;" ^
    "$j.BattlePassNotCollectedRewards=@();" ^
    "$j.BattlePassNotCollectedPremiumRewards=@();" ^
    "foreach($g in $j.Girls.PSObject.Properties){" ^
    "  $g.Value.Lvl=10;" ^
    "  $g.Value.LvlScore=9999;" ^
    "  $g.Value.UnlockSkins=@(0,1,2,3,4,5);" ^
    "  $g.Value.RewardCount=99" ^
    "};" ^
    "foreach($s in $j.StreamGirls.PSObject.Properties){" ^
    "  $s.Value.OpenOnStream=$true;" ^
    "  $s.Value.CurReadPrivateChatPart=99;" ^
    "  $s.Value.CurReadPrivateChatMessage=999;" ^
    "  $s.Value.YourPrivateChatMessages=@(1,1,1,1,1,1,1,1,1,1)" ^
    "};" ^
    "$j|ConvertTo-Json -Depth 15|Set-Content $p -Encoding UTF8;" ^
    "Write-Host '============================================';" ^
    "Write-Host '[OK] Монеты:     9999999';" ^
    "Write-Host '[OK] Алмазы:     99999';" ^
    "Write-Host '[OK] Звёзды:     99999';" ^
    "Write-Host '[OK] Энергия:    999 + бесконечная';" ^
    "Write-Host '[OK] Способности: 99 каждой';" ^
    "Write-Host '[OK] Battle Pass Premium: Level 100';" ^
    "Write-Host '[OK] Все девушки (28шт) разблокированы';" ^
    "Write-Host '[OK] Все скины (0-5) выданы';" ^
    "Write-Host '[OK] Все стримы и чаты открыты';" ^
    "Write-Host '============================================'"
goto DONE

:DO_UNLOCK
echo.
powershell -ExecutionPolicy Bypass -Command ^
    "attrib -r '%SAVEPATH%' 2>$null;" ^
    "Write-Host '[OK] Блокировка снята. Игра может сохранять прогресс.'"
goto DONE

:DONE
echo.
echo  ╔══════════════════════════════════════════════════════════╗
echo  ║          ✅  Готово! Запускайте игру.                    ║
echo  ╚══════════════════════════════════════════════════════════╝
echo.
set /p "BACK=  Вернуться в меню? (д/н): "
if /i "%BACK%"=="д" goto CHOOSE_ACTION
if /i "%BACK%"=="y" goto CHOOSE_ACTION
if /i "%BACK%"=="д" goto CHOOSE_ACTION
goto CHOOSE_ACTION

:EXIT
cls
echo.
echo  Удачной игры! github.com/homychokk/Cam-Master-Private-Desires-cracked
echo.
timeout /t 2 >nul
exit
