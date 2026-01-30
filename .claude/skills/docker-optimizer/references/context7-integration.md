# Intégration MCP Context7 - Guide de Référence

## Vue d'Ensemble

Le skill docker-optimizer utilise **obligatoirement** le MCP Context7 pour consulter la documentation officielle des technologies avant de générer toute configuration Docker.

Cette intégration garantit que les configurations générées sont basées sur les **best practices actuelles** et **validées par les mainteneurs officiels** des technologies utilisées.

---

## Pourquoi Context7 ?

### Problèmes Résolus

❌ **Sans Context7** :
- Configurations basées sur des connaissances potentiellement obsolètes
- Risque d'utiliser des anti-patterns
- Commandes et flags dépassés
- Optimisations non alignées avec les recommendations officielles

✅ **Avec Context7** :
- Documentation officielle toujours à jour (2026)
- Best practices validées par les équipes de développement
- Commandes et configurations recommandées actuelles
- Optimisations spécifiques à chaque technologie

### Avantages Concrets

1. **Fiabilité** - Configurations basées sur la documentation officielle
2. **Actualité** - Documentation à jour en temps réel
3. **Optimisation** - Best practices spécifiques à chaque technologie
4. **Sécurité** - Pratiques de sécurité recommandées par les mainteneurs
5. **Performance** - Optimisations validées et testées

---

## Workflow d'Utilisation

### Processus Obligatoire

```
┌─────────────────────────────────────────────────────────┐
│ 1. DÉTECTION DES TECHNOLOGIES                           │
│    - Scan du projet ou analyse des spécifications       │
│    - Identification de la stack complète                │
└────────────────────┬────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────────┐
│ 2. CONSULTATION CONTEXT7 (OBLIGATOIRE)                  │
│    Pour CHAQUE technologie majeure détectée :           │
│    → Consulter la documentation officielle              │
│    → Extraire les best practices Docker                 │
│    → Identifier les optimisations recommandées          │
└────────────────────┬────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────────┐
│ 3. GÉNÉRATION BASÉE SUR LA DOCUMENTATION                │
│    - Appliquer les recommendations officielles          │
│    - Utiliser les commandes validées                    │
│    - Implémenter les optimisations spécifiques          │
└────────────────────┬────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────────┐
│ 4. VALIDATION ET DOCUMENTATION                          │
│    - Justifier les choix avec les sources               │
│    - Documenter les optimisations appliquées            │
└─────────────────────────────────────────────────────────┘
```

---

## Technologies Supportées

### Frameworks Frontend

**Toujours consulter context7 pour** :

- **Next.js**
  - Standalone output mode
  - Configuration production
  - Variables d'environnement
  - Optimisations de build

- **Nuxt**
  - Nitro output
  - SSR/SSG configuration
  - Deployment best practices

- **Remix**
  - Server deployment
  - Adapter configuration

- **SvelteKit**
  - Node adapter
  - Production builds

- **Astro**
  - SSR configuration
  - Static generation

- **React, Vue, Svelte, Angular**
  - Build optimizations
  - Production configurations

### Frameworks Backend

**Toujours consulter context7 pour** :

- **FastAPI**
  - Uvicorn/Gunicorn configuration
  - Worker settings
  - Production deployment

- **Django**
  - WSGI/ASGI server setup
  - Static files handling
  - Database configuration

- **Flask**
  - Production server (Gunicorn)
  - Environment configuration

- **Express / NestJS**
  - Production settings
  - Cluster mode
  - PM2 configuration

### Runtimes

**Toujours consulter context7 pour** :

- **Node.js**
  - Version LTS recommandée
  - Production flags
  - Memory settings

- **Bun**
  - Runtime optimizations
  - Production configuration

- **Deno**
  - Permissions setup
  - Deployment configuration

- **Python**
  - Version recommandée
  - PYTHONOPTIMIZE settings
  - Virtual environment

### Bases de Données

**Toujours consulter context7 pour** :

- **PostgreSQL**
  - Docker image (alpine vs standard)
  - Configuration parameters
  - Volume management
  - Backup strategies

- **MongoDB**
  - Replica set configuration
  - Authentication setup

- **Redis**
  - Persistence configuration
  - Memory settings
  - Eviction policies

- **MySQL / MariaDB**
  - Configuration optimization
  - Character set setup

### Outils et Build Systems

**Toujours consulter context7 pour** :

- **Turborepo**
  - Docker build optimization
  - Remote caching
  - Selective building

- **Nx**
  - Monorepo Docker setup
  - Affected builds

- **Vite**
  - Build configuration
  - Production optimizations

- **Docker / Docker Compose**
  - Latest features
  - Best practices
  - Security recommendations

---

## Exemples de Requêtes Context7

### Projet Full-Stack Next.js + FastAPI

**Technologies détectées** : Next.js, FastAPI, PostgreSQL, Redis

**Requêtes context7 obligatoires** :

```
1. Context7 : "Next.js Docker deployment production best practices standalone output"
   → Extraire : commandes de build, configuration ENV, optimisations

2. Context7 : "FastAPI Docker production deployment Uvicorn Gunicorn workers"
   → Extraire : configuration serveur, workers, health checks

3. Context7 : "PostgreSQL Docker alpine configuration best practices"
   → Extraire : paramètres de configuration, volumes, backup

4. Context7 : "Redis Docker configuration persistence memory optimization"
   → Extraire : configuration Redis, persistence, eviction
```

### Monorepo Turborepo

**Technologies détectées** : Turborepo, pnpm, Next.js, Node.js

**Requêtes context7 obligatoires** :

```
1. Context7 : "Turborepo Docker build monorepo optimization remote cache"
   → Extraire : stratégie de build, caching, workspaces

2. Context7 : "pnpm Docker monorepo workspace install optimization"
   → Extraire : commandes d'installation, cache strategy

3. Context7 : "Next.js Docker monorepo turborepo build optimization"
   → Extraire : configuration spécifique monorepo

4. Context7 : "Node.js Docker production optimization environment variables"
   → Extraire : flags de production, memory settings
```

### API Python FastAPI

**Technologies détectées** : FastAPI, Python, PostgreSQL, Celery, Redis

**Requêtes context7 obligatoires** :

```
1. Context7 : "FastAPI Docker production deployment best practices 2026"
   → Extraire : serveur ASGI, workers, configuration

2. Context7 : "Python Docker slim alpine distroless production optimization"
   → Extraire : choix d'image de base, optimisations

3. Context7 : "PostgreSQL Docker configuration connection pooling"
   → Extraire : configuration DB, pooling

4. Context7 : "Celery Docker worker configuration Redis broker"
   → Extraire : configuration workers, concurrency

5. Context7 : "Redis Docker broker configuration Celery backend"
   → Extraire : configuration Redis pour Celery
```

---

## Format des Requêtes

### Structure Recommandée

```
Context7 : "[Technologie] [Contexte] [Besoins spécifiques] [Keywords]"
```

**Exemples** :

```
✅ Bon :
"Next.js Docker production deployment standalone output optimization"
→ Précis, contextualisé, keywords pertinents

❌ Moins bon :
"Next.js Docker"
→ Trop vague, manque de contexte

✅ Bon :
"FastAPI Docker Uvicorn workers production configuration health checks"
→ Détaillé, contexte production, besoins spécifiques

❌ Moins bon :
"FastAPI container"
→ Imprécis, manque de détails
```

### Keywords Utiles

**Général** :
- `production`, `deployment`, `best practices`, `optimization`
- `configuration`, `setup`, `recommendations`
- `2026`, `latest`, `current`

**Docker spécifique** :
- `Dockerfile`, `docker-compose`, `multi-stage`
- `alpine`, `distroless`, `slim`
- `build optimization`, `cache`, `layers`

**Performance** :
- `workers`, `threads`, `concurrency`
- `memory`, `cpu`, `resources`
- `scaling`, `cluster`

**Sécurité** :
- `security`, `hardening`, `non-root`
- `secrets`, `environment variables`
- `permissions`, `isolation`

---

## Extraction des Informations

### Que Chercher dans la Documentation

Lors de la consultation de context7, extraire spécifiquement :

#### 1. Configuration de Base
- Image Docker recommandée (alpine, slim, distroless)
- Version spécifique du runtime/framework
- Commandes de build officielles

#### 2. Optimisations
- Flags de compilation optimaux
- Variables d'environnement de production
- Configuration de performance

#### 3. Commandes
- Commande de build recommandée
- Commande de démarrage en production
- Scripts d'initialisation

#### 4. Sécurité
- Utilisateurs non-root
- Permissions requises
- Secrets management

#### 5. Dépendances
- Package manager recommandé
- Dépendances de production vs développement
- Lock files

#### 6. Monitoring
- Health checks recommandés
- Logging configuration
- Metrics endpoints

---

## Exemple Complet : Génération Next.js

### Étape 1 : Consultation Context7

**Requête** :
```
Context7 : "Next.js 15 Docker production deployment standalone output optimization alpine"
```

**Informations extraites** :
```yaml
Image de base: node:22-alpine
Build command: pnpm build
Output: standalone (next.config.js : output: 'standalone')
ENV variables:
  - NEXT_TELEMETRY_DISABLED=1
  - NODE_ENV=production
Port: 3000
Startup: node server.js (dans .next/standalone)
Optimizations:
  - Multi-stage build
  - Cache pnpm avec mount
  - Copier seulement .next/standalone + static + public
```

### Étape 2 : Application dans le Dockerfile

```dockerfile
# Basé sur la documentation Next.js officielle via context7
# syntax=docker/dockerfile:1.7
FROM node:22-alpine AS base

# Stage 1: Dependencies
FROM base AS deps
WORKDIR /app

# Enable corepack for pnpm (recommandation officielle)
RUN corepack enable && corepack prepare pnpm@latest --activate

# Install dependencies (avec cache mount - best practice)
COPY package.json pnpm-lock.yaml ./
RUN --mount=type=cache,id=pnpm,target=/root/.local/share/pnpm/store \
    pnpm install --frozen-lockfile

# Stage 2: Builder
FROM base AS builder
WORKDIR /app

RUN corepack enable && corepack prepare pnpm@latest --activate

COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Build avec standalone output (recommandation Next.js)
ENV NEXT_TELEMETRY_DISABLED=1
RUN pnpm build

# Stage 3: Runner (Production)
FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

# Non-root user (best practice Docker)
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001 -G nodejs

# Copier seulement ce qui est nécessaire (standalone pattern)
COPY --from=builder --chown=nextjs:nodejs /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs

EXPOSE 3000

ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

# Health check (recommandé pour production)
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/api/health', (r) => {if (r.statusCode !== 200) throw new Error()})"

# Commande de démarrage (standalone server)
CMD ["node", "server.js"]
```

**Justification documentée** :
```
✅ Image node:22-alpine - Documentation Next.js (compatible, léger)
✅ Standalone output - Recommandation officielle Next.js pour Docker
✅ pnpm avec cache mount - Best practice pour performance
✅ Multi-stage build - Optimisation Docker standard
✅ Non-root user - Sécurité Docker
✅ NEXT_TELEMETRY_DISABLED - Recommandation production
✅ Health check - Best practice monitoring

Taille estimée : ~180MB (vs ~500MB sans optimizations)
Source : Documentation Next.js via context7
```

---

## Règles Absolues

### ❗ Règle 1 : Consultation Obligatoire

**JAMAIS** générer de configuration Docker sans consulter context7 pour les technologies principales du projet.

**Minimum requis** :
- Runtime principal (Node.js, Python, etc.)
- Framework principal (Next.js, FastAPI, etc.)
- Base de données principale (PostgreSQL, etc.)

### ❗ Règle 2 : Documentation Prioritaire

En cas de conflit entre plusieurs sources :
1. **Documentation officielle via context7** (PRIORITÉ ABSOLUE)
2. Fichiers de référence du skill
3. Connaissances générales

### ❗ Règle 3 : Justification Requise

Chaque choix technique DOIT être justifié avec :
- Source de l'information (context7)
- Raison du choix
- Alternatives considérées

---

## Checklist de Validation

Avant de générer une configuration finale, vérifier :

- [ ] Context7 consulté pour toutes les technologies principales
- [ ] Best practices officielles extraites et documentées
- [ ] Commandes validées avec la documentation
- [ ] Variables ENV conformes aux recommendations
- [ ] Optimisations spécifiques à la technologie appliquées
- [ ] Justifications documentées pour les choix majeurs
- [ ] Alternatives considérées et écartées avec raison

---

## Troubleshooting

### Problème : Context7 ne retourne pas d'information

**Solution** :
1. Reformuler la requête avec plus de contexte
2. Essayer des keywords alternatifs
3. Chercher la documentation générale puis affiner
4. Utiliser les fichiers de référence du skill comme fallback

### Problème : Informations contradictoires

**Solution** :
1. Prioriser context7 (documentation officielle)
2. Vérifier la date de la documentation
3. Considérer le contexte spécifique du projet
4. Documenter la décision et la justification

### Problème : Technologie non documentée dans context7

**Solution** :
1. Chercher la documentation de technologies similaires
2. Utiliser les références du skill
3. Appliquer les best practices générales Docker
4. Documenter l'absence de documentation spécifique

---

## Ressources Complémentaires

### Fichiers de Référence du Skill

En complément de context7, consulter :

- `references/dockerfile-patterns.md` - Patterns généraux par langage
- `references/modern-frameworks.md` - Frameworks JavaScript modernes
- `references/docker-security.md` - Sécurité Docker
- `references/compose-advanced.md` - Docker Compose avancé
- `references/docker-docs.md` - Documentation Docker générale

### Ordre de Consultation

```
1. Context7 (documentation officielle) ← PRIORITÉ
2. Fichiers de référence du skill ← Complément
3. Connaissances générales ← Fallback
```

---

## Conclusion

L'intégration de MCP Context7 dans le docker-optimizer skill garantit que toutes les configurations générées sont basées sur les **best practices officielles les plus récentes**.

Cette approche assure :
- ✅ Fiabilité et actualité des configurations
- ✅ Optimisations validées par les mainteneurs
- ✅ Sécurité alignée avec les recommandations officielles
- ✅ Performance optimale selon les technologies utilisées

**Règle d'or** : Toujours consulter context7 avant de générer une configuration Docker !
