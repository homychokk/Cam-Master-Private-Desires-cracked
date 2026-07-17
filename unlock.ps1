$savePath = "$env:APPDATA\..\LocalLow\Butchers Games\Cam Masters_ Private Desires\GameData.json"

if (-not (Test-Path $savePath)) {
    Clear-Host
    Write-Host "==============================================" -ForegroundColor Yellow
    Write-Host "[WARNING] Save file not found automatically!" -ForegroundColor Yellow
    Write-Host "==============================================" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Please enter the directory containing GameData.json:"
    $inputPath = Read-Host "Path"
    $savePath = Join-Path $inputPath "GameData.json"
    
    if (-not (Test-Path $savePath)) {
        Write-Host "[ERROR] GameData.json not found! Exiting in 3s..." -ForegroundColor Red
        Start-Sleep -Seconds 3
        exit
    }
}

$message = ""
$messageColor = "White"

while ($true) {
    Clear-Host
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host "      Cam Masters: Private Desires - Save Editor  " -ForegroundColor Cyan
    Write-Host "                 github.com/homychokk             " -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "  Save File: " -NoNewline
    Write-Host $savePath -ForegroundColor Cyan
    Write-Host ""
    
    if ($message -ne "") {
        Write-Host "  >>> $message <<<" -ForegroundColor $messageColor
        Write-Host ""
    }
    
    Write-Host "  [1] " -NoNewline; Write-Host "Add Coins + Diamonds + Stars + Energy" -ForegroundColor Green
    Write-Host "  [2] " -NoNewline; Write-Host "Unlock All Girls + Skins" -ForegroundColor Magenta
    Write-Host "  [3] " -NoNewline; Write-Host "Unlock All Streams + Chats" -ForegroundColor Cyan
    Write-Host "  [4] " -NoNewline; Write-Host "Get Battle Pass Premium (Level 100)" -ForegroundColor Yellow
    Write-Host "  [5] " -NoNewline; Write-Host "Get All Abilities (x99)" -ForegroundColor Gray
    Write-Host "  [6] " -NoNewline; Write-Host "UNLOCK EVERYTHING (Recommended)" -ForegroundColor White
    Write-Host "  [7] " -NoNewline; Write-Host "Remove read-only lock (restore saves)" -ForegroundColor DarkGray
    Write-Host "  [0] " -NoNewline; Write-Host "Exit" -ForegroundColor Red
    Write-Host ""
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host "  Select option [0-7]: " -NoNewline
    
    $choice = [Console]::ReadKey($true).KeyChar
    $message = ""
    
    $gameRunning = Get-Process | Where-Object { $_.Name -match "Cam|Master|Desire" }
    if ($gameRunning) {
        $message = "WARNING: Close the game before modifying save!"
        $messageColor = "Red"
        continue
    }
    
    if (Test-Path $savePath) {
        attrib -r $savePath 2>$null
    }
    
    switch ($choice) {
        "0" { 
            Clear-Host
            Write-Host "Goodbye!" -ForegroundColor Yellow
            Start-Sleep -Seconds 1
            exit
        }
        "1" {
            $j = Get-Content $savePath -Raw | ConvertFrom-Json
            $j.Coins = 9999999
            $j.Diamonds = 99999
            $j.Stars = 99999
            $j.Energy = 999
            $j.EventCoins = 999999
            $j | ConvertTo-Json -Depth 15 | Set-Content $savePath -Encoding UTF8
            $message = "Resources added successfully!"
            $messageColor = "Green"
        }
        "2" {
            $j = Get-Content $savePath -Raw | ConvertFrom-Json
            foreach ($g in $j.Girls.PSObject.Properties) {
                $g.Value.Lvl = 100
                $g.Value.LvlScore = 99999
                $g.Value.UnlockSkins = @(0,1,2,3,4,5,6,7,8,9,10)
                $g.Value.RewardCount = 99
            }
            $j | ConvertTo-Json -Depth 15 | Set-Content $savePath -Encoding UTF8
            $message = "All girls and skins unlocked!"
            $messageColor = "Magenta"
        }
        "3" {
            $j = Get-Content $savePath -Raw | ConvertFrom-Json
            foreach ($s in $j.StreamGirls.PSObject.Properties) {
                $s.Value.OpenOnStream = $true
                $s.Value.CurReadPrivateChatPart = 99
                $s.Value.CurReadPrivateChatMessage = 999
                $s.Value.YourPrivateChatMessages = @(1,1,1,1,1,1,1,1,1,1)
            }
            $j | ConvertTo-Json -Depth 15 | Set-Content $savePath -Encoding UTF8
            $message = "All streams and chats opened!"
            $messageColor = "Cyan"
        }
        "4" {
            $j = Get-Content $savePath -Raw | ConvertFrom-Json
            $j.BattlePassCurTheme = 1
            $j.BattlePassPremium = $true
            $j.CurBattlePassLvl = 100
            $j.CurBattlePassScore = 9999999
            $j.IssuedPurchases += @("bundle_battle_pass", "bundle_battle_pass_premium", "battle_pass_premium", "battle_pass", "premium_pass")
            $j | ConvertTo-Json -Depth 15 | Set-Content $savePath -Encoding UTF8
            $message = "Battle Pass Premium Level 100 activated!"
            $messageColor = "Yellow"
        }
        "5" {
            $j = Get-Content $savePath -Raw | ConvertFrom-Json
            $j.AbilityCount = @(999,999,999,999,999,999)
            $j.EventAbilityCount = @(999,999,999,999,999,999)
            $j.InfinityEnergyTime = "2099-12-31T23:59:59"
            $j.InfinityThunderTime = "2099-12-31T23:59:59"
            $j.InfinityAddTimeTime = "2099-12-31T23:59:59"
            $j | ConvertTo-Json -Depth 15 | Set-Content $savePath -Encoding UTF8
            $message = "Abilities and Infinite Energy unlocked!"
            $messageColor = "Gray"
        }
        "6" {
            $j = Get-Content $savePath -Raw | ConvertFrom-Json
            $j.Coins = 9999999
            $j.Diamonds = 99999
            $j.Stars = 99999
            $j.Energy = 999
            $j.EventCoins = 999999
            $j.AbilityCount = @(999,999,999,999,999,999)
            $j.EventAbilityCount = @(999,999,999,999,999,999)
            $j.InfinityEnergyTime = "2099-12-31T23:59:59"
            $j.InfinityThunderTime = "2099-12-31T23:59:59"
            $j.InfinityAddTimeTime = "2099-12-31T23:59:59"
            $j.BattlePassCurTheme = 1
            $j.BattlePassPremium = $true
            $j.CurBattlePassLvl = 100
            $j.CurBattlePassScore = 9999999
            $j.IssuedPurchases += @("bundle_battle_pass", "bundle_battle_pass_premium", "battle_pass_premium", "battle_pass", "premium_pass")
            foreach ($g in $j.Girls.PSObject.Properties) {
                $g.Value.Lvl = 100
                $g.Value.LvlScore = 99999
                $g.Value.UnlockSkins = @(0,1,2,3,4,5,6,7,8,9,10)
                $g.Value.RewardCount = 99
            }
            foreach ($s in $j.StreamGirls.PSObject.Properties) {
                $s.Value.OpenOnStream = $true
                $s.Value.CurReadPrivateChatPart = 99
                $s.Value.CurReadPrivateChatMessage = 999
                $s.Value.YourPrivateChatMessages = @(1,1,1,1,1,1,1,1,1,1)
            }
            $j | ConvertTo-Json -Depth 15 | Set-Content $savePath -Encoding UTF8
            $message = "EVERYTHING UNLOCKED!"
            $messageColor = "White"
        }
        "7" {
            $message = "File read-only restriction removed."
            $messageColor = "Gray"
        }
    }
}
