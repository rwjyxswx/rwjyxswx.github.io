# Hitokoto Database Merge Script
# Merge all JSON files into hitokoto-data.js

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$InputDir = Join-Path $ScriptDir "sentences"
$OutputPath = Join-Path $ScriptDir "..\themes\minimal-chinese\static\js\hitokoto-data.js"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Hitokoto Data Merge Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $InputDir)) {
    Write-Host "Error: Input directory not found: $InputDir" -ForegroundColor Red
    exit 1
}

$jsonFiles = Get-ChildItem -Path $InputDir -Filter "*.json" | Sort-Object Name

if ($jsonFiles.Count -eq 0) {
    Write-Host "Error: No JSON files found in: $InputDir" -ForegroundColor Red
    exit 1
}

Write-Host "Found $($jsonFiles.Count) JSON files" -ForegroundColor Green
Write-Host ""

$totalCount = 0
$allSentences = @()

foreach ($file in $jsonFiles) {
    Write-Host "Reading: $($file.Name)..." -NoNewline

    try {
        $data = Get-Content -Path $file.FullName -Raw -Encoding UTF8 | ConvertFrom-Json
        $count = $data.Count
        $totalCount += $count

        Write-Host " $count items" -ForegroundColor Green

        foreach ($item in $data) {
            $allSentences += @{
                text = $item.hitokoto
                author = $item.from_who
                type = $item.type
                from = $item.from
            }
        }
    }
    catch {
        Write-Host " Failed" -ForegroundColor Red
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Merging $totalCount sentences..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Ensure output directory exists
$outputDir = Split-Path -Parent $OutputPath
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
}

# Generate hitokoto-data.js using ConvertTo-Json for proper escaping
$currentDate = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'

$jsContent = @"
// Hitokoto Local Database
// Source: https://github.com/hitokoto-osc/sentences-bundle
// Generated: $currentDate
// Total: $totalCount sentences
// AGPL License - Must follow open source license terms

const hitokotoData = $($allSentences | ConvertTo-Json -Depth 100 -Compress);

function getRandomHitokoto() {
  const index = Math.floor(Math.random() * hitokotoData.length);
  return hitokotoData[index];
}

window.hitokotoData = hitokotoData;
window.getRandomHitokoto = getRandomHitokoto;
"@

$jsContent | Set-Content -Path $OutputPath -Encoding UTF8 -NoNewline

Write-Host "========================================" -ForegroundColor Green
Write-Host "  Success!" -ForegroundColor Green
Write-Host "  Total: $totalCount sentences" -ForegroundColor Yellow
Write-Host "  Output: $OutputPath" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Please rebuild the website to apply new data" -ForegroundColor Cyan
