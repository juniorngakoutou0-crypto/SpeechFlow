---
name: docker-optimizer
description: |
  Analyse automatique et génération de configurations Docker optimisées pour les applications.
  Détecte la stack technologique, l'architecture et génère Dockerfiles multi-stage légers,
  docker-compose modulaires, et configurations sécurisées. Utilise les meilleures pratiques
  actuelles avec intégration de documentation standard et personnalisée.

  Utilisez cette skill pour : (1) Analyser une application et proposer une architecture
  Docker optimale, (2) Générer des Dockerfiles multi-stage avec images distroless/alpine,
  (3) Créer des docker-compose.yml pour microservices, (4) Appliquer les bonnes pratiques
  de sécurité (utilisateurs non-root, scans, secrets), (5) Minimiser la taille des images
  (< 100MB quand possible), (6) Intégrer les dernières documentations et normes Docker.
---

# Docker Optimizer

## 📚 IMPORTANT : Utilisation de la Documentation (MCP Context7)

**DIRECTIVE CRITIQUE** : Avant de générer toute configuration Docker, vous DEVEZ consulter la documentation officielle des technologies via le MCP context7 installé.

### Quand Consulter Context7

**TOUJOURS consulter context7 pour** :

1. **Technologies de base détectées** :
   - Next.js, Nuxt, Remix, SvelteKit, Astro
   - React, Vue, Svelte, Angular
   - Node.js, Bun, Deno
   - Python, FastAPI, Django, Flask
   - Go, Rust, Java
   - PostgreSQL, MongoDB, Redis
   - Docker, Docker Compose

2. **Frameworks et outils spécifiques** :
   - Turborepo, Nx, Lerna
   - Vite, Webpack, esbuild
   - pnpm, yarn, npm
   - Prisma, Drizzle
   - tRPC, GraphQL

3. **Best practices actuelles** :
   - Dockerfile optimizations pour chaque technologie
   - Configuration de production recommandée
   - Variables d'environnement spécifiques
   - Commandes de build et démarrage officielles

### Comment Utiliser Context7

```
Workflow obligatoire :
1. Détecter les technologies du projet
2. Pour CHAQUE technologie majeure :
   → Consulter context7 pour la documentation officielle
   → Extraire les best practices Docker
   → Vérifier les commandes recommandées
   → Identifier les optimisations spécifiques
3. Générer la configuration basée sur la documentation actuelle
```

### Exemples de Requêtes Context7

**Pour Next.js** :
```
Consulter context7 : Next.js deployment best practices, Dockerfile recommendations
```

**Pour FastAPI** :
```
Consulter context7 : FastAPI deployment, Docker configuration, production setup
```

**Pour PostgreSQL** :
```
Consulter context7 : PostgreSQL Docker best practices, alpine image, configuration
```

**Pour Turborepo** :
```
Consulter context7 : Turborepo Docker build, monorepo optimization, cache configuration
```

### Avantages de Context7

- ✅ Documentation officielle toujours à jour
- ✅ Best practices actuelles (2026)
- ✅ Optimisations spécifiques par technologie
- ✅ Commandes et configurations recommandées par les mainteneurs
- ✅ Évite les configurations obsolètes

### Règle Absolue

**JAMAIS** générer de configuration Docker sans avoir consulté context7 pour les technologies principales du projet. La documentation officielle prime sur toute autre source.

---

## Processus Global - Workflow Intelligent

Cette skill analyse votre projet en profondeur et génère une configuration Docker **ultra-optimisée et adaptée** à votre contexte spécifique :

### 🔍 Phase 1: Analyse Multi-niveau (Automatique)

**Scan Intelligent du Projet** :
   - 📦 Stack technologique complète (Node.js, Bun, Deno, Python, Go, etc.)
   - 🏗️ Architecture détectée (monolithe, full-stack, microservices, monorepo)
   - 📊 Profil du projet (taille, complexité, priorités)
   - 🔐 Analyse de sécurité (vulnérabilités, secrets hardcodés)
   - ⚡ Opportunités d'optimisation identifiées
   - 🎯 Frameworks modernes (Next.js, Nuxt, Remix, etc.)

**Détection Contextuelle** :
   - Monorepos (Turborepo, Nx, Lerna, pnpm workspaces)
   - Build tools (Vite, Webpack, esbuild, Turbopack)
   - Package managers (npm, pnpm, yarn, bun)
   - Bases de données requises
   - Services externes (Redis, RabbitMQ, etc.)

### 🎨 Phase 2: Génération d'Architecture Optimale

**Décisions Intelligentes Automatiques** :
   - Sélection d'images de base optimales (alpine/distroless/slim)
   - Stratégie multi-stage adaptée au projet
   - Cache mounts pour builds 50-70% plus rapides
   - Optimisations runtime (variables ENV, commandes)
   - Resource limits appropriés

**Architecture Adaptative** :
   - **Monolithe simple** → 1 Dockerfile optimisé (~150MB)
   - **Full-stack** → Services séparés avec orchestration (~300MB total)
   - **Microservices** → Dockerfiles par service avec base commune
   - **Monorepo** → Build sélectif avec cache partagé

### ⚙️ Phase 3: Optimisations Multi-couches

**Build Optimization** :
   - BuildKit avec cache mounts intelligents
   - Layer caching optimal (dépendances → code)
   - Build sélectif pour monorepos (seulement ce qui a changé)
   - Remote caching (Turborepo, Nx, etc.)

**Size Optimization** :
   - Multi-stage builds (élimine 40-70% de bloat)
   - Images minimalistes (alpine: ~50MB, distroless: ~30MB)
   - Production dependencies uniquement
   - Compression et strip des binaires

**Runtime Optimization** :
   - Variables ENV optimales par runtime
   - Worker/thread configuration intelligente
   - Memory management adaptatif
   - Health checks contextuels

### 🔒 Phase 4: Sécurité Intégrée

**Automatique** :
   - ✅ Utilisateurs non-root (TOUJOURS)
   - ✅ Permissions restrictives
   - ✅ Scan de vulnérabilités
   - ✅ Pas de secrets hardcodés
   - ✅ Health checks robustes
   - ✅ Read-only filesystem (quand possible)

**Avancé (optionnel)** :
   - SBOM generation (compliance)
   - Image signing avec Cosign
   - Security context (AppArmor/SELinux)
   - Network policies

### 📊 Phase 5: Validation et Benchmarking

**Métriques Automatiques** :
   - Taille finale estimée vs réelle
   - Build time (avec/sans cache)
   - Cache hit rate
   - Vulnérabilités détectées
   - Comparaison vs baseline

**Recommandations Intelligentes** :
   - Optimisations supplémentaires possibles
   - Trade-offs (taille vs compatibilité vs performance)
   - Prochaines étapes suggérées

## Flux de Travail Adaptatif

### Mode 0: Génération depuis Fichiers de Spécifications (NOUVEAU)

```
Générer architecture Docker depuis mes fichiers de spécifications
```

**Ce mode est IDÉAL pour générer l'architecture Docker depuis vos documents de projet existants** :

1. **Entrée - Fichiers de Spécifications** 📄
   - Fichier de plan du projet (backlog, roadmap, spécifications)
   - Fichier d'architecture technique
   - Tout autre document décrivant le projet

   Exemples de fichiers acceptés :
   - `plan.md`, `bl.md`, `backlog.md` - Plan détaillé du projet
   - `architecture.md`, `technical-specs.md` - Architecture technique
   - `requirements.md` - Besoins et fonctionnalités
   - Tout fichier markdown ou texte contenant les specs

2. **Analyse Intelligente des Documents** 🔍
   - Extraction automatique de la stack technologique mentionnée
   - Identification des services et composants décrits
   - Détection de l'architecture globale (monolithe/microservices)
   - Reconnaissance des bases de données et services tiers
   - Analyse des besoins de performance et sécurité

3. **Génération du Fichier Architecture-Docker.md** 📝

   **Structure complète générée** :
   ```markdown
   # Architecture Docker - [Nom du Projet]

   ## 📋 Vue d'Ensemble
   - Description du projet
   - Stack technologique complète
   - Architecture globale choisie

   ## 🏗️ Organisation des Fichiers
   ```
   project/
   ├── services/
   │   ├── frontend/
   │   │   ├── Dockerfile
   │   │   └── .dockerignore
   │   ├── backend/
   │   │   ├── Dockerfile
   │   │   └── .dockerignore
   │   └── database/
   │       └── init.sql
   ├── docker-compose.yml
   ├── docker-compose.prod.yml
   └── .env.example
   ```

   ## 🐳 Dockerfiles Détaillés
   ### Service Frontend
   ```dockerfile
   [Dockerfile complet optimisé]
   ```

   ### Service Backend
   ```dockerfile
   [Dockerfile complet optimisé]
   ```

   ## 🎼 Docker Compose
   ### Development
   ```yaml
   [docker-compose.yml complet]
   ```

   ### Production
   ```yaml
   [docker-compose.prod.yml complet]
   ```

   ## ⚙️ Configuration
   - Variables d'environnement
   - Secrets et credentials
   - Ports et networking

   ## 🚀 Déploiement
   - Instructions de build
   - Commandes de démarrage
   - Scripts utiles

   ## 📊 Métriques Estimées
   - Taille des images
   - Temps de build
   - Ressources requises
   ```

4. **Avantages de ce Mode** ✨
   - ✅ Pas besoin de code source existant
   - ✅ Parfait pour la phase de planification
   - ✅ Génère toute l'architecture Docker en un seul fichier
   - ✅ Prêt à être utilisé comme référence pour l'implémentation
   - ✅ Adapté aux spécifications techniques
   - ✅ Documentation complète et prête à l'emploi

5. **Utilisation** 💡
   ```
   Utiliser mon fichier bl.md et architecture.md pour générer l'architecture Docker
   ```

   Ou de manière plus détaillée :
   ```
   Je veux générer un fichier Architecture-docker.md basé sur :
   - Fichier de plan : /chemin/vers/bl.md
   - Fichier d'architecture : /chemin/vers/architecture.md
   ```

**Workflow automatique** :
```
Vous : "Générer architecture Docker depuis bl.md et architecture.md"
     ↓
Claude : [Lit et analyse les fichiers de spécifications]
         [Extrait la stack, les services, l'architecture]
         [Génère le profil du projet]
     ↓
Claude : [Crée Architecture-docker.md avec :]
         - Organisation complète des fichiers
         - Tous les Dockerfiles optimisés
         - Docker-compose pour dev et prod
         - Configuration et variables ENV
         - Instructions de déploiement
         - Métriques estimées
     ↓
Vous : [Fichier prêt à utiliser pour implémenter l'architecture]
```

### Mode 1: Nouveau Projet (Génération Complète)

```
Analyser et conteneuriser mon projet dans /path/to/my-app
```

**Ce qui se passe automatiquement** :

1. **Scan Intelligent Multi-niveau** 📊
   - Détection stack complète (runtime, frameworks, build tools)
   - Analyse graphe de dépendances
   - Identification architecture (monolithe/microservices/monorepo)
   - Détection de patterns (Next.js standalone, Turborepo, etc.)
   - Profiling du projet (taille, complexité, besoins)

2. **Questions Contextuelles** (si nécessaire) 🤔
   - Uniquement pour les choix ambigus
   - Exemple: "Détecté frontend + backend. Séparer en 2 containers ?"
   - Exemple: "Monorepo détecté. Conteneuriser tous les workspaces ?"

3. **Génération Architecture Optimale** 🏗️
   - Sélection automatique d'images de base optimales
   - Multi-stage builds adaptés au contexte
   - Cache mounts intelligents (BuildKit)
   - Configuration docker-compose modulaire
   - Health checks contextuels

4. **Validation et Métriques** ✅
   - Estimation taille finale
   - Estimation build time
   - Security scan
   - Recommandations d'amélioration

### Mode 2: Optimisation de Container Existant

```
Analyser et optimiser mon Dockerfile existant
```

**Analyse Approfondie** :
- Taille actuelle vs optimale
- Vulnérabilités détectées
- Inefficiencies (layers inutiles, cache manquant)
- Best practices manquantes

**Optimisations Proposées** :
- 🎯 Quick wins (30min, -200MB, +sécurité)
- ⚡ Optimisations intermédiaires (2h, -400MB, 2x faster)
- 🚀 Optimisations avancées (1 jour, distroless, SBOM)

**Génération Dockerfile Optimisé** :
- Version améliorée avec explications
- Migration progressive proposée
- A/B comparison (avant/après)

### Mode 3: Audit et Recommandations

```
Auditer mes containers Docker
```

**Audit Complet** :
- Analyse tous les Dockerfiles du projet
- Scan de sécurité (vulnérabilités, permissions)
- Performance benchmarking
- Conformité aux best practices

**Rapport Détaillé** :
```
📊 Résumé:
  - 3 containers analysés
  - Taille totale: 1.2GB → optimisable à 350MB (-71%)
  - 15 vulnérabilités high → patchables
  - Build time: 3min → optimisable à 45s (-75%)

🔴 Issues Critiques:
  - Container 'api' roule en root
  - Image 'frontend' contient secrets hardcodés
  - Aucun health check défini

🟡 Améliorations Recommandées:
  - Upgrade node:16 → node:22-alpine (-200MB)
  - Ajouter cache mounts (-2min build time)
  - Implémenter multi-stage builds (-400MB)

✅ Quick Wins (Impact: High, Effort: Low):
  1. Ajouter utilisateurs non-root (15min)
  2. Update base images (10min)
  3. Ajouter .dockerignore (5min)
```

### 2. Proposition d'architecture

Basé sur l'analyse, je proposerai :

**Pour applications simples** :
```
Monolithe unique
- 1 Dockerfile optimisé
- docker-compose.yml simple
```

**Pour applications complexes** :
```
Microservices modulaires
- Dockerfiles séparés par service
- docker-compose.yml avec services liés
- Volumes pour données persistantes
```

**Pour full-stack** :
```
Frontend + Backend + Base de données
- Service frontend (Node, Nginx, etc.)
- Service backend (Python, Go, Node, etc.)
- Service base de données (PostgreSQL, MongoDB, etc.)
```

### 3. Générer les fichiers

Une fois l'architecture approuvée, je génère :

**Dockerfile** (optimisé) :
```dockerfile
# Multi-stage build avec cache mounts
FROM node:22-alpine AS builder
WORKDIR /app

# Cache pour npm
COPY package*.json ./
RUN --mount=type=cache,target=/root/.npm \
    npm ci --only=production

COPY . .
RUN npm run build

FROM node:22-alpine
WORKDIR /app

# Utilisateur non-root
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001 -G nodejs

COPY --from=builder --chown=nodejs:nodejs /app/dist ./dist
COPY --from=builder --chown=nodejs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nodejs:nodejs /app/package*.json ./

USER nodejs
EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', (r) => {if (r.statusCode !== 200) throw new Error()})"

CMD ["node", "dist/index.js"]
```

**docker-compose.yml** (modulaire) :
```yaml
version: '3.9'
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: my-app
    environment:
      NODE_ENV: production
    ports:
      - "3000:3000"
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
    restart: unless-stopped
```

**.dockerignore** :
```
node_modules
npm-debug.log
.git
.gitignore
README.md
.env
.env.local
.DS_Store
build/
dist/
```

### 4. Optimisations appliquées

**Réduction de taille** :
- ✅ Multi-stage builds (élimine dépendances de build)
- ✅ Images de base minimalistes (alpine, distroless)
- ✅ Suppression des fichiers inutiles
- ✅ Cache layering optimal

**Sécurité** :
- ✅ Utilisateur non-root (pas de `root`)
- ✅ Read-only filesystem quand possible
- ✅ Health checks intégrés
- ✅ Secrets via variables d'environnement
- ✅ Pas de secrets hardcodés

**Performance** :
- ✅ Compilation en mode release
- ✅ Dépendances de production uniquement
- ✅ Caching des layers intelligent

## Instructions Spécifiques pour le Mode Génération depuis Spécifications

Quand l'utilisateur demande de générer l'architecture Docker depuis des fichiers de spécifications :

### Étape 1 : Identifier et Lire les Fichiers

```
1. Demander les chemins des fichiers si non fournis :
   - Fichier de plan/backlog
   - Fichier d'architecture technique
   - Autres fichiers pertinents

2. Lire tous les fichiers fournis avec l'outil Read
```

### Étape 2 : Analyser le Contenu

Extraire des fichiers :
- **Stack Technologique** : langages, frameworks, runtimes
- **Services/Composants** : frontend, backend, API, workers, etc.
- **Bases de Données** : PostgreSQL, MongoDB, Redis, etc.
- **Services Tiers** : RabbitMQ, Elasticsearch, etc.
- **Architecture** : monolithe, microservices, full-stack
- **Besoins** : performance, sécurité, scalabilité
- **Environnements** : dev, staging, production

**IMPORTANT** : Après extraction, consulter context7 pour CHAQUE technologie identifiée afin d'obtenir :
- Documentation officielle de déploiement Docker
- Best practices actuelles (2026)
- Commandes et configurations recommandées
- Optimisations spécifiques

Exemple :
```
Technologies détectées : Next.js, FastAPI, PostgreSQL, Redis
→ Consulter context7 pour Next.js Docker deployment
→ Consulter context7 pour FastAPI production setup
→ Consulter context7 pour PostgreSQL Docker best practices
→ Consulter context7 pour Redis Docker configuration
```

### Étape 3 : Créer le Profil du Projet

Basé sur l'analyse, déterminer :
```json
{
  "project_name": "extrait du fichier",
  "type": "monolith | fullstack | microservices | monorepo",
  "stack": {
    "frontend": ["Next.js", "React", "Vue", etc.],
    "backend": ["Node.js", "Python/FastAPI", "Go", etc.],
    "databases": ["PostgreSQL", "Redis", etc.],
    "services": ["RabbitMQ", "Elasticsearch", etc.]
  },
  "architecture": "détaillée depuis les specs",
  "priorities": ["performance", "security", "size"],
  "environments": ["development", "production"]
}
```

### Étape 4 : Générer Architecture-docker.md

Créer le fichier avec la structure complète suivante :

```markdown
# Architecture Docker - {Nom du Projet}

## 📋 Vue d'Ensemble

### Description du Projet
{Extraite des fichiers de spécifications}

### Stack Technologique
- **Frontend** : {liste des technologies}
- **Backend** : {liste des technologies}
- **Bases de Données** : {liste}
- **Services** : {liste}
- **Build Tools** : {package managers, build systems}

### Architecture Choisie
{Monolithe | Full-Stack | Microservices | Monorepo}

**Justification** :
{Explication basée sur les besoins du projet}

---

## 🏗️ Organisation des Fichiers

```
{Arborescence complète adaptée au projet}
```

**Explications** :
{Description de chaque dossier/fichier important}

---

## 🐳 Dockerfiles

{Pour chaque service détecté, générer un Dockerfile complet et optimisé}

### {Service 1} - Dockerfile

**Chemin** : `{chemin}/Dockerfile`

```dockerfile
{Dockerfile multi-stage optimisé complet}
```

**Optimisations appliquées** :
- ✅ Multi-stage build ({nombre} stages)
- ✅ Image de base : {image choisie} ({taille estimée})
- ✅ Cache mounts pour {package manager}
- ✅ Utilisateur non-root
- ✅ Health check intégré
- ✅ Production dependencies uniquement

**Taille estimée** : {taille} MB
**Build time estimé** : {temps}

---

### {Service 2} - Dockerfile

{Répéter pour chaque service}

---

## 📄 Fichiers .dockerignore

{Pour chaque service avec un Dockerfile}

### {Service 1} - .dockerignore

**Chemin** : `{chemin}/.dockerignore`

```
{Contenu .dockerignore adapté}
```

---

## 🎼 Docker Compose

### Development - docker-compose.yml

**Chemin** : `docker-compose.yml`

```yaml
{Configuration complète docker-compose pour le développement}
```

**Caractéristiques** :
- Hot reload activé
- Volumes pour le code source
- Debug ports exposés
- Logs en temps réel

---

### Production - docker-compose.prod.yml

**Chemin** : `docker-compose.prod.yml`

```yaml
{Configuration complète docker-compose pour la production}
```

**Caractéristiques** :
- Images optimisées
- Resource limits définis
- Health checks actifs
- Restart policies
- Secrets management

---

## ⚙️ Configuration

### Variables d'Environnement

**Fichier** : `.env.example`

```env
{Toutes les variables d'environnement nécessaires}
```

**Description des variables** :
{Tableau explicatif de chaque variable}

### Secrets et Credentials

**Gestion sécurisée** :
- {Instructions pour Docker secrets ou autre méthode}
- {Fichiers à ne JAMAIS commiter}

### Networking

**Ports exposés** :
{Liste des ports avec description}

**Networks Docker** :
{Configuration des réseaux si pertinent}

---

## 🔒 Sécurité

### Mesures Appliquées

- ✅ Tous les containers utilisent des utilisateurs non-root
- ✅ Images de base minimales (alpine/distroless)
- ✅ Pas de secrets hardcodés
- ✅ Health checks sur tous les services
- ✅ Resource limits définis
- ✅ Read-only filesystem (quand possible)

### Scan de Vulnérabilités

**Commandes recommandées** :
```bash
{Commandes pour scanner les images}
```

---

## 🚀 Déploiement

### Build des Images

```bash
# Development
{commandes de build pour dev}

# Production
{commandes de build pour prod}
```

### Démarrage des Services

```bash
# Development
{commandes de démarrage dev}

# Production
{commandes de démarrage prod}
```

### Scripts Utiles

**Fichier** : `scripts/docker-utils.sh`

```bash
{Scripts bash pour faciliter le déploiement}
```

---

## 📊 Métriques et Estimations

### Taille des Images

| Service | Taille Estimée | Optimisation |
|---------|---------------|--------------|
{Tableau pour chaque service}

**Total** : {taille totale} ({pourcentage d'optimisation vs baseline})

### Performance

- **Build Time** :
  - Premier build : {temps}
  - Build avec cache : {temps}
- **Startup Time** : {temps}
- **Resource Usage** :
  - CPU : {estimation}
  - Memory : {estimation}

### Comparaison

| Métrique | Sans Optimisation | Avec Optimisation | Gain |
|----------|------------------|-------------------|------|
{Tableau comparatif}

---

## 🛠️ Maintenance et Optimisations Futures

### Prochaines Étapes Recommandées

1. **Court terme** (Quick wins) :
   {Liste d'optimisations rapides}

2. **Moyen terme** :
   {Liste d'améliorations}

3. **Long terme** :
   {Liste d'optimisations avancées}

### Monitoring et Observabilité

**Suggestions** :
{Outils et configurations pour monitorer les containers}

---

## 📚 Références

- Docker Best Practices : {lien}
- Framework-specific optimizations : {lien}
- Security guidelines : {lien}

---

## ✅ Checklist de Vérification

Avant le déploiement, vérifier :

- [ ] Toutes les images buildent correctement
- [ ] Les health checks fonctionnent
- [ ] Les variables d'environnement sont configurées
- [ ] Les secrets sont gérés de manière sécurisée
- [ ] Les volumes persistants sont configurés
- [ ] Les resource limits sont appropriés
- [ ] Les images ont été scannées pour les vulnérabilités
- [ ] La documentation est à jour

---

**Document généré automatiquement par Docker Optimizer Skill**
*Date : {date}*
*Basé sur : {liste des fichiers sources}*
```

### Étape 5 : Validation et Recommandations

Après la génération, fournir :
- Résumé des choix architecturaux
- Justification des optimisations
- Avertissements si certaines informations manquaient
- Suggestions d'améliorations possibles

## Cas d'usage courants

### Node.js / Express
```
Analyser mon app Express dans /path/app
```
→ Génère Dockerfile avec build optimisé, docker-compose avec health checks

### Python / FastAPI
```
Analyser mon app FastAPI dans /path/app
```
→ Multi-stage avec compilation, slim/distroless Python, gestion des venv

### Go
```
Analyser mon app Go dans /path/app
```
→ Multi-stage avec scratch image, binaire statique compressé

### Microservices complets
```
Analyser mon architecture microservices dans /path/mono-repo
```
→ Services détectés, Dockerfiles séparés, docker-compose avec dépendances

### Next.js / Nuxt / Frameworks modernes
```
Analyser mon app Next.js dans /path/next-app
```
→ Dockerfile avec standalone output, optimisations framework-specific, taille < 200MB

### Monorepo (Turborepo, Nx, etc.)
```
Analyser mon monorepo dans /path/monorepo
```
→ Dockerfiles par workspace, build orchestration, cache partagé

## Configurations avancées

Consultez les fichiers de référence pour :

- **Dockerfiles optimisés par langage** : See `references/dockerfile-patterns.md`
- **Frameworks modernes (Next.js, Nuxt, etc.)** : See `references/modern-frameworks.md`
- **Docker-compose avancé** : See `references/compose-advanced.md`
- **Sécurité et hardening** : See `references/docker-security.md`
- **Documentation Docker actuelle** : See `references/docker-docs.md`

## Bonnes pratiques intégrées

Cette skill applique automatiquement :

1. **Versioning explicite** - Jamais de tags `latest`, utilisation de digests SHA
2. **Utilisateurs non-root** - Chaque container roule sous un utilisateur dédié
3. **Health checks** - Contrôles de santé pour tous les services
4. **Resource limits** - Limites de CPU et mémoire
5. **Logs structurés** - Logs envoyés à stdout/stderr
6. **Scan de vulnérabilités** - Recommandations pour Trivy/Snyk/Docker Scout
7. **Reproducibilité** - Lock files et versions précises
8. **BuildKit optimization** - Cache mounts pour builds plus rapides
9. **Multi-platform builds** - Support ARM64/AMD64 quand pertinent
10. **SBOM generation** - Software Bill of Materials pour compliance
11. **Image signing** - Recommandations Cosign/Notary pour production

## Workflow complet

```
Vous : "Analyser mon app Node.js dans ./src"
      ↓
Claude : [Scanne l'app]
         [Propose architecture]
         [Vous demande confirmation]
      ↓
Vous : "Valider, générer les fichiers"
      ↓
Claude : [Génère Dockerfile optimisé]
         [Génère docker-compose.yml]
         [Génère .dockerignore]
         [Fournit guide de déploiement]
```

## Prochaines étapes

Après génération, vous pouvez :

- **Tester localement** : `docker-compose up`
- **Scanner les vulnérabilités** : `docker scan my-app:latest`
- **Optimiser davantage** : Je peux affiner l'image ou les configurations
- **Déployer** : Je peux adapter pour Kubernetes, CI/CD, etc.
