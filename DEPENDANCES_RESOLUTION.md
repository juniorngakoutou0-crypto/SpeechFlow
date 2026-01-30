# Guide de Résolution des Dépendances SpeechFlow

Ce guide a été créé en utilisant Context7 pour assurer les meilleures pratiques et versions compatibles.

## 📦 Backend API (NestJS)

### Versions Recommandées

D'après la documentation officielle NestJS et les meilleures pratiques :

```json
{
  "dependencies": {
    "@nestjs/common": "^10.0.0",
    "@nestjs/config": "^3.0.0",
    "@nestjs/core": "^10.0.0",
    "@nestjs/jwt": "^10.1.0",
    "@nestjs/passport": "^10.0.0",
    "@nestjs/platform-express": "^10.0.0",
    "@prisma/client": "^5.0.0",
    "bcrypt": "^5.1.1",
    "class-transformer": "^0.5.1",
    "class-validator": "^0.14.0",
    "passport": "^0.6.0",
    "passport-jwt": "^4.0.1",
    "reflect-metadata": "^0.1.13",
    "rxjs": "^7.8.1"
  },
  "devDependencies": {
    "@nestjs/cli": "^10.0.0",
    "@nestjs/schematics": "^10.0.0",
    "@nestjs/testing": "^10.0.0",
    "@types/bcrypt": "^5.0.0",
    "@types/express": "^4.17.17",
    "@types/jest": "^29.5.2",
    "@types/node": "^20.3.1",
    "@types/passport-jwt": "^3.0.9",
    "@types/supertest": "^2.0.12",
    "@typescript-eslint/eslint-plugin": "^6.0.0",
    "@typescript-eslint/parser": "^6.0.0",
    "eslint": "^8.42.0",
    "eslint-config-prettier": "^9.0.0",
    "eslint-plugin-prettier": "^5.0.0",
    "jest": "^29.5.0",
    "prettier": "^3.0.0",
    "prisma": "^5.0.0",
    "source-map-support": "^0.5.21",
    "supertest": "^6.3.3",
    "ts-jest": "^29.1.0",
    "ts-loader": "^9.4.3",
    "ts-node": "^10.9.1",
    "tsconfig-paths": "^4.2.0",
    "typescript": "^5.1.3"
  }
}
```

### 🔧 Correction du Schema Prisma

Le schema actuel utilise une ancienne configuration. Voici la configuration recommandée pour NestJS :

**Ancien (actuel) :**
```prisma
generator client {
  provider = "prisma-client-js"
}
```

**Nouveau (recommandé par Context7) :**
```prisma
generator client {
  provider = "prisma-client"
  moduleFormat = "cjs"
}
```

**Pourquoi ?**
- `prisma-client` est le nouveau format (Prisma v7+)
- `moduleFormat = "cjs"` assure la compatibilité avec CommonJS de NestJS
- Sans cela, vous pouvez avoir des erreurs d'import

### 📝 Installation Propre des Dépendances

```powershell
# 1. Supprimer les dépendances existantes
cd apps/api
Remove-Item -Recurse -Force node_modules
Remove-Item package-lock.json

# 2. Nettoyer le cache npm
npm cache clean --force

# 3. Réinstaller les dépendances
npm install

# 4. Générer le client Prisma avec la nouvelle config
npm run prisma:generate

# 5. Vérifier l'installation
npm list --depth=0
```

## 🎨 Frontend (Next.js 15)

### Structure à créer

```powershell
cd apps
npx create-next-app@latest frontend --typescript --tailwind --app --no-src-dir
cd frontend
```

### Dépendances Principales

```json
{
  "dependencies": {
    "next": "^15.0.0",
    "react": "^19.0.0",
    "react-dom": "^19.0.0",
    "zustand": "^5.0.0",
    "@radix-ui/react-slot": "^1.0.2",
    "class-variance-authority": "^0.7.0",
    "clsx": "^2.0.0",
    "tailwind-merge": "^2.0.0",
    "lucide-react": "^0.300.0"
  },
  "devDependencies": {
    "@types/node": "^20.0.0",
    "@types/react": "^19.0.0",
    "@types/react-dom": "^19.0.0",
    "typescript": "^5.0.0",
    "tailwindcss": "^3.4.0",
    "postcss": "^8.0.0",
    "autoprefixer": "^10.0.0",
    "eslint": "^8.0.0",
    "eslint-config-next": "^15.0.0"
  }
}
```

### Installation shadcn/ui

```powershell
cd apps/frontend
npx shadcn@latest init

# Installer les composants nécessaires
npx shadcn@latest add button
npx shadcn@latest add input
npx shadcn@latest add card
npx shadcn@latest add form
npx shadcn@latest add toast
npx shadcn@latest add dialog
```

## 🐍 Worker Python

### Structure à créer

```powershell
cd apps/worker
python -m venv venv
.\venv\Scripts\Activate.ps1
```

### requirements.txt

```txt
# Transcription
faster-whisper==1.0.3
torch==2.1.0
torchaudio==2.1.0

# IA et LLM
openai==1.0.0
httpx==0.25.0

# PDF Generation
reportlab==4.0.7
Pillow==10.1.0

# Queue Processing
redis==5.0.1
rq==1.15.1

# Storage
boto3==1.29.0  # Pour MinIO (compatible S3)

# Utilities
python-dotenv==1.0.0
pydantic==2.5.0
```

### Installation

```powershell
cd apps/worker
pip install -r requirements.txt

# Vérifier l'installation
pip list
```

## 🔍 Vérification des Dépendances

### Script de Vérification Global

Créez un fichier `verify-deps.ps1` à la racine :

```powershell
#!/usr/bin/env pwsh

Write-Host "🔍 Vérification des dépendances SpeechFlow" -ForegroundColor Cyan

# API Backend
Write-Host "`n📦 Backend API (NestJS)..." -ForegroundColor Yellow
cd apps/api
if (Test-Path "node_modules") {
    Write-Host "✅ node_modules trouvé" -ForegroundColor Green
    npm list --depth=0 | Select-String "@nestjs|prisma|bcrypt|class-validator|passport"
} else {
    Write-Host "❌ node_modules manquant - Exécutez: npm install" -ForegroundColor Red
}
cd ../..

# Frontend
Write-Host "`n🎨 Frontend (Next.js)..." -ForegroundColor Yellow
cd apps/frontend
if (Test-Path ".") {
    if (Test-Path "node_modules") {
        Write-Host "✅ node_modules trouvé" -ForegroundColor Green
        npm list --depth=0 | Select-String "next|react|zustand"
    } else {
        Write-Host "❌ node_modules manquant - Exécutez: npm install" -ForegroundColor Red
    }
} else {
    Write-Host "⚠️  Frontend non créé" -ForegroundColor Yellow
}
cd ../..

# Worker Python
Write-Host "`n🐍 Worker Python..." -ForegroundColor Yellow
cd apps/worker
if (Test-Path "venv") {
    Write-Host "✅ venv trouvé" -ForegroundColor Green
    .\venv\Scripts\Activate.ps1
    pip list | Select-String "faster-whisper|openai|reportlab|redis"
    deactivate
} else {
    Write-Host "⚠️  venv non créé" -ForegroundColor Yellow
}
cd ../..

Write-Host "`n✅ Vérification terminée!" -ForegroundColor Green
```

## 🐛 Résolution des Problèmes Courants

### Problème 1 : Erreur Prisma Client

**Symptôme :**
```
Error: Cannot find module '@prisma/client'
```

**Solution :**
```powershell
cd apps/api
npm run prisma:generate
```

### Problème 2 : Conflits de Types TypeScript

**Symptôme :**
```
Type error: Cannot find module or its corresponding type declarations
```

**Solution :**
```powershell
cd apps/api
npm install --save-dev @types/bcrypt @types/passport-jwt @types/node
```

### Problème 3 : class-validator ne fonctionne pas

**Symptôme :**
```
ValidationPipe doesn't validate DTOs
```

**Solution :**
Assurez-vous d'avoir installé `class-transformer` :
```powershell
npm install class-transformer
```

Et activez le ValidationPipe global dans `main.ts` :
```typescript
import { ValidationPipe } from '@nestjs/common';

app.useGlobalPipes(new ValidationPipe({
  whitelist: true,
  forbidNonWhitelisted: true,
  transform: true,
}));
```

### Problème 4 : Erreur de connexion PostgreSQL

**Symptôme :**
```
Error: connect ECONNREFUSED 127.0.0.1:5432
```

**Solution :**
```powershell
# Démarrer Docker Compose
docker-compose -f docker-compose.dev.yml up -d postgres

# Vérifier que PostgreSQL fonctionne
docker-compose -f docker-compose.dev.yml ps
docker-compose -f docker-compose.dev.yml logs postgres
```

## 📚 Ressources Context7 Utilisées

Ce guide a été créé en utilisant la documentation officielle via Context7 :

- **NestJS** : `/websites/nestjs` - 2103 code snippets
- **Prisma** : `/websites/prisma_io` - 8000 code snippets
- **class-validator** : `/typestack/class-validator` - 59 code snippets

## ✅ Checklist de Validation

Avant de continuer le développement, vérifiez que :

- [ ] Docker Compose fonctionne (PostgreSQL, Redis, MinIO)
- [ ] `apps/api/node_modules` existe avec toutes les dépendances
- [ ] `npm run prisma:generate` fonctionne sans erreur
- [ ] `npm run start:dev` démarre l'API sur le port 4000
- [ ] Les endpoints `/api/auth/register` et `/api/auth/login` répondent
- [ ] Le schema Prisma utilise `moduleFormat = "cjs"`
- [ ] Les migrations sont à jour

## 🚀 Prochaines Étapes

1. **Corriger le schema.prisma** (ajouter `moduleFormat = "cjs"`)
2. **Réinstaller les dépendances API** si nécessaire
3. **Créer le frontend Next.js** avec les bonnes dépendances
4. **Configurer le worker Python** avec le venv et requirements.txt
5. **Tester l'ensemble de la stack**

---

**Généré avec Context7** - Documentation officielle à jour
**Date :** 2026-01-30
**Version :** 1.0
