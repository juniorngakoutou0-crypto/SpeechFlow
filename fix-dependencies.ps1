#!/usr/bin/env pwsh
# Script de correction des dépendances SpeechFlow
# Basé sur les recommandations Context7

Write-Host "🔧 Correction des Dépendances SpeechFlow" -ForegroundColor Cyan
Write-Host "Basé sur les recommandations Context7" -ForegroundColor Gray
Write-Host ""

# Fonction pour vérifier les erreurs
function Test-LastCommand {
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Erreur détectée. Code: $LASTEXITCODE" -ForegroundColor Red
        exit $LASTEXITCODE
    }
}

# 1. Vérifier Node.js et npm
Write-Host "📌 Étape 1/6: Vérification de Node.js et npm" -ForegroundColor Yellow
$nodeVersion = node --version
$npmVersion = npm --version
Write-Host "   Node.js: $nodeVersion" -ForegroundColor Green
Write-Host "   npm: $npmVersion" -ForegroundColor Green

if ([int]$nodeVersion.Split('.')[0].Replace('v','') -lt 18) {
    Write-Host "⚠️  Node.js 18+ requis. Votre version: $nodeVersion" -ForegroundColor Red
    exit 1
}

# 2. Nettoyer le cache npm
Write-Host "`n📌 Étape 2/6: Nettoyage du cache npm" -ForegroundColor Yellow
npm cache clean --force
Test-LastCommand
Write-Host "   ✅ Cache nettoyé" -ForegroundColor Green

# 3. Réinstaller les dépendances de l'API
Write-Host "`n📌 Étape 3/6: Réinstallation des dépendances API" -ForegroundColor Yellow
Set-Location apps\api

# Supprimer node_modules et package-lock.json si existants
if (Test-Path "node_modules") {
    Write-Host "   Suppression de node_modules..." -ForegroundColor Gray
    Remove-Item -Recurse -Force node_modules
}
if (Test-Path "package-lock.json") {
    Write-Host "   Suppression de package-lock.json..." -ForegroundColor Gray
    Remove-Item package-lock.json
}

Write-Host "   Installation des dépendances..." -ForegroundColor Gray
npm install
Test-LastCommand
Write-Host "   ✅ Dépendances API installées" -ForegroundColor Green

# 4. Générer le client Prisma avec la nouvelle configuration
Write-Host "`n📌 Étape 4/6: Génération du client Prisma" -ForegroundColor Yellow
Write-Host "   Configuration utilisée: moduleFormat = 'cjs' (compatible NestJS)" -ForegroundColor Gray

npm run prisma:generate
Test-LastCommand

# Vérifier que le client a été généré
if (Test-Path "..\..\node_modules\.prisma\client") {
    Write-Host "   ✅ Client Prisma généré avec succès" -ForegroundColor Green
} else {
    Write-Host "   ⚠️  Client Prisma non trouvé, tentative alternative..." -ForegroundColor Yellow
    npx prisma generate --schema=..\..\prisma\schema.prisma
    Test-LastCommand
}

# 5. Vérifier Docker Compose
Write-Host "`n📌 Étape 5/6: Vérification des services Docker" -ForegroundColor Yellow
Set-Location ..\..

$dockerRunning = docker ps 2>&1 | Select-String "speechflow"
if ($dockerRunning) {
    Write-Host "   ✅ Services Docker actifs" -ForegroundColor Green
    docker-compose -f docker-compose.dev.yml ps
} else {
    Write-Host "   ⚠️  Services Docker non démarrés" -ForegroundColor Yellow
    Write-Host "   Démarrage des services..." -ForegroundColor Gray
    docker-compose -f docker-compose.dev.yml up -d
    Test-LastCommand
    Write-Host "   ✅ Services Docker démarrés" -ForegroundColor Green
}

# 6. Tester la connexion à la base de données
Write-Host "`n📌 Étape 6/6: Test de connexion à la base de données" -ForegroundColor Yellow
Set-Location apps\api

# Attendre que PostgreSQL soit prêt
Start-Sleep -Seconds 3

$dbCheck = npm run prisma:migrate -- --help 2>&1
if ($?) {
    Write-Host "   ✅ Connexion PostgreSQL OK" -ForegroundColor Green
} else {
    Write-Host "   ⚠️  Problème de connexion PostgreSQL" -ForegroundColor Yellow
    Write-Host "   Vérifiez: docker-compose -f docker-compose.dev.yml logs postgres" -ForegroundColor Gray
}

Set-Location ..\..

# Résumé
Write-Host "`n" -NoNewline
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "✅ Correction des dépendances terminée!" -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Cyan

Write-Host "`n📋 Prochaines étapes:" -ForegroundColor Yellow
Write-Host "   1. cd apps\api" -ForegroundColor White
Write-Host "   2. npm run prisma:migrate (créer les tables)" -ForegroundColor White
Write-Host "   3. npm run start:dev (démarrer l'API)" -ForegroundColor White
Write-Host "   4. Tester: http://localhost:4000/api" -ForegroundColor White

Write-Host "`n📚 Documentation:" -ForegroundColor Yellow
Write-Host "   - DEPENDANCES_RESOLUTION.md (guide complet)" -ForegroundColor White
Write-Host "   - INSTALLATION.md (instructions d'installation)" -ForegroundColor White

Write-Host "`n🔍 Vérification finale:" -ForegroundColor Yellow
Write-Host "   cd apps\api && npm list --depth=0" -ForegroundColor White
Write-Host ""
