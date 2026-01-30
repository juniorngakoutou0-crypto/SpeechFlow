# SpeechFlow 🚀

**SaaS de documentation intelligente automatisée**

Transformez vos fichiers Audio/Vidéo en documents PDF structurés et pérennes avec transcription + résumé IA cumulatif.

## 🔥 Fonctionnalités Clés

- **Traitement 100% Local** - Aucun cloud obligatoire
- **Base de connaissance cumulative** - Photos PDF avec nouvelle source
- **Traitement automatique** - Upload → Transcription → Résumé IA → PDF
- **Architecture microservices** - Node.js/TypeScript + Python
- **Stockage sécurisé** - MinIO (compatible S3)

## 🏗️ Architecture

```
Frontend (Next.js) → API (NestJS) → Worker (Python) → Stockage (MinIO)
                      ↓
                Base (PostgreSQL)     File d'attente (Redis)
```**

## 🚀 Démarrage Rapide

### Prérequis
- Docker Desktop
- Node.js 20+
- Python 3.11+
- 8GB RAM minimum

### Installation
```bash
git clone <repo-url>
cd speechflow
cp .env.example .env
# Éditer .env avec vos clés API
npm run dev
```

- **App:** http://localhost:3000

### 📖 Documents Détaillés
- [PRD - Spécifications](PRD.md)
- [Architecture Technique](architecture.md)

## 📝 Licence

MIT License

## 🆘 Support

- Issues: [GitHub Issues](https://github.com/juniorngakoutou0-crypto/SpeechFlow/issues)
