# Docker Optimizer - Quick Start Guide

## 🆕 Mode Spécifications (Nouveau!)

**Idéal pour** : Générer l'architecture Docker depuis vos documents de planification, AVANT d'écrire le code.

### Étape 1 : Préparez vos fichiers

Assurez-vous d'avoir vos fichiers de spécifications :
- `bl.md` ou `plan.md` - Plan/backlog du projet
- `architecture.md` - Architecture technique détaillée

### Étape 2 : Commande

```
Générer architecture Docker depuis mes fichiers bl.md et architecture.md
```

### Étape 3 : Résultat

Claude génère **un seul fichier** `Architecture-docker.md` contenant :
- ✅ Vue d'ensemble complète du projet
- ✅ Organisation de tous les fichiers
- ✅ **Tous les Dockerfiles** (frontend, backend, workers, etc.)
- ✅ **Tous les .dockerignore**
- ✅ **docker-compose.yml** (development)
- ✅ **docker-compose.prod.yml** (production)
- ✅ Variables d'environnement
- ✅ Scripts de déploiement
- ✅ Métriques estimées

### Étape 4 : Utilisation

Utilisez ce document comme **blueprint complet** pour :
- Créer l'architecture Docker de votre projet
- Guider l'équipe de développement
- Référence pour l'implémentation

**Voir exemple complet** : `MODE-SPECS-EXAMPLE.md`

---

## 📚 Documentation Officielle Automatique (Context7)

**NOUVEAU** : Le skill consulte automatiquement la documentation officielle via MCP Context7 !

### Qu'est-ce que c'est ?

Avant de générer toute configuration Docker, le skill :
1. Détecte vos technologies (Next.js, FastAPI, PostgreSQL, etc.)
2. **Consulte automatiquement** la documentation officielle via context7
3. Extrait les **best practices actuelles (2026)**
4. Applique les **recommendations officielles**

### Avantages pour Vous

- ✅ Configurations toujours **à jour**
- ✅ Best practices **validées par les mainteneurs**
- ✅ Commandes et optimisations **recommandées officiellement**
- ✅ Évite les **configurations obsolètes**

### Exemple

```
Votre projet : Next.js + FastAPI + PostgreSQL

→ Skill consulte automatiquement :
  - Documentation Next.js pour Docker
  - Documentation FastAPI production
  - Documentation PostgreSQL Docker

→ Génère des configurations basées sur la doc officielle
```

**Vous n'avez rien à faire** - C'est automatique ! 🚀

**Guide complet** : `references/context7-integration.md`

---

## 1️⃣ Analyse votre application

Dites à Claude :
```
Analyser mon application dans ./mon-app
```

Claude va :
- ✅ Scanner la structure du projet
- ✅ Détecter les technologies (Node.js, Python, Go, etc.)
- ✅ Identifier l'architecture (monolithe, microservices, full-stack)
- ✅ Proposer une architecture Docker optimale
- ✅ Donner des tips d'optimisation

## 2️⃣ Valider la proposition

Claude vous propose une architecture. Exemple :
```
Architecture détectée : Full-stack
- Frontend : React + Node.js
- Backend : Express API
- Database : PostgreSQL
- Cache : Redis

Taille estimée des images : 150MB (frontend) + 200MB (backend)
```

Validez avec :
```
Oui, générer les fichiers Docker pour cette architecture
```

## 3️⃣ Récupérez les fichiers générés

Claude génère :

**1. Dockerfile (backend)**
```dockerfile
FROM node:20-alpine AS builder
...
```

**2. Dockerfile (frontend)**
```dockerfile
FROM node:20-alpine AS builder
...
```

**3. docker-compose.yml**
```yaml
version: '3.9'
services:
  frontend:
    ...
  api:
    ...
  db:
    ...
```

**4. .dockerignore**
```
node_modules/
.git
...
```

## 4️⃣ Intégrez dans votre projet

```bash
# Copier les Dockerfiles
cp Dockerfile.backend ./backend/Dockerfile
cp Dockerfile.frontend ./frontend/Dockerfile

# Copier docker-compose
cp docker-compose.yml ./

# Copier .dockerignore
cp .dockerignore ./
```

## 5️⃣ Testez localement

```bash
# Créer les images et lancer les services
docker-compose up -d

# Voir les logs
docker-compose logs -f

# Arrêter les services
docker-compose down
```

## 6️⃣ Vérifier la sécurité

```bash
# Scanner les vulnérabilités
docker scout cves mon-app-frontend:latest
docker scout cves mon-app-backend:latest

# Vérifier que les containers roulent en non-root
docker run mon-app-backend:latest id
# Doit afficher : uid=1001(nodejs) gid=1001(nodejs)
```

## 7️⃣ Déployer

```bash
# Tagger pour production
docker tag mon-app-backend:latest myregistry/mon-app-backend:1.0.0
docker tag mon-app-frontend:latest myregistry/mon-app-frontend:1.0.0

# Pousser vers registry
docker push myregistry/mon-app-backend:1.0.0
docker push myregistry/mon-app-frontend:1.0.0
```

---

## 📚 Références Disponibles

La skill fournit plusieurs références :

### Patterns Dockerfile par technologie
```
Consulter : references/dockerfile-patterns.md
```
Contient les patterns optimisés pour :
- Node.js (multi-stage, alpine, distroless)
- Python (slim, venv, gunicorn)
- Go (scratch image, minimal)
- Java (alpine JRE)
- Rust (cargo, alpine)

### Docker Compose avancé
```
Consulter : references/compose-advanced.md
```
Couvre :
- Microservices
- Gestion des données (volumes, backups)
- Networking
- Health checks
- Resource limits
- Profils (dev/prod)

### Sécurité Docker
```
Consulter : references/docker-security.md
```
Checklist complète pour :
- Utilisateurs non-root
- Image security
- Runtime security
- Secrets management
- Scanning & monitoring

### Documentation Docker 2026
```
Consulter : references/docker-docs.md
```
Versions actuelles, commandes, best practices

---

## ⚡ Cas d'usage courants

### Node.js simple
```
Analyser mon app Node.js dans ./app

→ 1 Dockerfile optimisé
→ .dockerignore
→ docker-compose.yml basique
```

### Full-stack React + Node.js
```
Analyser mon full-stack dans ./project

→ 2 Dockerfiles (frontend + backend)
→ docker-compose avec PostgreSQL
→ Configuration sécurisée
```

### Microservices
```
Analyser mes microservices dans ./mono-repo

→ Dockerfiles séparés par service
→ docker-compose.yml avec dépendances
→ Networks isolés
```

### Python + FastAPI
```
Analyser mon app FastAPI dans ./backend

→ Dockerfile multi-stage slim
→ HEALTHCHECK optimisé
→ docker-compose avec PostgreSQL
```

---

## 🔍 Questions courantes

### Q: Comment minimiser la taille de l'image ?
**A:** Consulter `references/dockerfile-patterns.md` pour :
- Multi-stage builds (réduit 50-70%)
- Images minimalistes (alpine, distroless)
- .dockerignore optimisé
- Suppression des dépendances de build

### Q: Comment sécuriser mon container ?
**A:** Consulter `references/docker-security.md` pour :
- ✅ Utilisateurs non-root
- ✅ Health checks
- ✅ Resource limits
- ✅ Networks isolés
- ✅ Secrets management

### Q: Comment configurer la production ?
**A:** Dans `references/docker-docs.md` :
- Version des images exactes (pas `latest`)
- Resource limits
- Health checks
- Logs structurés
- Monitoring

### Q: Comment gérer les secrets ?
**A:** Dans `references/docker-security.md` :
- Utiliser des fichiers `.env` (ignorés par git)
- Docker Swarm secrets (mode avancé)
- Gestionnaire externe (Vault, AWS Secrets, etc.)
- JAMAIS en dur dans le Dockerfile

---

## 📊 Optimisations typiques

| Stack | Image de base | Taille | Build time |
|-------|---|---|---|
| Node.js | alpine | 150-200MB | 30-60s |
| Node.js | distroless | 100MB | 30-60s |
| Python | slim | 150-200MB | 60-90s |
| Go | scratch | 10-50MB | 10-30s |
| Java | alpine JRE | 300-400MB | 60-120s |

---

## 🛠️ Outils recommandés

### Build & Push
```bash
docker build -t myapp:1.0.0 .
docker push myapp:1.0.0
```

### Scanner les vulnérabilités
```bash
# Docker Scout (officiel Docker)
docker scout cves myapp:1.0.0

# Ou Trivy (Aquasec)
trivy image myapp:1.0.0
```

### Orchestration
```bash
# Docker Compose (développement)
docker-compose up

# Docker Swarm (production simple)
docker swarm init
docker service create ...

# Kubernetes (production avancée)
kubectl apply -f deployment.yaml
```

---

## 📝 Checklist avant production

- [ ] Scanner les vulnérabilités (`docker scout cves`)
- [ ] Vérifier l'utilisateur non-root (`docker run image id`)
- [ ] Tester les health checks (`docker-compose ps`)
- [ ] Configurer les secrets (`.env` ignoré par git)
- [ ] Limiter les ressources (CPU, RAM dans compose)
- [ ] Vérifier les logs (`docker-compose logs`)
- [ ] Tester localement (`docker-compose up`)
- [ ] Signer les images (optionnel mais recommandé)

---

## 🚀 Prochaines étapes

1. **Analyser votre app** : Dites à Claude "Analyser mon app"
2. **Valider l'architecture** : Approuvez la proposition
3. **Générer les fichiers** : Claude crée Dockerfiles, compose, etc.
4. **Tester localement** : `docker-compose up`
5. **Scanner les vulnérabilités** : `docker scout cves`
6. **Déployer** : Pousser vers registry et déployer

---

## 🤔 Besoin d'aide ?

- **Patterns Dockerfile** → Consulter `references/dockerfile-patterns.md`
- **Docker Compose** → Consulter `references/compose-advanced.md`
- **Sécurité** → Consulter `references/docker-security.md`
- **Docs récentes** → Consulter `references/docker-docs.md`

Ou demandez à Claude :
```
Expliquer comment optimiser la taille de mon image
Ajouter un health check à mon service
Configurer les secrets pour la production
```
