# Dockerfiles Optimisés - Frameworks Modernes (2026)

## Table of Contents
- [Next.js](#nextjs)
- [Nuxt](#nuxt)
- [Remix](#remix)
- [SvelteKit](#sveltekit)
- [Astro](#astro)
- [Solid Start](#solid-start)

---

## Next.js

### Pattern avec standalone output (recommandé)

```dockerfile
# syntax=docker/dockerfile:1.7
FROM node:22-alpine AS base

# Installer dépendances uniquement si nécessaire
FROM base AS deps
RUN apk add --no-cache libc6-compat
WORKDIR /app

# Installer dépendances avec cache mount
COPY package.json package-lock.json* ./
RUN --mount=type=cache,target=/root/.npm \
    npm ci

# Builder
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Next.js collecte des données télémétrie anonyme
# Désactiver avec la variable suivante
ENV NEXT_TELEMETRY_DISABLED=1

# Build avec standalone output
RUN npm run build

# Runner
FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

# Créer utilisateur non-root
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001 -G nodejs

# Copier uniquement les fichiers nécessaires
COPY --from=builder /app/public ./public
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

**next.config.js** (requis pour standalone) :
```javascript
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
}

module.exports = nextConfig
```

**Taille typique** : 150-250MB (vs 500MB+ sans standalone)

---

## Nuxt

### Pattern avec Nitro output

```dockerfile
# syntax=docker/dockerfile:1.7
FROM node:22-alpine AS builder
WORKDIR /app

# Installer dépendances avec cache
COPY package.json package-lock.json* ./
RUN --mount=type=cache,target=/root/.npm \
    npm ci

# Copier source et build
COPY . .
RUN npm run build

# Image finale
FROM node:22-alpine AS runner
WORKDIR /app

# Utilisateur non-root
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nuxtjs -u 1001 -G nodejs

# Copier uniquement l'output Nitro
COPY --from=builder --chown=nuxtjs:nodejs /app/.output /app/.output

USER nuxtjs

EXPOSE 3000
ENV PORT=3000
ENV NODE_ENV=production

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/api/health', (r) => {if (r.statusCode !== 200) throw new Error()})"

CMD ["node", ".output/server/index.mjs"]
```

**Taille typique** : 150-200MB

---

## Remix

### Pattern Remix

```dockerfile
# syntax=docker/dockerfile:1.7
FROM node:22-alpine AS builder
WORKDIR /app

# Installer dépendances
COPY package.json package-lock.json* ./
RUN --mount=type=cache,target=/root/.npm \
    npm ci

# Build
COPY . .
RUN npm run build

# Production
FROM node:22-alpine AS runner
WORKDIR /app

# Utilisateur non-root
RUN addgroup -g 1001 -S nodejs && \
    adduser -S remixjs -u 1001 -G nodejs

# Copier build et node_modules production
COPY --from=builder --chown=remixjs:nodejs /app/build ./build
COPY --from=builder --chown=remixjs:nodejs /app/public ./public
COPY --from=builder --chown=remixjs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=remixjs:nodejs /app/package.json ./

USER remixjs

EXPOSE 3000
ENV NODE_ENV=production

CMD ["npm", "start"]
```

**Taille typique** : 200-250MB

---

## SvelteKit

### Pattern SvelteKit avec Node adapter

```dockerfile
# syntax=docker/dockerfile:1.7
FROM node:22-alpine AS builder
WORKDIR /app

# Installer dépendances
COPY package.json package-lock.json* ./
RUN --mount=type=cache,target=/root/.npm \
    npm ci

# Build
COPY . .
RUN npm run build

# Production
FROM node:22-alpine AS runner
WORKDIR /app

# Utilisateur non-root
RUN addgroup -g 1001 -S nodejs && \
    adduser -S sveltekit -u 1001 -G nodejs

# Copier uniquement l'output
COPY --from=builder --chown=sveltekit:nodejs /app/build ./build
COPY --from=builder --chown=sveltekit:nodejs /app/package.json ./

# Installer uniquement les dépendances de production
RUN --mount=type=cache,target=/root/.npm \
    npm ci --only=production

USER sveltekit

EXPOSE 3000
ENV NODE_ENV=production
ENV PORT=3000

CMD ["node", "build"]
```

**svelte.config.js** :
```javascript
import adapter from '@sveltejs/adapter-node';

/** @type {import('@sveltejs/kit').Config} */
const config = {
  kit: {
    adapter: adapter()
  }
};

export default config;
```

**Taille typique** : 100-150MB

---

## Astro

### Pattern Astro avec Node adapter

```dockerfile
# syntax=docker/dockerfile:1.7
FROM node:22-alpine AS builder
WORKDIR /app

# Installer dépendances
COPY package.json package-lock.json* ./
RUN --mount=type=cache,target=/root/.npm \
    npm ci

# Build
COPY . .
RUN npm run build

# Production (si SSR activé)
FROM node:22-alpine AS runner
WORKDIR /app

# Utilisateur non-root
RUN addgroup -g 1001 -S nodejs && \
    adduser -S astro -u 1001 -G nodejs

# Copier dist
COPY --from=builder --chown=astro:nodejs /app/dist ./dist
COPY --from=builder --chown=astro:nodejs /app/package.json ./

USER astro

EXPOSE 4321
ENV HOST=0.0.0.0
ENV PORT=4321

CMD ["node", "./dist/server/entry.mjs"]
```

**astro.config.mjs** (pour SSR) :
```javascript
import { defineConfig } from 'astro/config';
import node from '@astrojs/node';

export default defineConfig({
  output: 'server',
  adapter: node({
    mode: 'standalone'
  })
});
```

**Taille typique** : 120-180MB

---

## Solid Start

### Pattern Solid Start

```dockerfile
# syntax=docker/dockerfile:1.7
FROM node:22-alpine AS builder
WORKDIR /app

# Installer dépendances
COPY package.json package-lock.json* ./
RUN --mount=type=cache,target=/root/.npm \
    npm ci

# Build
COPY . .
RUN npm run build

# Production
FROM node:22-alpine AS runner
WORKDIR /app

# Utilisateur non-root
RUN addgroup -g 1001 -S nodejs && \
    adduser -S solidstart -u 1001 -G nodejs

# Copier output
COPY --from=builder --chown=solidstart:nodejs /app/.output ./output
COPY --from=builder --chown=solidstart:nodejs /app/package.json ./

USER solidstart

EXPOSE 3000
ENV NODE_ENV=production

CMD ["node", ".output/server/index.mjs"]
```

**Taille typique** : 100-150MB

---

## Comparaison des Frameworks

| Framework | Image de base | Taille finale | Build time | SSR par défaut |
|-----------|---------------|---------------|------------|----------------|
| Next.js (standalone) | node:22-alpine | 150-250MB | 60-90s | Oui |
| Nuxt (Nitro) | node:22-alpine | 150-200MB | 60-90s | Oui |
| Remix | node:22-alpine | 200-250MB | 45-60s | Oui |
| SvelteKit | node:22-alpine | 100-150MB | 30-60s | Optionnel |
| Astro | node:22-alpine | 120-180MB | 30-60s | Optionnel |
| Solid Start | node:22-alpine | 100-150MB | 30-45s | Oui |

---

## Bonnes Pratiques Multi-Framework

### 1. Utiliser le mode standalone/output optimal

Chaque framework a un mode optimisé pour production :
- **Next.js** : `output: 'standalone'`
- **Nuxt** : Nitro output (automatique)
- **SvelteKit** : `@sveltejs/adapter-node`
- **Astro** : `@astrojs/node` avec mode standalone

### 2. BuildKit cache mounts

```dockerfile
RUN --mount=type=cache,target=/root/.npm \
    npm ci
```

### 3. Multi-stage builds

Séparer build et runtime pour réduire taille

### 4. Utilisateurs non-root

Toujours créer un utilisateur dédié

### 5. Health checks

Ajouter un endpoint `/api/health` pour monitoring

### 6. Variables d'environnement

```yaml
# docker-compose.yml
services:
  app:
    environment:
      NODE_ENV: production
      DATABASE_URL: ${DATABASE_URL}
```

---

## .dockerignore Universel

```
node_modules
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.pnpm-debug.log*

.next
.nuxt
.output
.svelte-kit
dist
build

.env
.env.local
.env.*.local

.git
.gitignore
.github
.vscode
.idea

*.md
!README.md

coverage
.cache
```

---

## Exemple docker-compose.yml Multi-Framework

```yaml
version: '3.9'

services:
  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile
    ports:
      - "3000:3000"
    environment:
      NODE_ENV: production
      API_URL: http://api:8000
    depends_on:
      api:
        condition: service_healthy
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/api/health"]
      interval: 30s
      timeout: 10s
      retries: 3

  api:
    build:
      context: ./api
      dockerfile: Dockerfile
    ports:
      - "8000:8000"
    environment:
      NODE_ENV: production
      DATABASE_URL: postgresql://user:pass@db:5432/mydb
    depends_on:
      db:
        condition: service_healthy
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
      interval: 30s
      timeout: 10s
      retries: 3

  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydb
    volumes:
      - db_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  db_data:
```

---

## Ressources

- [Next.js Docker](https://nextjs.org/docs/deployment#docker-image)
- [Nuxt Deployment](https://nuxt.com/docs/getting-started/deployment)
- [SvelteKit Adapters](https://kit.svelte.dev/docs/adapters)
- [Astro Deployment](https://docs.astro.build/en/guides/deploy/)
