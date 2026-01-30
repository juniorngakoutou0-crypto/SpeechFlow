# SpeechFlow API

API Gateway NestJS pour SpeechFlow - Gestion de l'authentification, des dossiers et des PDFs.

## Prérequis

- Node.js 18+
- PostgreSQL (via Docker Compose)
- npm ou yarn

## Installation

```bash
# Installer les dépendances
npm install

# Générer le client Prisma
npm run prisma:generate

# Démarrer les services Docker (PostgreSQL, Redis, MinIO)
docker-compose -f ../../docker-compose.dev.yml up -d

# Exécuter les migrations
npm run prisma:migrate

# Démarrer l'API en mode développement
npm run start:dev
```

## Variables d'Environnement

Copier `.env.example` vers `.env` et configurer :

```env
DATABASE_URL="postgresql://speechflow:password@localhost:5432/speechflow"
JWT_SECRET="your-super-secret-jwt-key-min-32-characters"
JWT_EXPIRATION="7d"
PORT=4000
```

## API Endpoints

### Authentification

- `POST /api/auth/register` - Inscription d'un nouvel utilisateur
- `POST /api/auth/login` - Connexion
- `GET /api/auth/me` - Obtenir l'utilisateur courant (protégé)

## Scripts Disponibles

- `npm run start` - Démarrer en mode production
- `npm run start:dev` - Démarrer en mode développement (watch)
- `npm run build` - Compiler le projet
- `npm run test` - Exécuter les tests
- `npm run prisma:studio` - Ouvrir Prisma Studio
- `npm run prisma:migrate` - Créer/appliquer les migrations

## Structure du Projet

```
src/
├── auth/              # Module d'authentification
│   ├── dto/          # Data Transfer Objects
│   ├── guards/       # Guards JWT
│   └── strategies/   # Stratégies Passport
├── prisma/           # Service Prisma
└── main.ts           # Point d'entrée de l'application
```

## Tests

```bash
# Tests unitaires
npm run test

# Tests avec couverture
npm run test:cov

# Tests E2E
npm run test:e2e
```
