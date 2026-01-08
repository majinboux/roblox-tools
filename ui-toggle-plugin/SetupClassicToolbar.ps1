<# 
    ============================================
    Roblox Studio Classic Toolbar Setup
    By majinboux
    Inspired by Mincraftmark0's video
    ============================================
    
    This script automatically configures Roblox Studio
    to use the classic toolbar layout!
    
    Run as: Right-click → Run with PowerShell
    OR: Open PowerShell and run: .\SetupClassicToolbar.ps1
#>

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Roblox Studio Classic Toolbar Setup" -ForegroundColor Cyan
Write-Host "  By majinboux (inspired by Mincraftmark0)" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Find Roblox Studio settings locations
$localAppData = $env:LOCALAPPDATA
$appData = $env:APPDATA
$robloxVersionsPath = Join-Path $localAppData "Roblox\Versions"
$robloxSettingsPath = Join-Path $appData "Roblox"

Write-Host "[1/5] Checking Roblox Studio installation..." -ForegroundColor Yellow

# Find the latest Roblox Studio version folder
$studioVersions = Get-ChildItem -Path $robloxVersionsPath -Directory -ErrorAction SilentlyContinue | 
    Where-Object { Test-Path (Join-Path $_.FullName "RobloxStudioBeta.exe") } |
    Sort-Object LastWriteTime -Descending

if ($studioVersions.Count -eq 0) {
    Write-Host "ERROR: Roblox Studio not found!" -ForegroundColor Red
    Write-Host "Please install Roblox Studio first." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

$latestStudio = $studioVersions[0]
Write-Host "  Found: $($latestStudio.Name)" -ForegroundColor Green

# ClientSettings folder path
$clientSettingsPath = Join-Path $latestStudio.FullName "ClientSettings"

Write-Host ""
Write-Host "[2/5] Creating ClientSettings folder..." -ForegroundColor Yellow

if (-not (Test-Path $clientSettingsPath)) {
    New-Item -Path $clientSettingsPath -ItemType Directory -Force | Out-Null
    Write-Host "  Created: $clientSettingsPath" -ForegroundColor Green
} else {
    Write-Host "  Already exists" -ForegroundColor Green
}

Write-Host ""
Write-Host "[3/5] Creating classic toolbar configuration..." -ForegroundColor Yellow

# Create the ClientAppSettings.json with fast flags for classic UI
$clientAppSettings = @{
    # UI Layout flags
    "FFlagEnableRibbonCustomization" = "true"
    "FFlagStudioRibbonCustomization" = "true"
    "DFFlagQTCaptureIdleEvents" = "false"
    
    # These help with classic feel
    "FFlagStudioHidePlayButtonWhenInRun" = "false"
    "FFlagEnableRibbonPersistence" = "true"
}

$settingsPath = Join-Path $clientSettingsPath "ClientAppSettings.json"
$clientAppSettings | ConvertTo-Json -Depth 10 | Set-Content -Path $settingsPath -Encoding UTF8
Write-Host "  Created: ClientAppSettings.json" -ForegroundColor Green

Write-Host ""
Write-Host "[4/5] Setting up Studio Settings for classic toolbar..." -ForegroundColor Yellow

# Global settings path
$globalBasicSettingsPath = Join-Path $robloxSettingsPath "GlobalBasicSettings_13.xml"

# Check if GlobalBasicSettings exists
if (Test-Path $globalBasicSettingsPath) {
    Write-Host "  Found GlobalBasicSettings" -ForegroundColor Green
    
    # Backup first
    $backupPath = Join-Path $robloxSettingsPath "GlobalBasicSettings_13_backup.xml"
    if (-not (Test-Path $backupPath)) {
        Copy-Item $globalBasicSettingsPath $backupPath
        Write-Host "  Backed up settings" -ForegroundColor Green
    }
} else {
    Write-Host "  GlobalBasicSettings will be created on first run" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[5/5] Creating ribbon customization file..." -ForegroundColor Yellow

# Ensure the Roblox AppData folder exists
if (-not (Test-Path $robloxSettingsPath)) {
    New-Item -Path $robloxSettingsPath -ItemType Directory -Force | Out-Null
    Write-Host "  Created Roblox settings folder" -ForegroundColor Green
}

# Create a custom ribbon configuration
$ribbonConfigPath = Join-Path $robloxSettingsPath "StudioRibbonConfig.json"

$ribbonConfig = @{
    version = 1
    customTabs = @(
        @{
            name = "Classic"
            tools = @(
                "Undo", "Redo", "Delete", "Block", "Insert", 
                "Move", "Scale", "Rotate", "Anchor",
                "Play", "Stop", "Pause"
            )
        }
    )
    quickAccess = @(
        "Undo", "Redo", "Play", "Stop"
    )
}

$ribbonConfig | ConvertTo-Json -Depth 10 | Set-Content -Path $ribbonConfigPath -Encoding UTF8
Write-Host "  Created: StudioRibbonConfig.json" -ForegroundColor Green

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  SETUP COMPLETE!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Close Roblox Studio if it's open" -ForegroundColor White
Write-Host "  2. Reopen Roblox Studio" -ForegroundColor White
Write-Host "  3. Use 'Add Tools' (Ctrl+Shift+X) to customize" -ForegroundColor White
Write-Host "  4. Search 'Reload custom tabs' and click it" -ForegroundColor White
Write-Host ""
Write-Host "Your settings have been saved to:" -ForegroundColor Yellow
Write-Host "  $settingsPath" -ForegroundColor Gray
Write-Host "  $ribbonConfigPath" -ForegroundColor Gray
Write-Host ""
Write-Host "Made by majinboux | Inspired by Mincraftmark0" -ForegroundColor Magenta
Write-Host ""

# Ask if user wants to restart Studio
$restart = Read-Host "Would you like to close Roblox Studio now? (Y/N)"
if ($restart -eq "Y" -or $restart -eq "y") {
    Write-Host ""
    Write-Host "Closing Roblox Studio..." -ForegroundColor Yellow
    Get-Process -Name "RobloxStudioBeta" -ErrorAction SilentlyContinue | Stop-Process -Force
    Write-Host "Done! Please reopen Roblox Studio." -ForegroundColor Green
}

Write-Host ""
Read-Host "Press Enter to exit"