# 🚀 Guide de Démarrage Rapide SpeechFlow

Ce guide vous permet de démarrer SpeechFlow en **moins de 10 minutes**.

## ⚡ Installation en 5 Étapes

### Étape 1 : Vérifier les Prérequis (2 min)

Ouvrez PowerShell et vérifiez :

```powershell
# Node.js (v18+ requis)
node --version

# npm
npm --version

# Docker
docker --version

# Python (v3.10+ requis)
python --version
```

**Si quelque chose manque :**
- Node.js : https://nodejs.org/ (télécharger LTS)
- Docker Desktop : https://www.docker.com/products/docker-desktop
- Python : https://www.python.org/downloads/

### Étape 2 : Cloner et Naviguer (30 sec)

```powershell
cd C:\Users\junio\Desktop\SpeechFlow
```

### Étape 3 : Corriger les Dépendances Backend (3-5 min)

```powershell
.\fix-dependencies.ps1
```

**Ce script va :**
- ✅ Vérifier Node.js et npm
- ✅ Nettoyer le cache
- ✅ Réinstaller les dépendances
- ✅ Générer Prisma Client avec la config optimale
- ✅ Démarrer Docker Compose (PostgreSQL, Redis, MinIO)

**⏱️ Durée : 3-5 minutes**

### Étape 4 : Créer la Base de Données (1 min)

```powershell
cd apps\api
npm run prisma:migrate
```

Quand demandé, entrez le nom : `init-complete`

### Étape 5 : Démarrer l'API (10 sec)

```powershell
npm run start:dev
```

**✅ Succès !** Vous devriez voir :
```
[Nest] Application is running on: http://localhost:4000
```

## 🧪 Tester l'Installation

### Tester avec curl (Windows PowerShell)

```powershell
# Ouvrir un NOUVEAU terminal PowerShell

# 1. Inscription
Invoke-RestMethod -Method Post -Uri "http://localhost:4000/api/auth/register" `
  -Headers @{"Content-Type"="application/json"} `
  -Body '{"name":"Test User","email":"test@example.com","password":"password123"}'

# Vous devriez recevoir un token JWT
```

### Tester avec Postman ou Insomnia

**1. Inscription (POST)**
```
URL: http://localhost:4000/api/auth/register
Method: POST
Headers: Content-Type: application/json
Body:
{
  "name": "Test User",
  "email": "test@example.com",
  "password": "password123"
}
```

**2. Connexion (POST)**
```
URL: http://localhost:4000/api/auth/login
Method: POST
Headers: Content-Type: application/json
Body:
{
  "email": "test@example.com",
  "password": "password123"
}
```

**3. Profil (GET)**
```
URL: http://localhost:4000/api/auth/me
Method: GET
Headers:
  Content-Type: application/json
  Authorization: Bearer <votre_token_ici>
```

## 🎨 Installer le Frontend (Optionnel)

Si vous voulez également le frontend :

```powershell
# Retourner à la racine
cd ..\..

# Exécuter le script d'installation
.\setup-frontend-worker.ps1
```

**Ce script va :**
- ✅ Créer le projet Next.js 15
- ✅ Installer Tailwind CSS et TypeScript
- ✅ Configurer Zustand et shadcn/ui
- ✅ Créer l'environnement Python (pour plus tard)

**⏱️ Durée : 5-10 minutes**

Puis démarrer :

```powershell
cd apps\frontend
npm run dev
```

**Frontend disponible :** http://localhost:3000

## 📊 Vérifier les Services Docker

```powershell
# Voir les services actifs
docker-compose -f docker-compose.dev.yml ps

# Voir les logs
docker-compose -f docker-compose.dev.yml logs -f
```

**Services attendus :**
```
NAME                  STATUS    PORTS
speechflow-postgres   Up        0.0.0.0:5432->5432/tcp
speechflow-redis      Up        0.0.0.0:6379->6379/tcp
speechflow-minio      Up        0.0.0.0:9000-9001->9000-9001/tcp
```

## 🔍 Accès aux Outils

| Outil | URL | Identifiants |
|-------|-----|--------------|
| API Backend | http://localhost:4000/api | - |
| Frontend (si installé) | http://localhost:3000 | - |
| MinIO Console | http://localhost:9001 | admin / adminpassword |
| Prisma Studio | `npm run prisma:studio` | - |

## 🐛 Problèmes Courants

### ❌ "Port 4000 déjà utilisé"

**Solution :**
```powershell
# Modifier le port dans apps/api/.env
notepad apps\api\.env
# Changer PORT=4000 en PORT=4001
```

### ❌ "Cannot find module '@prisma/client'"

**Solution :**
```powershell
cd apps\api
npm run prisma:generate
```

### ❌ "connect ECONNREFUSED 127.0.0.1:5432"

**Solution :**
```powershell
# Redémarrer PostgreSQL
docker-compose -f docker-compose.dev.yml restart postgres

# Attendre 10 secondes puis réessayer
```

### ❌ "npm install" échoue

**Solution :**
```powershell
cd apps\api
Remove-Item -Recurse -Force node_modules
Remove-Item package-lock.json
npm cache clean --force
npm install
```

## 📚 Prochaines Étapes

Maintenant que l'API fonctionne, vous pouvez :

1. **Développer le Frontend**
   - Créer les pages d'authentification
   - Configurer le store Zustand
   - Développer le dashboard

2. **Développer le Worker Python**
   - Activer le venv : `cd apps\worker && .\venv\Scripts\Activate.ps1`
   - Créer le service de transcription
   - Créer le service de génération PDF

3. **Ajouter des Fonctionnalités**
   - Gestion des dossiers
   - Upload de fichiers
   - Gestion des PDFs

## 📖 Documentation Complète

Pour plus de détails, consultez :

- [RESOLUTION_COMPLETE.md](RESOLUTION_COMPLETE.md) - Guide complet de résolution
- [DEPENDANCES_RESOLUTION.md](DEPENDANCES_RESOLUTION.md) - Détails des dépendances
- [INSTALLATION.md](INSTALLATION.md) - Installation détaillée
- [PRD.md](PRD.md) - Spécifications du produit
- [architecture.md](architecture.md) - Architecture technique

## ✅ Checklist de Validation

Cochez au fur et à mesure :

- [ ] Node.js 18+ installé
- [ ] Docker Desktop installé et actif
- [ ] Script `fix-dependencies.ps1` exécuté avec succès
- [ ] Services Docker actifs (postgres, redis, minio)
- [ ] Migrations Prisma appliquées
- [ ] API démarre sur le port 4000
- [ ] Test d'inscription réussi (POST /api/auth/register)
- [ ] Test de connexion réussi (POST /api/auth/login)
- [ ] Token JWT reçu et valide

## 💡 Conseils

### Organiser votre Espace de Travail

```powershell
# Terminal 1 : API Backend
cd apps\api
npm run start:dev

# Terminal 2 : Frontend (si installé)
cd apps\frontend
npm run dev

# Terminal 3 : Commandes diverses
# Prisma Studio, migrations, etc.
```

### Prisma Studio (Explorateur de DB)

```powershell
cd apps\api
npm run prisma:studio
```

Ouvre une interface web pour explorer et modifier la base de données.

### Logs Docker en Temps Réel

```powershell
# Tous les services
docker-compose -f docker-compose.dev.yml logs -f

# Seulement PostgreSQL
docker-compose -f docker-compose.dev.yml logs -f postgres
```

## 🎯 Objectif Atteint

Si vous avez suivi ce guide, vous avez maintenant :

- ✅ Un backend NestJS fonctionnel avec JWT auth
- ✅ Une base PostgreSQL avec Prisma ORM
- ✅ Redis pour les queues
- ✅ MinIO pour le stockage de fichiers
- ✅ Un environnement de développement complet
- ✅ (Optionnel) Un frontend Next.js 15
- ✅ (Optionnel) Un environnement Python pour le worker

**🎉 Félicitations ! Vous êtes prêt à développer SpeechFlow !**

---

**Créé avec :** Context7 MCP
**Date :** 2026-01-30
**Version :** 1.0
