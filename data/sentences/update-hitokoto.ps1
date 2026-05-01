# Hitokoto Database Update Script
# Download and update hitokoto-osc/sentences-bundle database

# Configuration
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoOwner = "hitokoto-osc"
$RepoName = "sentences-bundle"
$Branch = "master"
$RawBaseUrl = "https://raw.githubusercontent.com/$RepoOwner/$RepoName/$Branch/sentences"
$ApiBaseUrl = "https://api.github.com/repos/$RepoOwner/$RepoName/contents/sentences"
$OutputDir = Join-Path $ScriptDir "sentences"

# Type mapping
$TypeMap = @{
    "a" = "animation"
    "b" = "manga"
    "c" = "game"
    "d" = "literature"
    "e" = "original"
    "f" = "web"
    "g" = "other"
    "h" = "film"
    "i" = "poetry"
    "j" = "music"
    "k" = "philosophy"
    "l" = "joke"
}

# Create output directory
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Hitokoto Database Update Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Get remote file list
Write-Host "Fetching file list from GitHub..." -ForegroundColor Yellow

try {
    $response = Invoke-RestMethod -Uri $ApiBaseUrl -UseBasicParsing
    $jsonFiles = $response | Where-Object { $_.name -match '\.json$' }

    if ($jsonFiles.Count -eq 0) {
        Write-Host "Error: Cannot fetch file list" -ForegroundColor Red
        exit 1
    }

    Write-Host "Found $($jsonFiles.Count) data files" -ForegroundColor Green
    Write-Host ""

    foreach ($file in $jsonFiles) {
        $fileName = $file.name
        $typeCode = $fileName -replace '\.json$', ''
        $typeName = if ($TypeMap.ContainsKey($typeCode)) { $TypeMap[$typeCode] } else { $typeCode }

        Write-Host "Downloading: $fileName ($typeName)..." -NoNewline

        $fileUrl = "$RawBaseUrl/$fileName"
        $outputPath = Join-Path $OutputDir $fileName

        try {
            $content = Invoke-WebRequest -Uri $fileUrl -UseBasicParsing -TimeoutSec 30
            $content.Content | Set-Content -Path $outputPath -Encoding UTF8

            # Parse JSON and count
            $data = $content.Content | ConvertFrom-Json
            $count = $data.Count

            Write-Host " Done ($count items)" -ForegroundColor Green
        }
        catch {
            Write-Host " Failed" -ForegroundColor Red
            Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
        }
    }

    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  Download Complete!" -ForegroundColor Cyan
    Write-Host "  Location: $OutputDir" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Running merge-data.ps1 to generate hitokoto-data.js..." -ForegroundColor Yellow
    
    # Call merge script
    & "$ScriptDir\merge-data.ps1"
}
catch {
    Write-Host ""
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Possible reasons:" -ForegroundColor Yellow
    Write-Host "  1. Network connection issue" -ForegroundColor Gray
    Write-Host "  2. GitHub API rate limit" -ForegroundColor Gray
    Write-Host "  3. Repository temporarily unavailable" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Solutions:" -ForegroundColor Yellow
    Write-Host "  1. Retry later" -ForegroundColor Gray
    Write-Host "  2. Manual download: https://github.com/hitokoto-osc/sentences-bundle" -ForegroundColor Gray
}
