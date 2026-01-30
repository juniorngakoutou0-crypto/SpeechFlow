#!/usr/bin/env pwsh
# Script d'installation Frontend et Worker
# Basé sur les recommandations Context7

Write-Host "🚀 Installation Frontend & Worker SpeechFlow" -ForegroundColor Cyan
Write-Host "Basé sur les recommandations Context7" -ForegroundColor Gray
Write-Host ""

# Fonction pour vérifier les erreurs
function Test-LastCommand {
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Erreur détectée. Code: $LASTEXITCODE" -ForegroundColor Red
        return $false
    }
    return $true
}

# ═══════════════════════════════════════════════════════
# FRONTEND NEXT.JS 15
# ═══════════════════════════════════════════════════════

Write-Host "📌 Partie 1: Installation Frontend Next.js 15" -ForegroundColor Yellow
Write-Host ""

if (Test-Path "apps\frontend\package.json") {
    Write-Host "⚠️  Frontend déjà existant" -ForegroundColor Yellow
    $response = Read-Host "   Voulez-vous le réinstaller? (o/N)"
    if ($response -ne 'o' -and $response -ne 'O') {
        Write-Host "   ⏭️  Skipping frontend installation" -ForegroundColor Gray
        $skipFrontend = $true
    } else {
        Write-Host "   Suppression du frontend existant..." -ForegroundColor Gray
        Remove-Item -Recurse -Force apps\frontend
        $skipFrontend = $false
    }
} else {
    $skipFrontend = $false
}

if (-not $skipFrontend) {
    Write-Host "   Création du projet Next.js..." -ForegroundColor Gray
    Write-Host ""

    # Créer le projet Next.js avec les bonnes options
    Set-Location apps

    # Options: TypeScript, Tailwind CSS, App Router, pas de src directory
    npx create-next-app@latest frontend `
        --typescript `
        --tailwind `
        --app `
        --no-src-dir `
        --import-alias "@/*" `
        --use-npm

    if (-not (Test-LastCommand)) {
        Write-Host "❌ Erreur lors de la création du frontend" -ForegroundColor Red
        exit 1
    }

    Set-Location frontend

    Write-Host "`n   Installation des dépendances supplémentaires..." -ForegroundColor Gray

    # Installer Zustand pour le state management
    npm install zustand
    Test-LastCommand

    Write-Host "   ✅ Frontend créé avec succès" -ForegroundColor Green

    # Initialiser shadcn/ui
    Write-Host "`n   Configuration de shadcn/ui..." -ForegroundColor Gray
    npx shadcn@latest init -y

    # Installer les composants de base
    Write-Host "   Installation des composants shadcn/ui..." -ForegroundColor Gray
    npx shadcn@latest add button -y
    npx shadcn@latest add input -y
    npx shadcn@latest add card -y
    npx shadcn@latest add form -y
    npx shadcn@latest add toast -y
    npx shadcn@latest add dialog -y
    npx shadcn@latest add dropdown-menu -y
    npx shadcn@latest add avatar -y

    Write-Host "   ✅ shadcn/ui configuré" -ForegroundColor Green

    Set-Location ..\..
}

# ═══════════════════════════════════════════════════════
# WORKER PYTHON
# ═══════════════════════════════════════════════════════

Write-Host "`n📌 Partie 2: Installation Worker Python" -ForegroundColor Yellow
Write-Host ""

# Vérifier si Python est installé
$pythonVersion = python --version 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Python n'est pas installé ou pas dans le PATH" -ForegroundColor Red
    Write-Host "   Installez Python 3.10+ depuis https://www.python.org/downloads/" -ForegroundColor Yellow
    exit 1
}

Write-Host "   Python: $pythonVersion" -ForegroundColor Green

# Créer le dossier worker s'il n'existe pas
if (-not (Test-Path "apps\worker")) {
    Write-Host "   Création du dossier worker..." -ForegroundColor Gray
    New-Item -ItemType Directory -Path "apps\worker"
}

Set-Location apps\worker

# Créer requirements.txt
Write-Host "   Création de requirements.txt..." -ForegroundColor Gray
@"
# Transcription Audio/Vidéo
faster-whisper==1.0.3
torch==2.1.0
torchaudio==2.1.0

# IA et LLM via OpenRouter
openai==1.0.0
httpx==0.25.0

# Génération de PDF
reportlab==4.0.7
Pillow==10.1.0

# Queue Processing avec Redis
redis==5.0.1
rq==1.15.1

# Storage S3-compatible (MinIO)
boto3==1.29.0
minio==7.2.0

# Database
psycopg2-binary==2.9.9

# Utilities
python-dotenv==1.0.0
pydantic==2.5.0
requests==2.31.0
"@ | Out-File -FilePath "requirements.txt" -Encoding UTF8

Write-Host "   ✅ requirements.txt créé" -ForegroundColor Green

# Créer l'environnement virtuel
if (Test-Path "venv") {
    Write-Host "   ⚠️  venv déjà existant" -ForegroundColor Yellow
    $response = Read-Host "   Voulez-vous le recréer? (o/N)"
    if ($response -eq 'o' -or $response -eq 'O') {
        Write-Host "   Suppression du venv existant..." -ForegroundColor Gray
        Remove-Item -Recurse -Force venv
        $createVenv = $true
    } else {
        $createVenv = $false
    }
} else {
    $createVenv = $true
}

if ($createVenv) {
    Write-Host "   Création de l'environnement virtuel..." -ForegroundColor Gray
    python -m venv venv
    Test-LastCommand
    Write-Host "   ✅ Environnement virtuel créé" -ForegroundColor Green
}

# Activer et installer les dépendances
Write-Host "   Activation du venv et installation des dépendances..." -ForegroundColor Gray
Write-Host "   (Cela peut prendre plusieurs minutes...)" -ForegroundColor Gray

& .\venv\Scripts\Activate.ps1

# Upgrade pip
python -m pip install --upgrade pip

# Installer les dépendances
pip install -r requirements.txt

if (Test-LastCommand) {
    Write-Host "   ✅ Dépendances Python installées" -ForegroundColor Green
} else {
    Write-Host "   ⚠️  Certaines dépendances ont échoué" -ForegroundColor Yellow
    Write-Host "   Vérifiez les logs ci-dessus pour plus de détails" -ForegroundColor Gray
}

# Créer .env pour le worker
Write-Host "   Création de .env pour le worker..." -ForegroundColor Gray
@"
# Database
DATABASE_URL=postgresql://speechflow:password@localhost:5432/speechflow

# Redis
REDIS_HOST=localhost
REDIS_PORT=6379

# MinIO (S3-compatible)
MINIO_ENDPOINT=localhost:9000
MINIO_ACCESS_KEY=admin
MINIO_SECRET_KEY=adminpassword
MINIO_BUCKET=speechflow

# OpenRouter API
OPENROUTER_API_KEY=your_openrouter_api_key_here

# Worker Config
WORKER_CONCURRENCY=2
"@ | Out-File -FilePath ".env" -Encoding UTF8

Write-Host "   ✅ .env créé (pensez à configurer OPENROUTER_API_KEY)" -ForegroundColor Green

deactivate

Set-Location ..\..

# ═══════════════════════════════════════════════════════
# RÉSUMÉ
# ═══════════════════════════════════════════════════════

Write-Host "`n" -NoNewline
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "✅ Installation Frontend & Worker terminée!" -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Cyan

Write-Host "`n📦 Composants installés:" -ForegroundColor Yellow
if (-not $skipFrontend) {
    Write-Host "   ✅ Frontend Next.js 15 + TypeScript + Tailwind" -ForegroundColor Green
    Write-Host "   ✅ Zustand (state management)" -ForegroundColor Green
    Write-Host "   ✅ shadcn/ui (composants UI)" -ForegroundColor Green
}
Write-Host "   ✅ Worker Python + venv" -ForegroundColor Green
Write-Host "   ✅ requirements.txt configuré" -ForegroundColor Green

Write-Host "`n📋 Pour démarrer le frontend:" -ForegroundColor Yellow
Write-Host "   cd apps\frontend" -ForegroundColor White
Write-Host "   npm run dev" -ForegroundColor White
Write-Host "   Accès: http://localhost:3000" -ForegroundColor Gray

Write-Host "`n📋 Pour démarrer le worker:" -ForegroundColor Yellow
Write-Host "   cd apps\worker" -ForegroundColor White
Write-Host "   .\venv\Scripts\Activate.ps1" -ForegroundColor White
Write-Host "   python main.py (une fois créé)" -ForegroundColor White

Write-Host "`n⚠️  Important:" -ForegroundColor Yellow
Write-Host "   - Configurez OPENROUTER_API_KEY dans apps\worker\.env" -ForegroundColor White
Write-Host "   - Les services Docker doivent être actifs" -ForegroundColor White

Write-Host "`n📚 Documentation:" -ForegroundColor Yellow
Write-Host "   - DEPENDANCES_RESOLUTION.md" -ForegroundColor White
Write-Host "   - INSTALLATION.md" -ForegroundColor White
Write-Host ""
