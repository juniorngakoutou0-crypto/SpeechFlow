# Dockerfile Patterns - Optimisés par Technologie

## Node.js / TypeScript

### Pattern basique (Express) - BuildKit optimisé

```dockerfile
# syntax=docker/dockerfile:1.7
FROM node:22-alpine AS builder
WORKDIR /app

# Copier et installer dépendances avec cache mount
COPY package*.json ./
RUN --mount=type=cache,target=/root/.npm \
    npm ci --only=production && npm cache clean --force

# Copier source et build
COPY . .
RUN npm run build

# Image finale
FROM node:22-alpine
WORKDIR /app

# Créer utilisateur non-root
RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001 -G nodejs

# Copier uniquement ce qui est nécessaire
COPY --from=builder --chown=nodejs:nodejs /app/dist ./dist
COPY --from=builder --chown=nodejs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nodejs:nodejs /app/package*.json ./

USER nodejs
EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})"

CMD ["node", "dist/index.js"]
```

### Pattern ultra-léger (distroless)

```dockerfile
FROM node:20 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# Image finale distroless (très petite)
FROM gcr.io/distroless/nodejs20-debian11
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./
COPY . .
EXPOSE 3000
CMD ["dist/index.js"]
```

### Optimisations spécifiques Node.js

- **npm ci** au lieu de `npm install` (plus rapide, lock file respecté)
- **--only=production** pour exclure devDependencies
- **npm cache clean** pour réduire la taille
- **.dockerignore** avec `node_modules`, `npm-debug.log`, `.git`

**Taille typique** : 200-300MB (alpine) vs 100MB (distroless)

---

## Bun (Runtime JavaScript ultra-rapide)

### Pattern Bun basique

```dockerfile
# syntax=docker/dockerfile:1.7
FROM oven/bun:1-alpine AS builder
WORKDIR /app

# Copier et installer dépendances avec cache
COPY package.json bun.lockb ./
RUN --mount=type=cache,target=/root/.bun/install/cache \
    bun install --frozen-lockfile --production

# Copier source
COPY . .
RUN bun build src/index.ts --outdir dist --target bun

# Image finale
FROM oven/bun:1-alpine
WORKDIR /app

# Utilisateur non-root
RUN addgroup -g 1001 -S bunuser && adduser -S bunuser -u 1001 -G bunuser

COPY --from=builder --chown=bunuser:bunuser /app/dist ./dist
COPY --from=builder --chown=bunuser:bunuser /app/node_modules ./node_modules
COPY --from=builder --chown=bunuser:bunuser /app/package.json ./

USER bunuser
EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD bun run healthcheck.ts

CMD ["bun", "run", "dist/index.js"]
```

**Taille typique** : 80-120MB

---

## Deno (Runtime TypeScript sécurisé)

### Pattern Deno

```dockerfile
# syntax=docker/dockerfile:1.7
FROM denoland/deno:alpine AS builder
WORKDIR /app

# Copier deno.json et lock file
COPY deno.json deno.lock ./
RUN deno install --frozen --lock deno.lock

# Copier source et compiler
COPY . .
RUN deno cache main.ts
RUN deno compile --allow-net --allow-read --allow-env \
    --output=app main.ts

# Image finale scratch (très léger)
FROM scratch
COPY --from=builder /app/app /app
EXPOSE 8000
CMD ["/app"]
```

**Taille typique** : 50-80MB

---

## Python / Django / FastAPI

### Pattern avec venv - BuildKit optimisé

```dockerfile
# syntax=docker/dockerfile:1.7
FROM python:3.13-slim AS builder
WORKDIR /app

# Installer dépendances système minimales
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Créer venv et installer pip packages avec cache mount
COPY requirements.txt .
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt

# Image finale
FROM python:3.13-slim
WORKDIR /app

# Utilisateur non-root
RUN useradd -m -u 1001 appuser

# Copier venv depuis builder
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH" \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Copier application
COPY --chown=appuser:appuser . .

USER appuser
EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')"

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

### Pattern Ultra-léger (Python + gunicorn)

```dockerfile
FROM python:3.11-slim
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc && rm -rf /var/lib/apt/lists/*

RUN useradd -m appuser
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=appuser:appuser . .
USER appuser

EXPOSE 8000
CMD ["gunicorn", "--workers=4", "--bind=0.0.0.0:8000", "app:app"]
```

### Optimisations spécifiques Python

- **python:X-slim** au lieu de `python:X` (300MB vs 900MB)
- **--no-cache-dir** avec pip (réduit de ~30%)
- **PYTHONDONTWRITEBYTECODE=1** (pas de .pyc)
- **PYTHONUNBUFFERED=1** (logs immédiats)
- **venv** en image builder pour réduire la finale

**Taille typique** : 150-250MB

---

## Go

### Pattern Minimal (Scratch Image)

```dockerfile
FROM golang:1.21-alpine AS builder
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o app main.go

# Image finale : scratch (très léger)
FROM scratch
COPY --from=builder /app/app /app
EXPOSE 8080
ENTRYPOINT ["/app"]
```

### Pattern avec CA certificates

```dockerfile
FROM golang:1.21-alpine AS builder
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags="-s -w" -o app .

# Image finale
FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder /app/app /app

EXPOSE 8080
CMD ["/app"]
```

### Optimisations spécifiques Go

- **CGO_ENABLED=0** pour binaire statique
- **-ldflags="-s -w"** pour réduire la taille du binaire
- **scratch image** pour taille minimale (< 50MB)
- **go mod download** en couche séparée pour caching

**Taille typique** : 10-50MB (scratch) ou 20-100MB (alpine)

---

## Java / Spring Boot

### Pattern multi-stage

```dockerfile
FROM maven:3.9-eclipse-temurin-21 AS builder
WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean package -DskipTests

# Image finale
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

RUN addgroup -g 1001 appgroup && adduser -u 1001 -S appuser -G appgroup

COPY --from=builder --chown=appuser:appgroup /app/target/*.jar app.jar

USER appuser
EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD wget -q -O- http://localhost:8080/actuator/health

ENTRYPOINT ["java", "-jar", "app.jar"]
```

### Optimisations spécifiques Java

- **maven:3.9** pour build, **eclipse-temurin:21-jre-alpine** pour runtime
- **dependency:go-offline** pour meilleur caching
- **-DskipTests** pour build plus rapide
- Alpine JRE au lieu de full JDK

**Taille typique** : 300-500MB

---

## Rust

### Pattern Cargo

```dockerfile
FROM rust:1.75-alpine AS builder
WORKDIR /app

COPY Cargo.* .
RUN mkdir src && echo "fn main() {}" > src/main.rs && cargo build --release
RUN rm -rf src

COPY . .
RUN cargo build --release

# Image finale
FROM alpine:latest
RUN apk --no-cache add ca-certificates libc6-compat

COPY --from=builder /app/target/release/app /usr/local/bin/app

EXPOSE 8080
CMD ["app"]
```

### Optimisations spécifiques Rust

- **--release** pour build optimisé
- **alpine** avec libc6-compat pour runtime
- **target caching** (dépendances avant source)

**Taille typique** : 20-100MB

---

## Patterns Génériques

### Health Check universel

```dockerfile
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:PORT/health || exit 1
```

### Utilisateur non-root universel

```dockerfile
# Pour Alpine
RUN addgroup -g 1001 -S appgroup && adduser -u 1001 -S appuser -G appgroup

# Pour Debian/Ubuntu
RUN groupadd -g 1001 appgroup && useradd -u 1001 -g appgroup appuser
```

### .dockerignore universel

```
.git
.gitignore
.github
.gitlab-ci.yml
.dockerignore
Dockerfile
docker-compose*.yml
node_modules/
npm-debug.log*
yarn-error.log*
.env*
.DS_Store
build/
dist/
coverage/
.vscode/
.idea/
*.swp
*.swo
*~
```

---

## Règles de Sélection

| Technologie | Image de base | Taille | Cas d'usage |
|---|---|---|---|
| Node.js | `node:22-alpine` | 200-300MB | Plupart des apps |
| Node.js (ultra) | `distroless/nodejs22` | 100MB | Production strict |
| Bun | `oven/bun:1-alpine` | 80-120MB | Apps ultra-rapides |
| Deno | `denoland/deno:alpine` | 50-80MB | TypeScript natif |
| Python | `python:3.13-slim` | 150-250MB | Général |
| Go | `scratch` | 10-50MB | Micro-services |
| Java | `eclipse-temurin:21-jre-alpine` | 300-500MB | Apps Spring Boot |
| Rust | `alpine:latest` | 20-100MB | Outils, daemons |

**Règle générale** : Préférer `alpine` ou `distroless` > `slim` > images de base complètes

**BuildKit** : Toujours utiliser `# syntax=docker/dockerfile:1.7` pour activer les dernières features (cache mounts, secrets, etc.)
