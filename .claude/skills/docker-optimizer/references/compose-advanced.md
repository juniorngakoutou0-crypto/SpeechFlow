# Docker Compose - Configurations Avancées

## Table of Contents
- [Structure de base](#structure-de-base)
- [Microservices](#microservices)
- [Gestion des données](#gestion-des-données)
- [Networking](#networking)
- [Variables d'environnement](#variables-denvironnement)
- [Health checks](#health-checks)
- [Resource limits](#resource-limits)

---

## Structure de base

### Version recommandée

```yaml
version: '3.9'
```

Cette version supporte :
- `depends_on` avec conditions
- `profiles` pour services optionnels
- `healthcheck` dans les services
- `networks` nommés
- Resource limits

---

## Microservices

### Architecture complète

```yaml
version: '3.9'

services:
  # Frontend
  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile
    container_name: app-frontend
    ports:
      - "3000:3000"
    environment:
      REACT_APP_API_URL: http://localhost:8000
    depends_on:
      api:
        condition: service_healthy
    networks:
      - frontend
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 10s

  # Backend API
  api:
    build:
      context: ./backend
      dockerfile: Dockerfile
    container_name: app-api
    environment:
      NODE_ENV: production
      DATABASE_URL: postgresql://user:pass@db:5432/mydb
      REDIS_URL: redis://cache:6379
    ports:
      - "8000:8000"
    depends_on:
      db:
        condition: service_healthy
      cache:
        condition: service_healthy
    networks:
      - frontend
      - backend
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
    volumes:
      - ./logs:/app/logs

  # Database
  db:
    image: postgres:16-alpine
    container_name: app-db
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydb
    ports:
      - "5432:5432"
    volumes:
      - db_data:/var/lib/postgresql/data
      - ./init-db.sql:/docker-entrypoint-initdb.d/init.sql
    networks:
      - backend
    restart: unless-stopped
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user"]
      interval: 10s
      timeout: 5s
      retries: 5

  # Cache
  cache:
    image: redis:7-alpine
    container_name: app-cache
    ports:
      - "6379:6379"
    networks:
      - backend
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5
    command: redis-server --appendonly yes

# Volumes nommés pour données persistantes
volumes:
  db_data:
    driver: local

# Réseaux personnalisés
networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
```

### Service avec multi-replicas

```yaml
services:
  api:
    build: .
    deploy:
      replicas: 3
      update_config:
        parallelism: 1
        delay: 10s
    depends_on:
      - db
```

---

## Gestion des données

### Volumes

**Volume nommé (recommandé pour données)** :
```yaml
services:
  db:
    volumes:
      - db_data:/var/lib/postgresql/data

volumes:
  db_data:
    driver: local
```

**Bind mount (dev uniquement)** :
```yaml
volumes:
  - ./src:/app/src
  - ./logs:/app/logs
```

**Volume avec driver personnalisé** :
```yaml
volumes:
  db_data:
    driver: local
    driver_opts:
      type: nfs
      o: addr=10.0.0.1,vers=4,soft,timeo=180,bg,tcp,rw
      device: ":/export/docker/data"
```

### Backup des données

Exemple de service pour backup quotidien :
```yaml
services:
  db-backup:
    image: postgres:16-alpine
    volumes:
      - db_data:/backup_source:ro
      - backups:/backups
    environment:
      PGPASSWORD: password
    command: >
      sh -c 'while true; do
        pg_dump -h db -U user mydb > /backups/backup_$(date +%Y%m%d_%H%M%S).sql;
        find /backups -name "backup_*.sql" -mtime +7 -delete;
        sleep 86400;
      done'
    depends_on:
      db:
        condition: service_healthy

volumes:
  backups:
```

---

## Networking

### Réseau personnalisé (recommandé)

```yaml
networks:
  frontend:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/16
  backend:
    driver: bridge
    ipam:
      config:
        - subnet: 172.21.0.0/16

services:
  api:
    networks:
      frontend:
        ipv4_address: 172.20.0.2
      backend:
        ipv4_address: 172.21.0.2
```

### Service sur réseau host (rare, perfs élevées)

```yaml
services:
  performance_critical:
    network_mode: host
```

### Communication intra-services

Les services se communiquent par nom :
```
api -> db:postgresql://postgres:5432
api -> cache:redis://cache:6379
```

Pas besoin d'exposer de ports pour la communication interne.

---

## Variables d'environnement

### Via fichier .env

`.env` (à la racine du projet) :
```
POSTGRES_USER=myuser
POSTGRES_PASSWORD=secure_password
NODE_ENV=production
```

`docker-compose.yml` :
```yaml
services:
  db:
    environment:
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
```

### Via fichier env-specific

`.env.production` :
```
NODE_ENV=production
DEBUG=false
```

Commande :
```bash
docker-compose --env-file .env.production up
```

### Variables locales sans fichier

```bash
export NODE_ENV=production
docker-compose up
```

### Secrets (Swarm mode)

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
```

---

## Health checks

### Pattern standard HTTP

```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
  interval: 30s
  timeout: 10s
  retries: 3
  start_period: 10s
```

### Commandes spécifiques

**PostgreSQL** :
```yaml
healthcheck:
  test: ["CMD-SHELL", "pg_isready -U postgres"]
  interval: 10s
  timeout: 5s
  retries: 5
```

**Redis** :
```yaml
healthcheck:
  test: ["CMD", "redis-cli", "ping"]
  interval: 10s
  timeout: 5s
  retries: 3
```

**MySQL** :
```yaml
healthcheck:
  test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
  interval: 10s
  timeout: 5s
  retries: 3
```

**MongoDB** :
```yaml
healthcheck:
  test: ["CMD", "mongosh", "--eval", "db.adminCommand('ping')"]
  interval: 10s
  timeout: 5s
  retries: 3
```

### Dépendances avec health checks

```yaml
services:
  api:
    depends_on:
      db:
        condition: service_healthy
      cache:
        condition: service_healthy
```

Les services `db` et `cache` doivent être `healthy` avant que `api` démarre.

---

## Resource limits

### CPU et Mémoire

```yaml
services:
  api:
    deploy:
      resources:
        limits:
          cpus: '0.5'        # Max 50% d'un CPU
          memory: 512M       # Max 512MB RAM
        reservations:
          cpus: '0.25'       # Garanti 25% d'un CPU
          memory: 256M       # Garanti 256MB RAM
```

### Limites réseau

Nécessite Docker Swarm ou équivalent :
```yaml
services:
  api:
    deploy:
      resources:
        limits:
          memswap_limit: 1G
```

### Exemple complet avec limites

```yaml
version: '3.9'

services:
  frontend:
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 256M
        reservations:
          cpus: '0.25'
          memory: 128M

  api:
    deploy:
      resources:
        limits:
          cpus: '1'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M

  db:
    deploy:
      resources:
        limits:
          cpus: '2'
          memory: 1G
        reservations:
          cpus: '1'
          memory: 512M
```

---

## Profils (services optionnels)

Services de développement seulement :
```yaml
services:
  api:
    profiles: [""]  # Toujours démarré

  api-debug:
    profiles: ["debug"]
    build:
      context: .
      target: debug

  db-admin:
    image: adminer
    profiles: ["dev"]
    ports:
      - "8080:8080"
    depends_on:
      - db
```

Commandes :
```bash
docker compose up                    # Sans profils
docker compose --profile dev up      # Avec profils dev
docker compose --profile dev --profile debug up
```

---

## Docker Compose Watch (Dev Mode)

Mode développement avec sync automatique :

```yaml
version: '3.9'

services:
  frontend:
    build: ./frontend
    develop:
      watch:
        # Sync des fichiers source (pas de rebuild)
        - action: sync
          path: ./frontend/src
          target: /app/src
          ignore:
            - node_modules/

        # Rebuild si package.json change
        - action: rebuild
          path: ./frontend/package.json

        # Sync + restart si config change
        - action: sync+restart
          path: ./frontend/vite.config.ts
          target: /app/vite.config.ts

  backend:
    build: ./backend
    develop:
      watch:
        - action: sync
          path: ./backend/src
          target: /app/src

        - action: rebuild
          path: ./backend/requirements.txt
```

Commandes :
```bash
# Lancer avec watch mode
docker compose watch

# Ou en arrière-plan
docker compose up --watch
```

---

## Override local

`docker-compose.override.yml` (ignoré par git) :
```yaml
services:
  api:
    environment:
      DEBUG: "true"
    ports:
      - "9229:9229"  # Debug port
```

Cette configuration est automatiquement mergée.

---

## Exemples complets

### Dev stack minimaliste

```yaml
version: '3.9'

services:
  api:
    build: .
    ports:
      - "3000:3000"
    environment:
      NODE_ENV: development
    volumes:
      - .:/app
    command: npm run dev

volumes: {}
networks: {}
```

### Production stack

```yaml
version: '3.9'

services:
  frontend:
    image: myapp-frontend:1.0.0
    restart: always
    depends_on:
      api:
        condition: service_healthy

  api:
    image: myapp-api:1.0.0
    restart: always
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
    depends_on:
      db:
        condition: service_healthy

  db:
    image: postgres:16-alpine
    restart: always
    volumes:
      - db_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user"]

volumes:
  db_data:
```
