@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((Get-Content '%~f0' -Raw) -replace '(?m)^@.*$','')" & exit /b

# Enable ANSI escape codes
[ValType] | Out-Null
$stdHandle = [System.Runtime.InteropServices.Marshal]::GetStdHandle(-11)

# Rainbow Text Generator
function Get-RainbowText ($text, $phase) {
    $colors = @()
    for ($i = 0; $i -lt $text.Length; $i++) {
        $f = 0.25
        $r = [int]([Math]::Sin($f * $i + $phase) * 127 + 128)
        $g = [int]([Math]::Sin($f * $i + $phase + 2.09) * 127 + 128)
        $b = [int]([Math]::Sin($f * $i + $phase + 4.18) * 127 + 128)
        $colors += "$([char]27)[38;2;$r;$g;${b}m$($text[$i])"
    }
    return ($colors -join '') + "$([char]27)[0m"
}

# Simple Solid Color Text
function Get-ColorText ($text, $r, $g, $b) {
    return "$([char]27)[38;2;$r;$g;${b}m$text$([char]27)[0m"
}

$savePath = "$env:APPDATA\..\LocalLow\Butchers Games\Cam Masters_ Private Desires\GameData.json"

# Auto-detect or request path
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

$phase = 0.0
$message = ""
$messageColor = @(255, 255, 255)

while ($true) {
    Clear-Host
    
    # Render Animated Rainbow Title
    Write-Host (Get-RainbowText "==================================================" $phase)
    Write-Host (Get-RainbowText "      Cam Masters: Private Desires - Save Editor  " $phase)
    Write-Host (Get-RainbowText "                 github.com/homychokk             " $phase)
    Write-Host (Get-RainbowText "==================================================" $phase)
    Write-Host ""
    
    Write-Host "  Save File: " -NoNewline
    Write-Host $savePath -ForegroundColor Cyan
    Write-Host ""
    
    # If there's a status message, show it
    if ($message -ne "") {
        Write-Host "  >>> $(Get-ColorText $message $messageColor[0] $messageColor[1] $messageColor[2]) <<<"
        Write-Host ""
    }
    
    # Render Menu with clean styling
    Write-Host "  [1] " -NoNewline; Write-Host "💰 Add Coins + Diamonds + Stars + Energy" -ForegroundColor Green
    Write-Host "  [2] " -NoNewline; Write-Host "👧 Unlock All Girls + Skins" -ForegroundColor Magenta
    Write-Host "  [3] " -NoNewline; Write-Host "📺 Unlock All Streams + Chats" -ForegroundColor Cyan
    Write-Host "  [4] " -NoNewline; Write-Host "🎟️  Get Battle Pass Premium (Level 100)" -ForegroundColor Yellow
    Write-Host "  [5] " -NoNewline; Write-Host "⚡ Get All Abilities (x99)" -ForegroundColor LightGray
    Write-Host "  [6] " -NoNewline; Write-Host "🚀 UNLOCK EVERYTHING (Recommended)" -ForegroundColor White
    Write-Host "  [7] " -NoNewline; Write-Host "🔓 Remove read-only lock (restore saves)" -ForegroundColor DarkGray
    Write-Host "  [0] " -NoNewline; Write-Host "❌ Exit" -ForegroundColor Red
    Write-Host ""
    Write-Host (Get-RainbowText "==================================================" $phase)
    Write-Host "  Select option [0-7]: " -NoNewline
    
    # Animation Delay Loop (Smooth color transition)
    $keyFound = $false
    for ($t = 0; $t -lt 15; $t++) {
        if ([Console]::KeyAvailable) {
            $keyFound = $true
            break
        }
        Start-Sleep -Milliseconds 15
    }
    $phase += 0.15
    
    if ($keyFound) {
        $choice = [Console]::ReadKey($true).KeyChar
        $message = ""
        
        # Check if game process is running to warn user
        $gameRunning = Get-Process | Where-Object { $_.Name -match "Cam|Master|Desire" }
        if ($gameRunning) {
            $message = "WARNING: Close the game before modifying save!"
            $messageColor = @(255, 50, 50)
            continue
        }
        
        # Remove read-only attribute if present
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
                $messageColor = @(50, 255, 50)
            }
            "2" {
                $j = Get-Content $savePath -Raw | ConvertFrom-Json
                foreach ($g in $j.Girls.PSObject.Properties) {
                    $g.Value.Lvl = 10
                    $g.Value.LvlScore = 9999
                    $g.Value.UnlockSkins = @(0,1,2,3,4,5)
                    $g.Value.RewardCount = 99
                }
                $j | ConvertTo-Json -Depth 15 | Set-Content $savePath -Encoding UTF8
                $message = "All 28 girls and skins unlocked!"
                $messageColor = @(255, 105, 180)
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
                $messageColor = @(0, 255, 255)
            }
            "4" {
                $j = Get-Content $savePath -Raw | ConvertFrom-Json
                $j.BattlePassPremium = $true
                $j.CurBattlePassLvl = 100
                $j.CurBattlePassScore = 9999999
                $j.CurCollectedBattlePassScore = 9999999
                $j.BattlePassNotCollectedRewards = @()
                $j.BattlePassNotCollectedPremiumRewards = @()
                $j | ConvertTo-Json -Depth 15 | Set-Content $savePath -Encoding UTF8
                $message = "Battle Pass Premium Level 100 activated!"
                $messageColor = @(255, 255, 0)
            }
            "5" {
                $j = Get-Content $savePath -Raw | ConvertFrom-Json
                $j.AbilityCount = @(99,99,99,99,99,99)
                $j.EventAbilityCount = @(99,99,99,99,99,99)
                $j.InfinityEnergyTime = "2099-12-31T23:59:59"
                $j.InfinityThunderTime = "2099-12-31T23:59:59"
                $j.InfinityAddTimeTime = "2099-12-31T23:59:59"
                $j | ConvertTo-Json -Depth 15 | Set-Content $savePath -Encoding UTF8
                $message = "Abilities and Infinite Energy unlocked!"
                $messageColor = @(200, 200, 200)
            }
            "6" {
                $j = Get-Content $savePath -Raw | ConvertFrom-Json
                $j.Coins = 9999999
                $j.Diamonds = 99999
                $j.Stars = 99999
                $j.Energy = 999
                $j.EventCoins = 999999
                $j.AbilityCount = @(99,99,99,99,99,99)
                $j.EventAbilityCount = @(99,99,99,99,99,99)
                $j.InfinityEnergyTime = "2099-12-31T23:59:59"
                $j.InfinityThunderTime = "2099-12-31T23:59:59"
                $j.InfinityAddTimeTime = "2099-12-31T23:59:59"
                $j.BattlePassPremium = $true
                $j.CurBattlePassLvl = 100
                $j.CurBattlePassScore = 9999999
                $j.CurCollectedBattlePassScore = 9999999
                $j.BattlePassNotCollectedRewards = @()
                $j.BattlePassNotCollectedPremiumRewards = @()
                foreach ($g in $j.Girls.PSObject.Properties) {
                    $g.Value.Lvl = 10
                    $g.Value.LvlScore = 9999
                    $g.Value.UnlockSkins = @(0,1,2,3,4,5)
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
                $messageColor = @(255, 255, 255)
            }
            "7" {
                $message = "File read-only restriction removed."
                $messageColor = @(150, 150, 150)
            }
        }
    }
}
