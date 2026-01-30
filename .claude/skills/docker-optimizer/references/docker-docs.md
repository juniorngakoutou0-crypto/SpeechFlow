# Docker Documentation Reference (2026)

## Versions Actuelles Recommandées

### Docker Engine & CLI
- **Dernière version stable** : Docker 27.x (2026)
- **Recommandée pour production** : Version LTS
- [Docker Download](https://www.docker.com/products/docker-desktop)

### Docker Compose
- **Format version** : `3.9` (recommandé)
- **Format version obsolète** : 2.x, 3.0, 3.1
- **Format Compose v2** : `docker-compose` ou `docker compose` (plugin)

### Images de base officielles

#### Node.js
```
node:22-alpine         # LTS 2026, Léger, ~200MB
node:22-slim           # LTS 2026, Slim, ~300MB
node:22                # LTS 2026, Full, ~500MB

node:22-alpine@sha256:xyz  # Avec digest pour immuabilité
```
[Node Official Image](https://hub.docker.com/_/node)

#### Bun (Runtime JavaScript ultra-rapide)
```
oven/bun:1-alpine      # Alpine, ~80MB
oven/bun:1-slim        # Slim, ~100MB
oven/bun:1             # Full, ~150MB
```
[Bun Official Image](https://hub.docker.com/r/oven/bun)

#### Deno (Runtime TypeScript sécurisé)
```
denoland/deno:alpine   # Alpine, ~50MB
denoland/deno:distroless # Distroless, ~60MB
denoland/deno:latest   # Latest, ~100MB
```
[Deno Official Image](https://hub.docker.com/r/denoland/deno)

#### Python
```
python:3.13-alpine     # Latest, Léger, ~150MB
python:3.13-slim       # Latest, Slim, ~200MB
python:3.12-slim       # Stable, Slim, ~200MB
python:3.13            # Latest, Full, ~1GB
```
[Python Official Image](https://hub.docker.com/_/python)

#### Go
```
golang:1.21-alpine     # Build, ~370MB
golang:1.21-alpine AS builder

# Runtime
alpine:latest          # Minimal, ~7MB
gcr.io/distroless/static-debian11  # ~40MB
```
[Go Official Image](https://hub.docker.com/_/golang)
[Distroless Images](https://github.com/GoogleContainerTools/distroless)

#### PostgreSQL
```
postgres:16-alpine     # Léger, ~200MB
postgres:16-slim       # Slim, ~300MB
```
[PostgreSQL Official Image](https://hub.docker.com/_/postgres)

#### Redis
```
redis:7-alpine         # Léger, ~50MB
redis:7-latest         # Latest, ~150MB
```
[Redis Official Image](https://hub.docker.com/_/redis)

#### MySQL
```
mysql:8.0-alpine       # Léger, ~300MB
mysql:8.0              # Full, ~500MB
```
[MySQL Official Image](https://hub.docker.com/_/mysql)

---

## Docker Compose Versions

### Version 3.9 (Recommandée)

Supporte :
- ✅ `services`, `networks`, `volumes`, `secrets`, `configs`
- ✅ `depends_on` avec conditions (`service_healthy`)
- ✅ `profiles` pour services optionnels
- ✅ `healthcheck`
- ✅ `resource limits`

```yaml
version: '3.9'
services:
  app:
    build: .
    depends_on:
      db:
        condition: service_healthy
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000"]
```

### Version 2.1 (Obsolète)

Ancienne version, ne pas utiliser pour nouveaux projets.

### Version 2.x (Obsolète)

Très ancienne, fin de support.

---

## Commandes Docker Essentielles (2026)

### Docker Init (Nouveau - Génération automatique)

```bash
# Générer automatiquement Dockerfile et docker-compose.yml
docker init

# Choisir le template (Node.js, Python, Go, etc.)
# Génère :
# - Dockerfile optimisé
# - docker-compose.yml
# - .dockerignore
# - README.Docker.md
```

### Build & Push

```bash
# Build une image avec BuildKit
DOCKER_BUILDKIT=1 docker build -t myapp:1.0.0 .

# Ou avec syntax directive dans Dockerfile
# syntax=docker/dockerfile:1.7

# Build avec buildx (multi-plateforme)
docker buildx build --platform linux/amd64,linux/arm64 \
  -t myapp:1.0.0 .

# Build avec cache depuis registry
docker buildx build \
  --cache-from type=registry,ref=myapp:cache \
  --cache-to type=registry,ref=myapp:cache,mode=max \
  -t myapp:1.0.0 .

# Push vers registry
docker push myapp:1.0.0

# Build depuis docker-compose
docker compose build
```

### Docker Compose Watch (Dev workflow)

```bash
# Lancer avec watch mode (rebuild auto)
docker compose watch

# Dans docker-compose.yml :
# services:
#   app:
#     build: .
#     develop:
#       watch:
#         - action: sync
#           path: ./src
#           target: /app/src
#         - action: rebuild
#           path: package.json
```

### Exécution

```bash
# Lancer un container
docker run -d --name myapp -p 3000:3000 myapp:1.0.0

# Avec docker-compose
docker-compose up -d

# Logs
docker-compose logs -f

# Exec dans le container
docker exec -it myapp sh
```

### Inspection

```bash
# Lister les images
docker images

# Inspecter une image
docker inspect myapp:1.0.0

# Vérifier les vulnérabilités
docker scout cves myapp:1.0.0

# Vérifier l'utilisateur
docker run myapp:1.0.0 id
```

### Nettoyage

```bash
# Supprimer les containers arrêtés
docker container prune

# Supprimer les images non utilisées
docker image prune

# Supprimer tout (dangereux!)
docker system prune -a
```

---

## Docker Buildx (Multi-plateforme)

Pour les images multi-architecture (ARM64, AMD64, etc.) :

```bash
# Créer un builder
docker buildx create --name mybuilder

# Utiliser le builder
docker buildx build --builder mybuilder \
  --platform linux/amd64,linux/arm64,linux/arm/v7 \
  -t myapp:1.0.0 \
  --push .
```

---

## Docker Scout (Security)

Vérifier les vulnérabilités :

```bash
# Vulnerabilities
docker scout cves myapp:1.0.0

# Recommendations
docker scout recommendations myapp:1.0.0

# Exporte en JSON
docker scout cves --format json myapp:1.0.0 > report.json
```

---

## Réseaux Docker

### Types de réseaux

```bash
# Bridge (par défaut)
docker network create mynet --driver bridge

# Host (performances élevées)
docker run --network host myapp

# Overlay (pour Swarm)
docker network create mynet --driver overlay
```

### Dans docker-compose

```yaml
networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge

services:
  app:
    networks:
      - frontend
```

---

## Volumes & Stockage

### Volumes nommés

```bash
docker volume create mydata
docker run -v mydata:/data myapp
```

### Dans docker-compose

```yaml
volumes:
  db_data:
    driver: local

services:
  db:
    volumes:
      - db_data:/var/lib/postgresql/data
```

### Bind mounts

```bash
docker run -v /host/path:/container/path myapp
```

⚠️ À utiliser seulement en développement.

---

## Secrets & Configuration

### Secrets Docker (Swarm)

```yaml
secrets:
  db_password:
    file: ./secrets/db_password.txt

services:
  app:
    secrets:
      - db_password
    environment:
      # Fichier au path /run/secrets/db_password
      DB_PASSWORD_FILE: /run/secrets/db_password
```

### Variables d'environnement

```yaml
services:
  app:
    environment:
      NODE_ENV: production
      # Depuis fichier .env
      API_KEY: ${API_KEY}
```

---

## Healthchecks

### Syntaxe générale

```dockerfile
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1
```

Paramètres :
- `--interval` : Fréquence du check (défaut 30s)
- `--timeout` : Timeout du check (défaut 30s)
- `--start-period` : Délai avant le premier check (défaut 0s)
- `--retries` : Nombre d'échecks avant "unhealthy" (défaut 3)

### Conditions dans docker-compose

```yaml
depends_on:
  db:
    condition: service_healthy
```

Le service attend que `db` soit `healthy` avant de démarrer.

---

## Resource Limits

### Syntaxe docker-compose

```yaml
deploy:
  resources:
    limits:
      cpus: '1'          # 1 CPU max
      memory: 512M       # 512MB RAM max
    reservations:
      cpus: '0.5'        # 0.5 CPU réservé
      memory: 256M       # 256MB RAM réservé
```

### En ligne de commande

```bash
docker run \
  --cpus="1.5" \
  --memory="512m" \
  myapp:1.0.0
```

---

## Docker Registry (Registry Privé)

### Utiliser Docker Hub

```bash
# Login
docker login

# Tag
docker tag myapp:1.0.0 myusername/myapp:1.0.0

# Push
docker push myusername/myapp:1.0.0
```

### Self-hosted Registry

```bash
# Lancer un registry local
docker run -d -p 5000:5000 registry:latest

# Tag
docker tag myapp:1.0.0 localhost:5000/myapp:1.0.0

# Push au registry local
docker push localhost:5000/myapp:1.0.0
```

---

## Docker Swarm (Orchestration simple)

### Initialiser

```bash
docker swarm init
docker swarm join --token SWMTKN-...
```

### Déployer un service

```bash
docker service create --name myapp -p 3000:3000 myapp:1.0.0
```

### Scaling

```bash
docker service scale myapp=3  # 3 replicas
```

### Mises à jour

```bash
docker service update \
  --image myapp:2.0.0 \
  myapp
```

---

## Kubernetes (Orchestration avancée)

Kubernetes est plus avancé que Docker Swarm :

```yaml
# service.yaml
apiVersion: v1
kind: Service
metadata:
  name: myapp
spec:
  selector:
    app: myapp
  ports:
    - port: 3000
      targetPort: 3000

---
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp
        image: myapp:1.0.0
        ports:
        - containerPort: 3000
```

Deploy :
```bash
kubectl apply -f service.yaml
kubectl apply -f deployment.yaml
```

---

## Outils de Scanning

### Trivy (Aquasec)

```bash
# Scanner une image
trivy image myapp:1.0.0

# Exporter un rapport JSON
trivy image --format json myapp:1.0.0 > report.json

# Scanner le code source
trivy fs .
```

[Trivy GitHub](https://github.com/aquasecurity/trivy)

### Snyk

```bash
npm install -g snyk
snyk auth
snyk container test myapp:1.0.0
```

[Snyk.io](https://snyk.io)

### Docker Scout (Officiel Docker)

```bash
# Déjà inclus dans Docker Desktop
docker scout cves myapp:1.0.0
```

---

## Bonnes Pratiques 2026

### Images

✅ **À faire** :
- Utiliser des images officielles signées
- Spécifier une version exacte (pas `latest`)
- Utiliser des digests SHA pour immuabilité
- Images minimalistes (alpine, distroless)
- Multi-stage builds

❌ **À éviter** :
- Images custom sans scanner
- Tag `latest`
- Images énormes (> 1GB)
- Secrets en dur dans l'image

### Composition

✅ **À faire** :
- Réseaux isolés
- Health checks sur tous les services
- Resource limits
- Utilisateurs non-root
- Volumes pour données persistantes

❌ **À éviter** :
- Tous les services dans un container
- Pas de health checks
- Secrets en variables d'environnement
- Containers sans limites

### Sécurité

✅ **À faire** :
- Scanner régulièrement les images
- Utiliser des secrets management
- Limiter les capabilities
- Lire les logs
- Mettre à jour les images

❌ **À éviter** :
- `--privileged` sans raison
- Filesystem writable
- Communiquer en HTTP
- Secrets hardcodés

---

## Ressources Officielles

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Reference](https://docs.docker.com/compose/compose-file/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Docker Security](https://docs.docker.com/engine/security/)
- [Official Images](https://hub.docker.com/search?official=true)
