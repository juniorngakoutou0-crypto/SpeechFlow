# SpeechFlow 🚀

**SaaS de documentation intelligente automatisée**

Transformez vos fichiers Audio/Vidéo en documents PDF structurés et pérennes avec transcription + résumé IA cumulatif.

## 📊 Statut du Projet

| Composant | Statut | Version | URL |
|-----------|--------|---------|-----|
| **Backend API** | ✅ Opérationnel | v1.0.0 | http://localhost:4000/api |
| **PostgreSQL** | ✅ Opérationnel | 16-alpine | localhost:5432 |
| **Redis** | ✅ Opérationnel | 7-alpine | localhost:6379 |
| **MinIO** | ✅ Opérationnel | latest | localhost:9000-9001 |
| **Frontend** | 🚧 À installer | - | http://localhost:3000 |
| **Worker** | 🚧 À créer | - | - |

**Dernière mise à jour :** 2026-01-30
**Tests :** ✅ Authentification JWT validée

## 🔥 Fonctionnalités Clés

- **Traitement 100% Local** - Aucun cloud obligatoire
- **Base de connaissance cumulative** - Enrichissement PDF avec nouvelles sources
- **Traitement automatique** - Upload → Transcription → Résumé IA → PDF
- **Architecture microservices** - Node.js/TypeScript + Python
- **Stockage sécurisé** - MinIO (compatible S3)

## 🏗️ Architecture

```
Frontend (Next.js) → API (NestJS) → Worker (Python) → Stockage (MinIO)
                      ↓
                Base (PostgreSQL)     File d'attente (Redis)
```**

## ✅ Fonctionnalités Implémentées

### Backend API (NestJS)
- ✅ **Authentification JWT** - Inscription, connexion, routes protégées
- ✅ **Base de données Prisma** - Models User, Folder, PDF
- ✅ **Validation des données** - class-validator + class-transformer
- ✅ **Sécurité** - bcrypt pour les mots de passe, JWT Guards
- ✅ **CORS configuré** - Prêt pour le frontend

### Infrastructure
- ✅ **PostgreSQL** - Base de données relationnelle
- ✅ **Redis** - Queue et cache (prêt pour BullMQ)
- ✅ **MinIO** - Stockage S3-compatible pour les fichiers

### Documentation
- ✅ **Guides d'installation** - Scripts PowerShell automatisés
- ✅ **Documentation Context7** - Meilleures pratiques officielles
- ✅ **Quick Start** - Démarrage en moins de 10 minutes

## 🚀 Démarrage Rapide

### Prérequis
- ✅ Docker Desktop (installé)
- ✅ Node.js 18+ (v24.13.0 installé)
- ✅ npm (installé)
- 🔄 Python 3.10+ (pour le worker plus tard)
- 💻 8GB RAM minimum

### Installation en 3 Étapes

#### 1. Installer les dépendances
```powershell
cd apps\api
npm install
npm rebuild bcrypt
```

#### 2. Démarrer l'infrastructure et créer la base
```powershell
# Retour à la racine
cd ..\..

# Démarrer Docker
docker-compose -f docker-compose.dev.yml up -d

# Créer les migrations
cd apps\api
npm run prisma:generate
npm run prisma:migrate
```

#### 3. Démarrer l'API
```powershell
npm run start:dev
```

**✅ API opérationnelle sur:** http://localhost:4000/api

### 🧪 Tester l'Installation

Dans un nouveau terminal PowerShell :

```powershell
# Test d'inscription
Invoke-RestMethod -Method Post -Uri "http://localhost:4000/api/auth/register" `
  -Headers @{"Content-Type"="application/json"} `
  -Body '{"name":"Test User","email":"test@example.com","password":"password123"}'

# Test de connexion
Invoke-RestMethod -Method Post -Uri "http://localhost:4000/api/auth/login" `
  -Headers @{"Content-Type"="application/json"} `
  -Body '{"email":"test@example.com","password":"password123"}'
```

### 📦 Installer Frontend & Worker (Optionnel)

```powershell
# Retour à la racine
cd ..\..

# Exécuter le script d'installation
.\setup-frontend-worker.ps1
```

**Frontend:** http://localhost:3000 (après `cd apps\frontend && npm run dev`)

## 🔌 Endpoints API Disponibles

### Authentification
| Endpoint | Méthode | Description | Auth |
|----------|---------|-------------|------|
| `/api/auth/register` | POST | Inscription utilisateur | Non |
| `/api/auth/login` | POST | Connexion | Non |
| `/api/auth/me` | GET | Profil utilisateur | JWT ✅ |

### À Venir
- `/api/folders` - Gestion des dossiers
- `/api/pdfs` - Gestion des PDFs
- `/api/upload` - Upload de fichiers

## 🔧 Services & Outils

### Services Actifs
```bash
docker-compose -f docker-compose.dev.yml ps
```

| Service | URL | Identifiants |
|---------|-----|--------------|
| **API Backend** | http://localhost:4000/api | - |
| **PostgreSQL** | localhost:5432 | speechflow / password |
| **Redis** | localhost:6379 | - |
| **MinIO Console** | http://localhost:9001 | admin / adminpassword |
| **Prisma Studio** | `npm run prisma:studio` | - |

### Commandes Utiles

```powershell
# Voir les logs de l'API
cd apps\api
npm run start:dev

# Voir la base de données
npm run prisma:studio

# Logs Docker
docker-compose -f docker-compose.dev.yml logs -f

# Arrêter les services
docker-compose -f docker-compose.dev.yml down
```

## 📖 Documentation Complète

### 🚀 Démarrage
- [QUICK_START.md](QUICK_START.md) - ⚡ Démarrage en 5 étapes (< 10 min)
- [CHANGEMENTS.md](CHANGEMENTS.md) - 📝 Liste des modifications récentes

### 🔧 Installation & Configuration
- [RESOLUTION_COMPLETE.md](RESOLUTION_COMPLETE.md) - ✅ Guide de résolution des dépendances
- [DEPENDANCES_RESOLUTION.md](DEPENDANCES_RESOLUTION.md) - 📦 Versions compatibles (Context7)
- [INSTALLATION.md](INSTALLATION.md) - 📥 Installation détaillée
- [SETUP.md](SETUP.md) - ⚙️ Setup général

### 📋 Architecture & Spécifications
- [PRD.md](PRD.md) - 📄 Product Requirements Document
- [architecture.md](architecture.md) - 🏗️ Architecture technique
- [CLAUDE.md](CLAUDE.md) - 🤖 Instructions pour Claude AI

## 🛠️ Stack Technique

### Backend
- **Framework:** NestJS 10
- **Language:** TypeScript 5
- **ORM:** Prisma 5
- **Auth:** JWT + bcrypt
- **Validation:** class-validator + class-transformer

### Infrastructure
- **Database:** PostgreSQL 16
- **Cache/Queue:** Redis 7
- **Storage:** MinIO (S3-compatible)
- **Container:** Docker Compose

### Frontend (À installer)
- **Framework:** Next.js 15
- **Language:** TypeScript
- **Styling:** Tailwind CSS 3
- **State:** Zustand 5
- **Components:** shadcn/ui

### Worker (À créer)
- **Language:** Python 3.10+
- **Transcription:** Faster-Whisper
- **IA:** OpenRouter API
- **PDF:** ReportLab

## 🐛 Résolution des Problèmes

### Erreur : "Cannot find module 'bcrypt'"
```powershell
cd apps\api
npm rebuild bcrypt
```

### Erreur : "connect ECONNREFUSED 127.0.0.1:5432"
```powershell
docker-compose -f docker-compose.dev.yml restart postgres
docker-compose -f docker-compose.dev.yml logs postgres
```

### Erreur : Port 4000 déjà utilisé
Modifiez `apps/api/.env` :
```env
PORT=4001
```

### Plus de solutions
Consultez [RESOLUTION_COMPLETE.md](RESOLUTION_COMPLETE.md) pour plus de détails.

## 🎯 Roadmap

### Phase 1 : Backend ✅ (Complétée)
- [x] Configuration Prisma
- [x] Authentification JWT
- [x] Infrastructure Docker
- [x] Documentation complète

### Phase 2 : Frontend (En cours)
- [ ] Pages d'authentification
- [ ] Dashboard utilisateur
- [ ] Upload de fichiers
- [ ] Gestion des dossiers

### Phase 3 : Worker (À venir)
- [ ] Service de transcription
- [ ] Service de résumé IA
- [ ] Génération de PDF
- [ ] Queue de traitement

### Phase 4 : Intégration (À venir)
- [ ] WebSocket temps réel
- [ ] Notifications email
- [ ] Tests E2E Playwright
- [ ] CI/CD

## 👥 Contribution

Les contributions sont les bienvenues ! Pour contribuer :

1. Fork le projet
2. Créez une branche (`git checkout -b feature/AmazingFeature`)
3. Committez vos changements (`git commit -m 'Add AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

## 📝 Licence

MIT License - voir le fichier [LICENSE](LICENSE) pour plus de détails.

## 🆘 Support

- **Documentation :** Consultez les fichiers `.md` à la racine
- **Issues :** [GitHub Issues](https://github.com/juniorngakoutou0-crypto/SpeechFlow/issues)
- **Quick Start :** [QUICK_START.md](QUICK_START.md)

## 🙏 Remerciements

- **Context7** - Documentation officielle et meilleures pratiques
- **NestJS** - Framework backend robuste
- **Prisma** - ORM TypeScript moderne
- **Next.js** - Framework React performant

---

**Créé avec ❤️ par Junior**
**Dernière mise à jour :** 2026-01-30
**Version :** 1.0.0
