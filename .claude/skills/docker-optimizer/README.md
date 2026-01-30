# Docker Optimizer Skill

Génération automatique de configurations Docker optimisées pour vos projets.

## 🎯 Qu'est-ce que c'est ?

Un skill Claude qui analyse votre projet ou vos spécifications et génère automatiquement des configurations Docker ultra-optimisées avec les meilleures pratiques actuelles (2026).

**Principales capacités** :
- 🔍 Détection automatique de la stack technologique
- 🐳 Génération de Dockerfiles multi-stage optimisés
- 🎼 Création de docker-compose.yml (dev + production)
- 🔒 Sécurité intégrée (non-root, scan vulnérabilités)
- 📦 Réduction de taille d'images jusqu'à 70%
- 📚 Consultation automatique de la documentation officielle (Context7)

## 🚀 Utilisation Rapide

### Mode 1 : Depuis vos fichiers de spécifications

Générez l'architecture Docker **avant même d'écrire le code** :

```
Générer architecture Docker depuis mes fichiers bl.md et architecture.md
```

**Résultat** : Fichier `Architecture-docker.md` complet avec tous les Dockerfiles, docker-compose, configurations, etc.

### Mode 2 : Depuis un projet existant

Analysez et conteneurisez un projet existant :

```
Analyser et conteneuriser mon projet dans ./mon-app
```

**Résultat** : Dockerfiles optimisés, docker-compose.yml, .dockerignore, configurations.

### Mode 3 : Optimiser des containers existants

Améliorez vos configurations Docker actuelles :

```
Analyser et optimiser mon Dockerfile
```

**Résultat** : Rapport d'optimisations + Dockerfile amélioré.

## 💡 Exemples

**Full-stack Next.js + API** :
```
Générer architecture Docker pour mon app Next.js avec API Node.js et PostgreSQL
```

**Microservices** :
```
Conteneuriser mon architecture microservices
```

**Monorepo Turborepo** :
```
Analyser mon monorepo Turborepo et générer l'architecture Docker
```

## ✨ Fonctionnalités Clés

### 🆕 Mode Spécifications (Nouveau!)
- Créez l'architecture Docker depuis vos documents de planification
- Pas besoin de code source
- Parfait pour la phase de conception

### 📚 Documentation Officielle (Context7)
- Consultation automatique de la doc officielle des technologies
- Best practices toujours à jour (2026)
- Configurations validées par les mainteneurs

### ⚡ Optimisations Automatiques
- Multi-stage builds
- Images minimales (alpine, distroless)
- Cache mounts pour builds rapides
- Utilisateurs non-root
- Health checks intelligents

## 🎨 Stack Supportées

**Frontend** : Next.js, Nuxt, Remix, SvelteKit, React, Vue, Angular

**Backend** : Node.js, Python, FastAPI, Django, Go, Rust, Java

**Databases** : PostgreSQL, MongoDB, Redis, MySQL

**Tools** : Turborepo, Nx, Docker Compose, Bun, Deno

## 📊 Résultats Typiques

| Projet | Avant | Après | Gain |
|--------|-------|-------|------|
| Next.js app | 500MB | 180MB | -64% |
| FastAPI API | 600MB | 220MB | -63% |
| Full-stack | 1.2GB | 350MB | -71% |

**Build time** : Réduction de 50-70% avec cache mounts

## 📖 Documentation

- **Guide rapide** : `assets/QUICK-START.md`
- **Guide complet** : `USAGE-GUIDE.md`
- **Exemples** : `assets/MODE-SPECS-EXAMPLE.md`
- **Context7** : `references/context7-integration.md`
- **Changelog** : `CHANGELOG.md`

## 🔧 Bonnes Pratiques Appliquées

✅ Multi-stage builds (réduction de taille)
✅ Utilisateurs non-root (sécurité)
✅ Health checks (monitoring)
✅ Cache mounts BuildKit (performance)
✅ Images minimales (alpine/distroless)
✅ Secrets via ENV (pas de hardcoding)
✅ Resource limits (stabilité)
✅ Scan de vulnérabilités

## 🆘 Besoin d'Aide ?

**Démarrage rapide** :
```
Consulter le guide de démarrage rapide
```

**Question spécifique** :
```
Comment optimiser la taille de mon image Docker ?
Comment ajouter un health check ?
Comment configurer pour la production ?
```

## 📝 Version

**Version actuelle** : 2.2 (2026-01-30)

**Nouveautés** :
- Mode génération depuis spécifications
- Intégration Context7 pour documentation officielle
- Workflow adaptatif intelligent

---

**Prêt à optimiser vos containers ?** 🐳🚀

Demandez simplement : `Générer architecture Docker depuis mes fichiers` ou `Analyser mon projet`
