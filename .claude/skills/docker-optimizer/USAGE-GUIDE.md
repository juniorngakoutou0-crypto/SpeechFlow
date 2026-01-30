# Guide d'Utilisation - Docker Optimizer (Mode Adaptatif)

## 🚀 Démarrage Rapide

### Scénario 0: Génération depuis Spécifications (NOUVEAU ⭐)

```bash
# Commande avec fichiers de spécifications
"Générer architecture Docker depuis mes fichiers bl.md et architecture.md"
```

**Ce qui se passe** :
1. ✅ Lecture et analyse des fichiers de spécifications
2. ✅ Extraction de la stack technologique
3. ✅ Détection de l'architecture et des services
4. ✅ Génération du fichier Architecture-docker.md complet
5. ✅ Documentation complète avec tous les Dockerfiles, docker-compose, etc.

**Résultat** :
- `Architecture-docker.md` - Document complet contenant :
  - Vue d'ensemble du projet
  - Organisation complète des fichiers
  - Tous les Dockerfiles optimisés
  - Tous les fichiers .dockerignore
  - docker-compose.yml (dev)
  - docker-compose.prod.yml (production)
  - Configuration des variables ENV
  - Instructions de déploiement
  - Métriques estimées
  - Checklist de vérification

**Idéal pour** :
- ✅ Phase de planification du projet
- ✅ Pas besoin de code source existant
- ✅ Créer l'architecture Docker avant l'implémentation
- ✅ Documentation technique complète
- ✅ Guide pour l'équipe de développement

**Exemples d'utilisation** :
```bash
# Exemple 1 : Simple
"Utilise mes fichiers plan.md et architecture.md pour générer l'architecture Docker"

# Exemple 2 : Avec chemins spécifiques
"Génère Architecture-docker.md basé sur docs/bl.md et docs/technical-architecture.md"

# Exemple 3 : Avec préférences
"Crée l'architecture Docker depuis mes specs (bl.md, architecture.md) avec priorité sur la taille minimale"
```

**Voir** : `assets/MODE-SPECS-EXAMPLE.md` pour un exemple complet

---

### Scénario 1: Nouveau Projet - Analyse Complète

```bash
# Commande simple
"Analyser et conteneuriser mon projet"
```

**Ce qui se passe** :
1. ✅ Scan intelligent multi-niveau
2. ✅ Détection automatique de l'architecture
3. ✅ Questions contextuelles (seulement si nécessaire)
4. ✅ Génération Dockerfiles + compose optimisés
5. ✅ Validation et métriques

**Résultat** :
- `Dockerfile` (ou plusieurs si multi-service)
- `docker-compose.yml`
- `.dockerignore`
- `.env.example`
- Rapport avec métriques et recommandations

---

### Scénario 2: Optimiser Container Existant

```bash
"Analyser mon Dockerfile et proposer des optimisations"
```

**Analyse automatique** :
- Taille actuelle vs optimale
- Vulnérabilités détectées
- Best practices manquantes
- Cache inefficiencies

**Optimisations proposées** :
```
🎯 Quick Wins (30min, -200MB)
  - Update base image (node:16 → node:22-alpine)
  - Add non-root user
  - Remove dev dependencies

⚡ Optimisations Intermédiaires (2h, -400MB)
  - Multi-stage build
  - Cache mounts
  - Layer optimization

🚀 Optimisations Avancées (1 jour, -600MB)
  - Distroless image
  - SBOM generation
  - Remote caching
```

---

### Scénario 3: Audit Complet

```bash
"Auditer tous mes containers Docker"
```

**Rapport Généré** :
```
📊 Projet: my-app
   3 containers analysés

🔴 Issues Critiques:
   - api: Roule en root
   - frontend: 12 vulnérabilités high
   - Total size: 1.2GB (optimisable à 350MB)

🟡 Améliorations Prioritaires:
   1. Security: Non-root users (15min)
   2. Size: Multi-stage builds (2h, -600MB)
   3. Performance: Cache mounts (30min, -70% build time)

✅ Quick Wins (Impact High, Effort Low):
   - Update base images → -200MB
   - Add .dockerignore → -50MB
   - Health checks → +monitoring
```

---

## 🎯 Modes d'Utilisation

### Mode Auto (Recommandé)

Le skill prend toutes les décisions intelligemment :

```bash
"Conteneuriser mon projet avec optimisations automatiques"
```

**Décisions Automatiques** :
- ✅ Sélection image de base optimale
- ✅ Multi-stage si pertinent
- ✅ Cache mounts pour performance
- ✅ Security best practices
- ✅ Architecture adaptée au projet

### Mode Guidé

Le skill pose des questions pour les choix importants :

```bash
"Conteneuriser mon projet (mode guidé)"
```

**Questions Posées** :
- Architecture séparée ou monolithique ?
- Priorité : taille, vitesse ou sécurité ?
- Environnement : dev, staging ou prod ?
- Features avancées : SBOM, signing ?

### Mode Expert

Contrôle total avec configuration personnalisée :

```bash
# Créer .docker-optimizer.yml avec vos préférences
"Conteneuriser avec ma config custom"
```

---

## 📋 Exemples par Type de Projet

### Next.js / Nuxt

```bash
"Conteneuriser mon app Next.js"
```

**Génère** :
- Dockerfile avec standalone output (~180MB)
- Cache mounts pour node_modules
- Multi-stage optimisé
- Health check intelligent

### Monorepo (Turborepo/Nx)

```bash
"Conteneuriser mon monorepo Turborepo"
```

**Génère** :
- Dockerfiles par workspace
- Build sélectif (seulement ce qui a changé)
- Cache partagé entre builds
- Remote caching configuré

### Microservices

```bash
"Conteneuriser mon architecture microservices"
```

**Génère** :
- Dockerfile par service
- docker-compose avec orchestration
- Networks isolés (frontend/backend)
- Service discovery
- Health checks + dependencies

### Full-stack Simple

```bash
"Conteneuriser mon app React + Express + PostgreSQL"
```

**Génère** :
- 3 services (frontend, backend, db)
- Volumes persistence
- Networks configurés
- Health checks cascade
- Resource limits optimaux

---

## ⚙️ Configuration Personnalisée

### Créer un fichier de config

```yaml
# .docker-optimizer.yml à la racine du projet

priorities:
  primary: size  # Optimiser pour la taille

optimization_level: aggressive

image_preferences:
  base_type: distroless  # Images ultra-minimales

security:
  generate_sbom: true
  sign_images: true

targets:
  max_image_size: 200MB
```

### Utiliser la config

```bash
"Conteneuriser avec ma configuration"
```

---

## 🔍 Analyses Spécialisées

### Analyse de Performance

```bash
"Analyser la performance de build de mes containers"
```

**Résultat** :
- Build time avec/sans cache
- Cache hit rate
- Layer inefficiencies
- Recommandations pour -50% build time

### Analyse de Sécurité

```bash
"Audit de sécurité de mes containers"
```

**Résultat** :
- Scan vulnérabilités
- Permissions check
- Secrets detection
- Compliance report

### Analyse de Taille

```bash
"Optimiser la taille de mes images Docker"
```

**Résultat** :
- Layer-by-layer analysis
- Bloat detection
- Compression opportunities
- Target: -60% size

---

## 🎨 Stratégies d'Optimisation

### Stratégie Balanced (Par défaut)

```
Optimiser mon projet (balanced)
```

- Multi-stage builds
- Alpine base images
- Production deps only
- Cache mounts
- **Taille cible** : 150-300MB
- **Build time** : 1-2min

### Stratégie Aggressive

```
Optimiser mon projet (taille minimale)
```

- Distroless images
- Binary stripping
- Compression maximale
- Static linking
- **Taille cible** : 50-150MB
- **Build time** : 2-3min

### Stratégie Speed

```
Optimiser mon projet (build rapide)
```

- Remote caching
- Parallel builds
- Minimal layers
- **Taille cible** : 200-400MB
- **Build time** : 30-60s

---

## 📊 Métriques et Benchmarking

### Obtenir un rapport détaillé

```bash
"Générer un rapport complet de mes containers"
```

**Rapport Inclut** :
```
📊 Métriques Globales
   - Total size: 350MB
   - Build time (no cache): 2min 15s
   - Build time (with cache): 12s
   - Cache hit rate: 85%

🎯 Par Container
   frontend:
     - Size: 120MB (vs baseline 450MB = -73%)
     - Vulnerabilities: 0
     - Build time: 45s
     - Best practices: 18/18 ✓

   backend:
     - Size: 180MB (vs baseline 600MB = -70%)
     - Vulnerabilities: 0
     - Build time: 1min 10s
     - Best practices: 18/18 ✓

💡 Recommandations
   1. Frontend: Considérer distroless (-30MB)
   2. Backend: Activer remote cache (-50s build)
   3. Global: SBOM generation pour compliance
```

---

## 🔄 Workflow Itératif

### Itération 1: Quick Start

```bash
"Conteneuriser rapidement mon projet"
```
→ Config de base fonctionnelle (5min)

### Itération 2: Optimisation

```bash
"Optimiser mes containers pour la production"
```
→ Multi-stage, sécurité, cache (30min)

### Itération 3: Fine-tuning

```bash
"Affiner mes containers pour taille minimale"
```
→ Distroless, compression, tuning (2h)

### Itération 4: Enterprise

```bash
"Préparer mes containers pour déploiement enterprise"
```
→ SBOM, signing, monitoring, compliance (1 jour)

---

## 💡 Tips et Astuces

### Gagner 50% de temps de build

```bash
"Ajouter cache mounts à mes Dockerfiles"
```

### Réduire de 70% la taille

```bash
"Optimiser mes images avec multi-stage et alpine"
```

### Sécuriser au maximum

```bash
"Hardening complet de mes containers"
```

### Migration progressive

```bash
"Plan de migration pour optimiser mes containers existants"
```

---

## 🆘 Dépannage

### "Mon build est trop lent"

```bash
"Analyser et accélérer mes builds Docker"
```

### "Mes images sont trop lourdes"

```bash
"Réduire la taille de mes images Docker"
```

### "J'ai des vulnérabilités"

```bash
"Scanner et corriger les vulnérabilités de mes images"
```

### "Je ne sais pas par où commencer"

```bash
"Analyser mon projet et proposer la meilleure approche Docker"
```

---

## 🎓 Exemples Réels

### Startup MVP

```bash
User: "J'ai une app Next.js + Node API + PostgreSQL.
       Je veux conteneuriser rapidement pour déployer."

Skill: [Analyse]
       → Full-stack détecté
       → Génère 3 services optimisés
       → Total: 380MB, build: 1min 30s
       → Production-ready avec health checks
```

### Enterprise Microservices

```bash
User: "Monorepo avec 8 microservices (Node.js, Python, Go).
       Besoin compliance + sécurité maximale."

Skill: [Analyse]
       → Microservices architecture
       → Dockerfiles par service avec base commune
       → SBOM generation activé
       → Image signing configuré
       → Total: 1.2GB (8 services), build: 4min
       → Compliance-ready
```

### Side Project

```bash
User: "App React simple, je veux juste conteneuriser vite."

Skill: [Analyse]
       → Frontend simple détecté
       → Nginx serving optimisé
       → 1 Dockerfile, ~50MB
       → Build: 30s
       → Prêt à déployer
```

---

## 🌟 Best Practices Appliquées Automatiquement

✅ **Toujours** :
- Utilisateurs non-root
- Multi-stage builds
- .dockerignore optimisé
- Health checks
- Logs structurés

✅ **Selon contexte** :
- Cache mounts (BuildKit)
- Remote caching (monorepos)
- Distroless (production stricte)
- SBOM (compliance)
- Image signing (enterprise)

---

## 🚀 Prochaines Étapes

Après génération :

1. **Tester localement**
   ```bash
   docker compose up
   ```

2. **Valider**
   ```bash
   docker compose ps
   docker compose logs -f
   ```

3. **Scanner**
   ```bash
   docker scout cves mon-app:latest
   ```

4. **Déployer**
   ```bash
   docker compose -f docker-compose.prod.yml up -d
   ```

---

## 📚 Documentation Officielle avec Context7

### Intégration Automatique

Le skill **consulte automatiquement** la documentation officielle via MCP Context7 avant de générer toute configuration Docker.

**Pourquoi c'est important ?**
- ✅ Configurations basées sur les **best practices actuelles (2026)**
- ✅ Recommendations **officielles des mainteneurs**
- ✅ Commandes et flags **validés et à jour**
- ✅ Optimisations **spécifiques à chaque technologie**

### Comment ça Fonctionne

```
Détection technologie → Consultation context7 → Application best practices
```

**Exemple concret** :

```bash
Projet détecté : Next.js + FastAPI + PostgreSQL

→ Context7 : "Next.js Docker production deployment"
   Extrait : standalone output, optimizations, ENV vars

→ Context7 : "FastAPI Docker Uvicorn production"
   Extrait : workers config, health checks, performance

→ Context7 : "PostgreSQL Docker best practices"
   Extrait : configuration, volumes, security

→ Génération basée sur la documentation officielle
```

### Technologies Couvertes

**Frontend** : Next.js, Nuxt, Remix, SvelteKit, Astro, React, Vue

**Backend** : FastAPI, Django, Flask, Express, NestJS

**Runtimes** : Node.js, Bun, Deno, Python, Go, Rust

**Databases** : PostgreSQL, MongoDB, Redis, MySQL

**Tools** : Turborepo, Nx, Vite, Docker, Docker Compose

### Avantages pour Vous

Vous n'avez **rien à faire** - le skill :
1. Détecte vos technologies
2. Consulte automatiquement la documentation officielle
3. Applique les best practices
4. Génère des configurations optimales et à jour

### Pour en Savoir Plus

Consultez le guide complet : `references/context7-integration.md`

---

Le skill s'adapte automatiquement à **n'importe quel projet** et génère la configuration **optimale pour votre contexte** ! 🎯
