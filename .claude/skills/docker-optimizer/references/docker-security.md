# Docker Security Hardening Guide

## Table of Contents
- [Utilisateurs non-root](#utilisateurs-non-root)
- [Image security](#image-security)
- [Runtime security](#runtime-security)
- [Secrets management](#secrets-management)
- [Scanning & monitoring](#scanning--monitoring)
- [Network security](#network-security)
- [Checklist de sécurité](#checklist-de-sécurité)

---

## Utilisateurs non-root

### ❌ À ÉVITER (défaut root)

```dockerfile
FROM ubuntu:latest
RUN apt-get update && apt-get install -y myapp
# L'application roule en tant que root
CMD ["myapp"]
```

### ✅ À FAIRE (utilisateur dédié)

```dockerfile
FROM ubuntu:latest
RUN apt-get update && apt-get install -y myapp && \
    useradd -m -u 1001 appuser && \
    chown -R appuser:appuser /app
USER appuser
CMD ["myapp"]
```

### ✅ Pour Alpine

```dockerfile
FROM alpine:latest
RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup && \
    chown -R appuser:appgroup /app
USER appuser
```

### ✅ Pour Node.js

```dockerfile
FROM node:20-alpine
RUN addgroup -g 1001 -S nodejs && \
    adduser -u 1001 -S nodejs -G nodejs
COPY --chown=nodejs:nodejs . /app
USER nodejs
```

### Vérification

```bash
# Vérifier l'utilisateur
docker run --rm myimage id

# Doit afficher : uid=1001(nodejs) gid=1001(nodejs) groups=1001(nodejs)
# Pas "uid=0(root)"
```

---

## Image security

### Minimiser la surface d'attaque

**Image de base minimaliste** :
```dockerfile
# ❌ 900MB
FROM ubuntu:latest

# ✅ 200MB
FROM node:20-alpine

# ✅✅ 100MB
FROM gcr.io/distroless/nodejs20
```

### Utiliser des images officielles signées

```dockerfile
# ✅ Officiel et signé
FROM node:20-alpine

# ❌ Inconnu ou tiers
FROM random-user-image/something:latest

# ✅ Avec digest (immuable)
FROM node:20-alpine@sha256:abc123def456...
```

### Supprimer les outils inutiles

```dockerfile
FROM node:20-alpine

# ❌ Inclut curl, wget, bash
RUN apk add --no-cache curl

# ✅ Utiliser seulement si nécessaire
RUN apk add --no-cache --virtual .build-deps \
    build-essential && \
    npm install && \
    apk del .build-deps
```

### Utiliser .dockerignore

`.dockerignore` (comme `.gitignore`) :
```
.git
.github
node_modules
npm-debug.log
.env
.env.local
.DS_Store
build/
dist/
coverage/
.vscode
.idea
*.swp
*.md
test/
```

Cela réduit le contexte de build et améliore les performances.

### Mettre en cache les dépendances correctement

**❌ Mauvais caching** :
```dockerfile
FROM node:20-alpine
COPY . .
RUN npm install
RUN npm run build
```

À chaque changement de code, npm install est re-exécuté.

**✅ Bon caching** :
```dockerfile
FROM node:20-alpine
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build
```

Les dépendances sont en cache si package.json n'a pas changé.

### Scan des vulnérabilités dans l'image

```bash
# Scanner local avec Trivy
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy image myapp:latest

# Ou avec Docker scout (intégré)
docker scout cves myapp:latest
```

---

## Runtime security

### Read-only filesystem

```dockerfile
# Mode read-only sauf pour /tmp
FROM node:20-alpine
RUN mkdir -p /app/logs
VOLUME ["/app/logs"]
```

`docker-compose.yml` :
```yaml
services:
  app:
    read_only: true
    volumes:
      - /tmp
      - ./logs:/app/logs
```

### Limiter les capabilities

```dockerfile
# Droits minimum
FROM node:20-alpine
USER appuser
```

`docker-compose.yml` :
```yaml
services:
  app:
    cap_drop:
      - ALL
    cap_add:
      - NET_BIND_SERVICE
```

### Désactiver les syscalls dangereux

```bash
docker run --security-opt seccomp=restricted myapp
```

### Limiter les ressources

```yaml
services:
  app:
    deploy:
      resources:
        limits:
          cpus: '1'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M
```

### Désactiver l'escalade de privilèges

```dockerfile
# Dockerfile
USER appuser
```

`docker-compose.yml` :
```yaml
services:
  app:
    security_opt:
      - no-new-privileges:true
```

---

## Secrets management

### ❌ À ÉVITER : Secrets en dur

```dockerfile
# ❌ DANGEREUX !
ENV DATABASE_PASSWORD=my_secret_password
```

Les secrets sont visibles dans l'image via `docker inspect`.

### ✅ Secrets via variables d'environnement

`docker-compose.yml` :
```yaml
services:
  api:
    environment:
      DATABASE_PASSWORD: ${DB_PASSWORD}
```

`.env` (ignoré par git) :
```
DB_PASSWORD=my_secret_password
```

Commande :
```bash
docker-compose up
```

Docker chargera `.env` automatiquement.

### ✅ Secrets via fichiers (Swarm)

`docker-compose.yml` :
```yaml
services:
  api:
    environment:
      DB_PASSWORD_FILE: /run/secrets/db_password
    secrets:
      - db_password

secrets:
  db_password:
    file: ./secrets/db_password.txt
    # ou
    external: true  # Fourni par Docker Swarm
```

### ✅ Secrets au runtime

Fichier `init-secrets.sh` :
```bash
#!/bin/sh
export DATABASE_PASSWORD=$(cat /run/secrets/db_password)
exec node app.js
```

`Dockerfile` :
```dockerfile
COPY init-secrets.sh /
RUN chmod +x /init-secrets.sh
CMD ["/init-secrets.sh"]
```

### ✅ Utiliser un gestionnaire de secrets (prod)

Options :
- **HashiCorp Vault** - Gestion centralisée
- **AWS Secrets Manager** - Sur AWS
- **Google Secret Manager** - Sur GCP
- **Azure Key Vault** - Sur Azure

Exemple avec Vault :
```bash
# Récupérer le secret au démarrage
DBPASSWORD=$(vault kv get -field=password secret/db/prod)
export DATABASE_PASSWORD=$DBPASSWORD
```

---

## Scanning & monitoring

### Trivy (local scan)

```bash
# Scanner l'image
trivy image myapp:latest

# Exporte un rapport JSON
trivy image --format json --output report.json myapp:latest

# Scanner le filesystem
trivy fs .
```

### Docker Scout (officiel Docker)

```bash
# Vérifier les vulnérabilités
docker scout cves myapp:latest

# Recommandations
docker scout recommendations myapp:latest
```

### Snyk (CI/CD integration)

```bash
# Installer
npm install -g snyk

# Authentifier
snyk auth

# Scanner
snyk container test myapp:latest
```

### Image signing avec Cosign (recommandé 2026)

```bash
# Installer Cosign
# Download depuis https://github.com/sigstore/cosign/releases

# Générer une keypair
cosign generate-key-pair

# Signer une image
cosign sign --key cosign.key myapp:latest

# Vérifier la signature
cosign verify --key cosign.pub myapp:latest
```

### Image signing avec Notary (legacy)

```bash
# Signer une image
docker trust sign myapp:latest

# Vérifier la signature
docker trust inspect myapp:latest
```

### SBOM (Software Bill of Materials)

```bash
# Générer un SBOM avec Syft
syft myapp:latest -o spdx-json > sbom.json

# Ou avec Docker
docker sbom myapp:latest

# Scanner le SBOM pour vulnérabilités
grype sbom:./sbom.json
```

---

## Network security

### Isoler les réseaux

`docker-compose.yml` :
```yaml
networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge

services:
  frontend:
    networks:
      - frontend

  api:
    networks:
      - frontend
      - backend

  db:
    networks:
      - backend
```

Résultat :
- `frontend` ne peut pas accéder directement à `db`
- Seul `api` peut communiquer avec les deux

### Exposer uniquement les ports nécessaires

```yaml
services:
  frontend:
    ports:
      - "3000:3000"  # Exposé au public

  api:
    # Pas de ports exposés
    # Accessible seulement via `api:8000` dans le réseau

  db:
    # Pas de ports exposés
    # N'accessible que via `db:5432` dans le réseau backend
```

### Restreindre les connexions sortantes

```yaml
services:
  api:
    networks:
      - backend
    # Impossible de se connecter à l'internet
```

---

## Checklist de sécurité

### Build time

- [ ] Utiliser une image de base officielle signée
- [ ] Spécifier une version exacte (pas `latest`)
- [ ] Utiliser un digest SHA pour immuabilité : `FROM node:22@sha256:...`
- [ ] Activer BuildKit : `# syntax=docker/dockerfile:1.7`
- [ ] Utiliser cache mounts pour builds plus rapides
- [ ] Supprimer les fichiers inutiles dans .dockerignore
- [ ] Utiliser multi-stage builds pour réduire la taille
- [ ] Installer seulement les dépendances de production
- [ ] Utiliser des images minimalistes (alpine, distroless)
- [ ] Récupérer les secrets depuis des variables, pas du build
- [ ] Utiliser `--mount=type=secret` pour secrets temporaires
- [ ] Ne pas inclure de clés SSH ou certificats
- [ ] Scanner l'image avant de la pousser
- [ ] Générer un SBOM (Software Bill of Materials)

### Runtime

- [ ] L'application roule en tant qu'utilisateur non-root
- [ ] Utiliser des réseaux isolés (compose)
- [ ] Limiter les ressources CPU/RAM
- [ ] Désactiver les capabilities inutiles
- [ ] Configurer un health check
- [ ] Utiliser des volumes pour les données persistantes
- [ ] Monter le filesystem en read-only si possible
- [ ] Désactiver l'escalade de privilèges
- [ ] Ne pas utiliser `--privileged`
- [ ] Utiliser des secrets, pas des variables d'environnement pour les données sensibles

### Déploiement

- [ ] Utiliser les digests SHA au lieu de tags
- [ ] Activer le scanning des images (Docker Scout, Trivy, etc.)
- [ ] Configurer les politiques de signature d'images
- [ ] Monitorer les vulnérabilités connues
- [ ] Mettre à jour les images de base régulièrement
- [ ] Utiliser un orchestrateur (Kubernetes, Docker Swarm)
- [ ] Configurer le TLS pour les communications
- [ ] Utiliser un gestionnaire de secrets (Vault, AWS Secrets, etc.)
- [ ] Logger les accès et les changements
- [ ] Effectuer des audits de sécurité réguliers

---

## Exemple sécurisé complet

```dockerfile
FROM node:20-alpine@sha256:abc123def456

# Labels pour identification
LABEL maintainer="team@example.com"
LABEL version="1.0.0"

# Utilisateur non-root
RUN addgroup -g 1001 -S nodejs && \
    adduser -u 1001 -S nodejs -G nodejs

# Installer les dépendances
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && \
    npm cache clean --force

# Copier le code
COPY --chown=nodejs:nodejs . .

# Compiler
RUN npm run build

# Utiliser l'utilisateur non-root
USER nodejs

# Pas de privilèges
HEALTHCHECK --interval=30s CMD curl -f http://localhost:3000/health

EXPOSE 3000

CMD ["node", "dist/index.js"]
```

`docker-compose.yml` :
```yaml
version: '3.9'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    image: myapp:1.0.0@sha256:xyz
    container_name: myapp
    restart: unless-stopped
    read_only: true
    security_opt:
      - no-new-privileges:true
    cap_drop:
      - ALL
    cap_add:
      - NET_BIND_SERVICE
    deploy:
      resources:
        limits:
          cpus: '1'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M
    environment:
      NODE_ENV: production
      DATABASE_URL: ${DATABASE_URL}
    volumes:
      - /tmp
    networks:
      - app-network
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
    secrets:
      - db_password

secrets:
  db_password:
    file: ./secrets/db_password.txt

networks:
  app-network:
    driver: bridge
```

---

## Ressources supplémentaires

- [Docker Security](https://docs.docker.com/engine/security/)
- [OWASP Docker Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html)
- [CIS Docker Benchmark](https://www.cisecurity.org/benchmark/docker)
- [Aquasec Trivy](https://github.com/aquasecurity/trivy)
- [Snyk Container Security](https://snyk.io/product/container-security/)
