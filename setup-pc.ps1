# ============================================================
# setup-pc.ps1 - Clone mcp-ollama-python to PC automatically
# ============================================================

$GitPath   = 'D:\admin-system.Windows11M2\Git\bin\git.exe'
$RepoUrl   = 'https://github.com/6402003757/mcp-ollama-python'
$CloneDest = 'D:\mcp-ollama-python'
$ChatDest  = 'D:\aichat'

# ---- Locate git ----
if (Test-Path $GitPath) {
    $git = $GitPath
} elseif (Get-Command git -ErrorAction SilentlyContinue) {
    $git = 'git'
} else {
    Write-Host '[ERROR] ไม่พบ git กรุณาติดตั้งก่อน: https://git-scm.com/download/win' -ForegroundColor Red
    pause; exit 1
}

Write-Host "[OK] ใช้ git: $git" -ForegroundColor Green

# ---- Create D:\aichat if not exists ----
if (-not (Test-Path $ChatDest)) {
    New-Item -ItemType Directory -Path $ChatDest | Out-Null
    Write-Host "[OK] สร้างโฟลเดอร์ $ChatDest แล้ว" -ForegroundColor Green
} else {
    Write-Host "[OK] โฟลเดอร์ $ChatDest มีอยู่แล้ว" -ForegroundColor Cyan
}

# ---- Clone repo ----
if (Test-Path $CloneDest) {
    Write-Host "[INFO] โฟลเดอร์ $CloneDest มีอยู่แล้ว — ดึง update แทน..." -ForegroundColor Yellow
    & $git -C $CloneDest pull
} else {
    Write-Host "[INFO] กำลัง clone จาก GitHub..." -ForegroundColor Cyan
    & $git clone $RepoUrl $CloneDest
}

if ($LASTEXITCODE -ne 0) {
    Write-Host '[ERROR] clone/pull ล้มเหลว' -ForegroundColor Red
    pause; exit 1
}

Write-Host ''
Write-Host '====================================' -ForegroundColor Green
Write-Host " เสร็จแล้ว! โปรเจกต์อยู่ที่: $CloneDest" -ForegroundColor Green
Write-Host " โฟลเดอร์ chat อยู่ที่:        $ChatDest" -ForegroundColor Green
Write-Host '====================================' -ForegroundColor Green
Write-Host ''

# ---- Open in VS Code if available ----
if (Get-Command code -ErrorAction SilentlyContinue) {
    Write-Host '[INFO] เปิด VS Code...' -ForegroundColor Cyan
    code $CloneDest
} else {
    Write-Host "[INFO] เปิดโฟลเดอร์ $CloneDest ใน Explorer" -ForegroundColor Cyan
    explorer $CloneDest
}

pause
