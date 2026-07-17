# 🎮 Cam Masters: Private Desires — Save Editor Guide

> Unlock girls, coins, diamonds, Battle Pass and all skins by editing the save file.  
> No mods, no external tools — just PowerShell or any text editor.

---

## 🇷🇺 РУССКИЙ

### 📁 Где находится файл сохранения

```
C:\Users\<ВАШ_ЮЗЕР>\AppData\LocalLow\Butchers Games\Cam Masters_ Private Desires\GameData.json
```

> **Важно:** Закрой игру перед редактированием, иначе она перезапишет файл.

---

### 💰 Выдать монеты, алмазы, звёзды, энергию

Открой `GameData.json` в любом текстовом редакторе (Notepad, VS Code) и найди эти строки:

```json
"Energy":   999,
"Coins":    9999999,
"Diamonds": 99999,
"Stars":    99999,
```

Поставь нужные значения и сохрани файл.

**Или запусти PowerShell от имени администратора и вставь:**

```powershell
$path = "$env:APPDATA\..\LocalLow\Butchers Games\Cam Masters_ Private Desires\GameData.json"
$json = Get-Content $path -Raw | ConvertFrom-Json
$json.Coins    = 9999999
$json.Diamonds = 99999
$json.Stars    = 99999
$json.Energy   = 999
$json.AbilityCount = @(99,99,99,99,99,99)
$json | ConvertTo-Json -Depth 15 | Set-Content $path -Encoding UTF8
Write-Host "Готово!"
```

---

### 👧 Разблокировать всех девушек + все скины

```powershell
$path = "$env:APPDATA\..\LocalLow\Butchers Games\Cam Masters_ Private Desires\GameData.json"
$json = Get-Content $path -Raw | ConvertFrom-Json

foreach ($girl in $json.Girls.PSObject.Properties) {
    $girl.Value.Lvl         = 10
    $girl.Value.LvlScore    = 9999
    $girl.Value.UnlockSkins = @(0,1,2,3,4,5)
    $girl.Value.RewardCount = 99
}

$json | ConvertTo-Json -Depth 15 | Set-Content $path -Encoding UTF8
Write-Host "Все девушки разблокированы!"
```

---

### 📺 Открыть все стримы и приватные чаты

```powershell
$path = "$env:APPDATA\..\LocalLow\Butchers Games\Cam Masters_ Private Desires\GameData.json"
$json = Get-Content $path -Raw | ConvertFrom-Json

foreach ($sg in $json.StreamGirls.PSObject.Properties) {
    $sg.Value.OpenOnStream            = $true
    $sg.Value.CurReadPrivateChatPart  = 99
    $sg.Value.CurReadPrivateChatMessage = 999
    $sg.Value.YourPrivateChatMessages = @(1,1,1,1,1,1,1,1,1,1)
}

$json | ConvertTo-Json -Depth 15 | Set-Content $path -Encoding UTF8
Write-Host "Все стримы открыты!"
```

---

### 🎟️ Battle Pass Premium + уровень 100

```powershell
$path = "$env:APPDATA\..\LocalLow\Butchers Games\Cam Masters_ Private Desires\GameData.json"
$json = Get-Content $path -Raw | ConvertFrom-Json
$json.BattlePassPremium           = $true
$json.CurBattlePassLvl            = 100
$json.CurBattlePassScore          = 9999999
$json.BattlePassNotCollectedRewards        = @()
$json.BattlePassNotCollectedPremiumRewards = @()
$json | ConvertTo-Json -Depth 15 | Set-Content $path -Encoding UTF8
Write-Host "Battle Pass Premium активирован!"
```

---

### 🚀 ВСЁ СРАЗУ — один скрипт

```powershell
$path = "$env:APPDATA\..\LocalLow\Butchers Games\Cam Masters_ Private Desires\GameData.json"
$json = Get-Content $path -Raw | ConvertFrom-Json

# Валюта
$json.Coins    = 9999999
$json.Diamonds = 99999
$json.Stars    = 99999
$json.Energy   = 999
$json.EventCoins = 999999
$json.AbilityCount = @(99,99,99,99,99,99)
$json.InfinityEnergyTime = "2099-12-31T23:59:59"

# Battle Pass
$json.BattlePassPremium  = $true
$json.CurBattlePassLvl   = 100
$json.CurBattlePassScore = 9999999
$json.BattlePassNotCollectedRewards        = @()
$json.BattlePassNotCollectedPremiumRewards = @()

# Девушки
foreach ($girl in $json.Girls.PSObject.Properties) {
    $girl.Value.Lvl         = 10
    $girl.Value.LvlScore    = 9999
    $girl.Value.UnlockSkins = @(0,1,2,3,4,5)
    $girl.Value.RewardCount = 99
}

# Стримы
foreach ($sg in $json.StreamGirls.PSObject.Properties) {
    $sg.Value.OpenOnStream              = $true
    $sg.Value.CurReadPrivateChatPart    = 99
    $sg.Value.CurReadPrivateChatMessage = 999
    $sg.Value.YourPrivateChatMessages   = @(1,1,1,1,1,1,1,1,1,1)
}

# Сохраняем
$json | ConvertTo-Json -Depth 15 | Set-Content $path -Encoding UTF8
Write-Host "=== ВСЁ ВЫДАНО ===" 
Write-Host "Coins: $($json.Coins) | Diamonds: $($json.Diamonds) | BP: $($json.BattlePassPremium)"
```

---

### ⚠️ Частые проблемы

| Проблема | Решение |
|---|---|
| Изменения не применяются | Закрой игру перед редактированием |
| Сейв сбросился | Игра была открыта и перезаписала файл |
| Обучение не пропускается | Поставь `"TutorialCurState": 99` |

---

---

## 🇬🇧 ENGLISH

### 📁 Save File Location

```
C:\Users\<YOUR_USER>\AppData\LocalLow\Butchers Games\Cam Masters_ Private Desires\GameData.json
```

> **Important:** Close the game before editing, otherwise it will overwrite your file.

---

### 💰 Add Coins, Diamonds, Stars, Energy

Open `GameData.json` in any text editor (Notepad, VS Code) and find these lines:

```json
"Energy":   999,
"Coins":    9999999,
"Diamonds": 99999,
"Stars":    99999,
```

Set the values you want and save.

**Or run PowerShell as Administrator and paste:**

```powershell
$path = "$env:APPDATA\..\LocalLow\Butchers Games\Cam Masters_ Private Desires\GameData.json"
$json = Get-Content $path -Raw | ConvertFrom-Json
$json.Coins    = 9999999
$json.Diamonds = 99999
$json.Stars    = 99999
$json.Energy   = 999
$json.AbilityCount = @(99,99,99,99,99,99)
$json | ConvertTo-Json -Depth 15 | Set-Content $path -Encoding UTF8
Write-Host "Done!"
```

---

### 👧 Unlock All Girls + All Skins

```powershell
$path = "$env:APPDATA\..\LocalLow\Butchers Games\Cam Masters_ Private Desires\GameData.json"
$json = Get-Content $path -Raw | ConvertFrom-Json

foreach ($girl in $json.Girls.PSObject.Properties) {
    $girl.Value.Lvl         = 10
    $girl.Value.LvlScore    = 9999
    $girl.Value.UnlockSkins = @(0,1,2,3,4,5)
    $girl.Value.RewardCount = 99
}

$json | ConvertTo-Json -Depth 15 | Set-Content $path -Encoding UTF8
Write-Host "All girls unlocked!"
```

---

### 📺 Unlock All Streams & Private Chats

```powershell
$path = "$env:APPDATA\..\LocalLow\Butchers Games\Cam Masters_ Private Desires\GameData.json"
$json = Get-Content $path -Raw | ConvertFrom-Json

foreach ($sg in $json.StreamGirls.PSObject.Properties) {
    $sg.Value.OpenOnStream              = $true
    $sg.Value.CurReadPrivateChatPart    = 99
    $sg.Value.CurReadPrivateChatMessage = 999
    $sg.Value.YourPrivateChatMessages   = @(1,1,1,1,1,1,1,1,1,1)
}

$json | ConvertTo-Json -Depth 15 | Set-Content $path -Encoding UTF8
Write-Host "All streams unlocked!"
```

---

### 🎟️ Battle Pass Premium + Level 100

```powershell
$path = "$env:APPDATA\..\LocalLow\Butchers Games\Cam Masters_ Private Desires\GameData.json"
$json = Get-Content $path -Raw | ConvertFrom-Json
$json.BattlePassPremium           = $true
$json.CurBattlePassLvl            = 100
$json.CurBattlePassScore          = 9999999
$json.BattlePassNotCollectedRewards        = @()
$json.BattlePassNotCollectedPremiumRewards = @()
$json | ConvertTo-Json -Depth 15 | Set-Content $path -Encoding UTF8
Write-Host "Battle Pass Premium activated!"
```

---

### 🚀 UNLOCK EVERYTHING — One Script

```powershell
$path = "$env:APPDATA\..\LocalLow\Butchers Games\Cam Masters_ Private Desires\GameData.json"
$json = Get-Content $path -Raw | ConvertFrom-Json

# Currency
$json.Coins    = 9999999
$json.Diamonds = 99999
$json.Stars    = 99999
$json.Energy   = 999
$json.EventCoins = 999999
$json.AbilityCount = @(99,99,99,99,99,99)
$json.InfinityEnergyTime = "2099-12-31T23:59:59"

# Battle Pass
$json.BattlePassPremium  = $true
$json.CurBattlePassLvl   = 100
$json.CurBattlePassScore = 9999999
$json.BattlePassNotCollectedRewards        = @()
$json.BattlePassNotCollectedPremiumRewards = @()

# Girls
foreach ($girl in $json.Girls.PSObject.Properties) {
    $girl.Value.Lvl         = 10
    $girl.Value.LvlScore    = 9999
    $girl.Value.UnlockSkins = @(0,1,2,3,4,5)
    $girl.Value.RewardCount = 99
}

# Streams
foreach ($sg in $json.StreamGirls.PSObject.Properties) {
    $sg.Value.OpenOnStream              = $true
    $sg.Value.CurReadPrivateChatPart    = 99
    $sg.Value.CurReadPrivateChatMessage = 999
    $sg.Value.YourPrivateChatMessages   = @(1,1,1,1,1,1,1,1,1,1)
}

$json | ConvertTo-Json -Depth 15 | Set-Content $path -Encoding UTF8
Write-Host "=== ALL UNLOCKED ===" 
Write-Host "Coins: $($json.Coins) | Diamonds: $($json.Diamonds) | BP: $($json.BattlePassPremium)"
```

---

### ⚠️ Common Issues

| Issue | Fix |
|---|---|
| Changes not applied | Close the game before editing |
| Save got reset | Game was open and overwrote the file |
| Tutorial won't skip | Set `"TutorialCurState": 99` in the JSON |

---

### 📋 Key JSON Fields Reference

| Field | What it does |
|---|---|
| `Coins` | Soft currency |
| `Diamonds` | Premium currency |
| `Stars` | Level stars |
| `Energy` | Energy for playing |
| `BattlePassPremium` | `true` = BP Premium unlocked |
| `CurBattlePassLvl` | Current BP level (max 100) |
| `Girls[N].Lvl` | Girl unlock level (`-1` = locked, `1+` = unlocked) |
| `Girls[N].UnlockSkins` | Array of unlocked skin IDs |
| `StreamGirls[N].OpenOnStream` | `true` = stream is visible |
| `TutorialCurState` | Set to `99` to skip tutorial |

---

*Made with ❤️ — works on game version as of July 2026*
