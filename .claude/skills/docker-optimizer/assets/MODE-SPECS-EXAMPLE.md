# Mode Génération depuis Spécifications - Exemple Complet

## Scénario

Vous avez deux fichiers qui décrivent votre projet :
- `bl.md` - Votre plan/backlog du projet
- `architecture.md` - L'architecture technique détaillée

Vous voulez générer toute l'architecture Docker sans avoir encore écrit le code.

## Étape 1 : Préparation

Assurez-vous d'avoir vos fichiers de spécifications prêts :

```
my-project/
├── docs/
│   ├── bl.md              # Plan du projet
│   └── architecture.md    # Architecture technique
└── (code à venir)
```

## Étape 2 : Invocation du Skill

### Option 1 : Simple

```
Générer architecture Docker depuis mes fichiers bl.md et architecture.md
```

### Option 2 : Détaillée

```
Je veux créer un fichier Architecture-docker.md basé sur :
- Plan du projet : docs/bl.md
- Architecture : docs/architecture.md

Analyse ces fichiers et génère l'architecture Docker complète optimisée.
```

### Option 3 : Avec préférences

```
Utilise mes fichiers docs/bl.md et docs/architecture.md pour générer
l'architecture Docker. Priorités : performance et taille minimale.
Environnements : dev et production.
```

## Étape 3 : Ce qui se Passe

### Phase 1 : Analyse des Fichiers

Claude va :
1. Lire vos fichiers `bl.md` et `architecture.md`
2. Extraire automatiquement :
   - Les technologies mentionnées (Next.js, FastAPI, PostgreSQL, etc.)
   - L'architecture globale (monolithe, microservices, etc.)
   - Les services et composants
   - Les besoins de performance, sécurité, etc.

### Phase 2 : Profil du Projet

Claude crée un profil basé sur vos specs :
```json
{
  "project_name": "Mon Application",
  "type": "fullstack",
  "stack": {
    "frontend": ["Next.js 15", "React"],
    "backend": ["Python", "FastAPI"],
    "databases": ["PostgreSQL", "Redis"],
    "services": ["Celery", "RabbitMQ"]
  },
  "architecture": "microservices",
  "environments": ["development", "production"]
}
```

### Phase 3 : Génération

Claude génère le fichier `Architecture-docker.md` avec :
- Vue d'ensemble complète
- Organisation des fichiers
- **Tous les Dockerfiles** (frontend, backend, workers, etc.)
- **Tous les .dockerignore**
- **docker-compose.yml** (dev)
- **docker-compose.prod.yml** (production)
- Configuration des variables ENV
- Instructions de déploiement
- Métriques estimées

## Étape 4 : Résultat

Vous obtenez un fichier `Architecture-docker.md` complet :

```markdown
# Architecture Docker - Mon Application

## 📋 Vue d'Ensemble

### Description du Projet
Application full-stack de gestion de tâches avec API REST,
interface React, background jobs et cache Redis.

### Stack Technologique
- **Frontend** : Next.js 15, React 19, TypeScript
- **Backend** : Python 3.13, FastAPI, SQLAlchemy
- **Bases de Données** : PostgreSQL 16, Redis 7
- **Services** : Celery, RabbitMQ
- **Build Tools** : pnpm, Docker BuildKit

### Architecture Choisie
Microservices avec orchestration Docker Compose

---

## 🏗️ Organisation des Fichiers

```
my-project/
├── services/
│   ├── frontend/
│   │   ├── Dockerfile
│   │   ├── .dockerignore
│   │   └── ... (code Next.js)
│   ├── backend/
│   │   ├── Dockerfile
│   │   ├── .dockerignore
│   │   └── ... (code FastAPI)
│   └── worker/
│       ├── Dockerfile
│       └── ... (Celery workers)
├── docker-compose.yml
├── docker-compose.prod.yml
├── .env.example
└── scripts/
    └── docker-utils.sh
```

---

## 🐳 Dockerfiles

### Frontend - Dockerfile

**Chemin** : `services/frontend/Dockerfile`

```dockerfile
# Multi-stage build optimisé pour Next.js
FROM node:22-alpine AS deps
WORKDIR /app

# Activer corepack pour pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Installer les dépendances avec cache
COPY package.json pnpm-lock.yaml ./
RUN --mount=type=cache,id=pnpm,target=/root/.local/share/pnpm/store \
    pnpm install --frozen-lockfile

# Builder stage
FROM node:22-alpine AS builder
WORKDIR /app

RUN corepack enable && corepack prepare pnpm@latest --activate

COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Build avec standalone output
ENV NEXT_TELEMETRY_DISABLED=1
RUN pnpm build

# Runtime stage
FROM node:22-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

# Créer utilisateur non-root
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001 -G nodejs

# Copier seulement ce qui est nécessaire
COPY --from=builder --chown=nextjs:nodejs /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs

EXPOSE 3000

ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/api/health', (r) => {if (r.statusCode !== 200) throw new Error()})"

CMD ["node", "server.js"]
```

**Optimisations appliquées** :
- ✅ Multi-stage build (3 stages : deps, builder, runner)
- ✅ Image de base : node:22-alpine (~200MB)
- ✅ Cache mounts pour pnpm
- ✅ Next.js standalone output
- ✅ Utilisateur non-root (nextjs)
- ✅ Health check intégré
- ✅ Production dependencies uniquement

**Taille estimée** : 180 MB
**Build time estimé** : 45s (premier build), 10s (avec cache)

---

### Backend - Dockerfile

**Chemin** : `services/backend/Dockerfile`

```dockerfile
# Multi-stage build optimisé pour FastAPI
FROM python:3.13-slim AS builder
WORKDIR /app

# Installer Poetry
RUN pip install --no-cache-dir poetry

# Configurer Poetry pour ne pas créer de venv
ENV POETRY_VIRTUALENVS_CREATE=false

# Copier fichiers de dépendances
COPY pyproject.toml poetry.lock ./

# Installer dépendances avec cache
RUN --mount=type=cache,target=/root/.cache/pypoetry \
    poetry install --no-dev --no-root

# Copier le code source
COPY . .

# Runtime stage
FROM python:3.13-slim
WORKDIR /app

# Variables d'environnement optimales
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONOPTIMIZE=2

# Créer utilisateur non-root
RUN groupadd -r appuser && \
    useradd -r -g appuser -u 1001 appuser

# Copier les dépendances et le code
COPY --from=builder /usr/local/lib/python3.13/site-packages /usr/local/lib/python3.13/site-packages
COPY --from=builder --chown=appuser:appuser /app /app

USER appuser

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health').read()"

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "4"]
```

**Optimisations appliquées** :
- ✅ Multi-stage build (2 stages)
- ✅ Image de base : python:3.13-slim (~150MB)
- ✅ Cache mounts pour Poetry
- ✅ Utilisateur non-root (appuser)
- ✅ Health check intégré
- ✅ Optimisations Python (PYTHONOPTIMIZE=2)

**Taille estimée** : 220 MB
**Build time estimé** : 60s (premier build), 15s (avec cache)

---

{... et ainsi de suite pour chaque service}

---

## 🎼 Docker Compose

### Development - docker-compose.yml

```yaml
version: '3.9'

services:
  frontend:
    build:
      context: ./services/frontend
      dockerfile: Dockerfile
      target: runner
    container_name: app-frontend
    ports:
      - "3000:3000"
    environment:
      - NEXT_PUBLIC_API_URL=http://backend:8000
    volumes:
      - ./services/frontend:/app
      - /app/node_modules
      - /app/.next
    depends_on:
      backend:
        condition: service_healthy
    networks:
      - app-network
    restart: unless-stopped

  backend:
    build:
      context: ./services/backend
      dockerfile: Dockerfile
    container_name: app-backend
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=postgresql://postgres:password@db:5432/appdb
      - REDIS_URL=redis://redis:6379/0
      - RABBITMQ_URL=amqp://guest:guest@rabbitmq:5672/
    volumes:
      - ./services/backend:/app
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_started
      rabbitmq:
        condition: service_healthy
    networks:
      - app-network
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "python", "-c", "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')"]
      interval: 30s
      timeout: 10s
      retries: 3

  worker:
    build:
      context: ./services/worker
      dockerfile: Dockerfile
    container_name: app-worker
    environment:
      - DATABASE_URL=postgresql://postgres:password@db:5432/appdb
      - REDIS_URL=redis://redis:6379/0
      - RABBITMQ_URL=amqp://guest:guest@rabbitmq:5672/
    depends_on:
      - backend
      - rabbitmq
    networks:
      - app-network
    restart: unless-stopped

  db:
    image: postgres:16-alpine
    container_name: app-db
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=appdb
    volumes:
      - postgres-data:/var/lib/postgresql/data
      - ./services/database/init.sql:/docker-entrypoint-initdb.d/init.sql
    ports:
      - "5432:5432"
    networks:
      - app-network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    container_name: app-redis
    command: redis-server --appendonly yes
    volumes:
      - redis-data:/data
    ports:
      - "6379:6379"
    networks:
      - app-network

  rabbitmq:
    image: rabbitmq:3-management-alpine
    container_name: app-rabbitmq
    environment:
      - RABBITMQ_DEFAULT_USER=guest
      - RABBITMQ_DEFAULT_PASS=guest
    volumes:
      - rabbitmq-data:/var/lib/rabbitmq
    ports:
      - "5672:5672"
      - "15672:15672"
    networks:
      - app-network
    healthcheck:
      test: ["CMD", "rabbitmq-diagnostics", "ping"]
      interval: 30s
      timeout: 10s
      retries: 5

networks:
  app-network:
    driver: bridge

volumes:
  postgres-data:
  redis-data:
  rabbitmq-data:
```

---

{... suite avec docker-compose.prod.yml, configuration, etc.}

---

## 📊 Métriques et Estimations

### Taille des Images

| Service | Taille Estimée | Optimisation |
|---------|---------------|--------------|
| Frontend (Next.js) | 180 MB | -65% vs standard |
| Backend (FastAPI) | 220 MB | -55% vs standard |
| Worker (Celery) | 200 MB | -60% vs standard |
| PostgreSQL | 50 MB | alpine |
| Redis | 30 MB | alpine |
| RabbitMQ | 80 MB | alpine |

**Total** : ~760 MB (-62% vs 2GB baseline)

---

{... reste du document}
```

## Étape 5 : Utilisation

Une fois le fichier `Architecture-docker.md` généré :

1. **Réviser l'architecture** - Vérifiez que tout correspond à vos besoins
2. **Créer les fichiers** - Utilisez le document comme guide pour créer les Dockerfiles
3. **Adapter si nécessaire** - Modifiez selon vos besoins spécifiques
4. **Implémenter** - Suivez les instructions de déploiement

## Avantages

✅ **Pas besoin de code existant** - Parfait pour la phase de planification
✅ **Vision complète** - Toute l'architecture Docker en un seul document
✅ **Optimisé dès le départ** - Best practices appliquées automatiquement
✅ **Prêt pour l'implémentation** - Guide détaillé pour créer les fichiers
✅ **Flexible** - Facile à adapter selon l'évolution du projet

## Questions Fréquentes

### Q: Que faire si mes fichiers ne contiennent pas toutes les infos ?

Claude analysera ce qui est disponible et fera des choix raisonnables basés sur les best practices. Il signalera les informations manquantes et fera des recommandations.

### Q: Puis-je modifier l'architecture après génération ?

Absolument ! Le fichier `Architecture-docker.md` est un guide, pas une obligation. Modifiez selon vos besoins.

### Q: Le skill peut analyser quels types de fichiers ?

Tout fichier texte/markdown contenant des spécifications : plan, architecture, README, documentation technique, etc.

### Q: Et si mon projet évolue ?

Relancez le skill avec vos fichiers mis à jour pour régénérer l'architecture Docker adaptée.
