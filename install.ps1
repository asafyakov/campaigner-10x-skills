# ============================================
# קמפיינר 10X — סקריפט התקנה (Windows)
# ============================================
# מתקין: VS Code, Git, Node.js, Claude Code
# זמן: 5-10 דקות
# להריץ: PowerShell כמנהל (Admin)
# ============================================

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   קמפיינר 10X — התקנה אוטומטית" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# --- בדיקה שרצים כ-Admin ---
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "⚠ חייבים להריץ כמנהל (Admin)! לחצו ימני על PowerShell → Run as Administrator" -ForegroundColor Red
    exit 1
}

# --- Chocolatey ---
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "→ מתקין Chocolatey..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    Write-Host "✓ Chocolatey מותקן" -ForegroundColor Green
} else {
    Write-Host "✓ Chocolatey כבר מותקן" -ForegroundColor Green
}

# --- Git ---
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "→ מתקין Git..." -ForegroundColor Yellow
    choco install git -y
    Write-Host "✓ Git מותקן" -ForegroundColor Green
} else {
    Write-Host "✓ Git כבר מותקן" -ForegroundColor Green
}

# --- Node.js ---
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "→ מתקין Node.js..." -ForegroundColor Yellow
    choco install nodejs-lts -y
    Write-Host "✓ Node.js מותקן" -ForegroundColor Green
} else {
    $nodeVersion = (node -v) -replace 'v','' -split '\.' | Select-Object -First 1
    if ([int]$nodeVersion -lt 18) {
        Write-Host "→ Node.js ישן מדי, מעדכן..." -ForegroundColor Yellow
        choco upgrade nodejs-lts -y
        Write-Host "✓ Node.js עודכן" -ForegroundColor Green
    } else {
        Write-Host "✓ Node.js כבר מותקן ($(node -v))" -ForegroundColor Green
    }
}

# --- VS Code ---
if (-not (Get-Command code -ErrorAction SilentlyContinue)) {
    Write-Host "→ מתקין VS Code..." -ForegroundColor Yellow
    choco install vscode -y
    Write-Host "✓ VS Code מותקן" -ForegroundColor Green
} else {
    Write-Host "✓ VS Code כבר מותקן" -ForegroundColor Green
}

# --- רענון PATH ---
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# --- Claude Code CLI ---
if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    Write-Host "→ מתקין Claude Code..." -ForegroundColor Yellow
    npm install -g @anthropic-ai/claude-code
    Write-Host "✓ Claude Code מותקן" -ForegroundColor Green
} else {
    Write-Host "✓ Claude Code כבר מותקן" -ForegroundColor Green
}

# --- יצירת תיקיית סוכנות ---
$agencyDir = "$env:USERPROFILE\Desktop\סוכנות"
if (-not (Test-Path $agencyDir)) {
    Write-Host "→ יוצר תיקיית סוכנות על שולחן העבודה..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $agencyDir | Out-Null
    Write-Host "✓ תיקייה נוצרה: $agencyDir" -ForegroundColor Green
} else {
    Write-Host "✓ תיקיית סוכנות כבר קיימת" -ForegroundColor Green
}

# --- סיכום ---
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   ההתקנה הסתיימה!" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "✓ VS Code" -ForegroundColor Green
Write-Host "✓ Git" -ForegroundColor Green
Write-Host "✓ Node.js $(node -v)" -ForegroundColor Green
Write-Host "✓ Claude Code" -ForegroundColor Green
Write-Host "✓ תיקיית סוכנות: $agencyDir" -ForegroundColor Green
Write-Host ""
Write-Host "מה עכשיו?"
Write-Host "1. פתחו VS Code"
Write-Host "2. File → Open Folder → בחרו את תיקיית 'סוכנות'"
Write-Host "3. פתחו Terminal (למטה) וכתבו: claude"
Write-Host "4. כתבו: /agency-setup"
Write-Host ""
Write-Host "============================================"
