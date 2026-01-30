# Workflow Intelligent - Docker Optimizer

## Phase 1: Analyse Approfondie du Projet

### 1.1 Scan Multi-niveau

```
Niveau 1: Structure du Projet
├── Détection de la stack principale
├── Identification des dépendances
├── Analyse de la taille du projet
└── Détection du type d'architecture

Niveau 2: Analyse des Dépendances
├── Graphe de dépendances
├── Versions et compatibilité
├── Détection des packages critiques
└── Identification des dépendances de build vs runtime

Niveau 3: Analyse de Performance
├── Temps de build estimé
├── Taille finale estimée
├── Goulots d'étranglement potentiels
└── Opportunités d'optimisation

Niveau 4: Analyse de Sécurité
├── Vulnérabilités connues
├── Secrets hardcodés
├── Permissions requises
└── Surface d'attaque
```

### 1.2 Questions Contextuelles Intelligentes

Le système pose des questions **uniquement si nécessaire** :

```yaml
# Détection automatique prioritaire
- Si monorepo détecté → "Voulez-vous conteneuriser tous les workspaces ou seulement certains ?"
- Si frontend + backend → "Architecture séparée ou monolithe ?"
- Si multiples environnements → "Configuration par profils ou fichiers séparés ?"
- Si base de données détectée → "Production ou dev uniquement ?"
```

### 1.3 Profil du Projet

```json
{
  "project_profile": {
    "type": "full-stack | monolith | microservices | monorepo",
    "size": "small | medium | large | enterprise",
    "complexity": "simple | moderate | complex",
    "performance_priority": "build_speed | runtime_speed | image_size | balanced",
    "environment": "dev | staging | production | all",
    "team_size": "solo | small | large"
  }
}
```

---

## Phase 2: Génération d'Architecture Optimale

### 2.1 Décisions Architecturales Automatiques

```python
def decide_architecture(project_profile):
    """
    Décide automatiquement de la meilleure architecture
    """

    # Monolithe simple
    if project_profile.type == "simple_app" and project_profile.size == "small":
        return {
            "strategy": "single_dockerfile",
            "stages": 2,  # build + runtime
            "base_image": "minimal",
            "estimated_size": "< 150MB"
        }

    # Full-stack séparé
    if has_frontend and has_backend:
        return {
            "strategy": "multi_service",
            "services": ["frontend", "backend", "database"],
            "stages": 3 per service,
            "orchestration": "docker-compose",
            "estimated_size": "< 500MB total"
        }

    # Microservices
    if project_profile.type == "microservices":
        return {
            "strategy": "distributed",
            "services": detect_services(),
            "shared_base": True,  # Image de base commune
            "service_mesh": recommend_mesh(),
            "estimated_size": "< 200MB per service"
        }

    # Monorepo
    if is_monorepo():
        return {
            "strategy": "workspace_based",
            "build_system": detect_build_tool(),  # Turborepo, Nx, etc.
            "shared_cache": True,
            "selective_build": True
        }
```

### 2.2 Sélection Intelligente d'Images de Base

```python
def select_base_image(tech_stack, priorities):
    """
    Sélectionne l'image de base optimale selon le contexte
    """

    options = {
        "node": [
            {"image": "node:22-alpine", "size": "~200MB", "use_case": "balanced"},
            {"image": "gcr.io/distroless/nodejs22", "size": "~100MB", "use_case": "production_strict"},
            {"image": "oven/bun:1-alpine", "size": "~80MB", "use_case": "performance"},
        ],
        "python": [
            {"image": "python:3.13-slim", "size": "~150MB", "use_case": "balanced"},
            {"image": "python:3.13-alpine", "size": "~100MB", "use_case": "minimal"},
            {"image": "gcr.io/distroless/python3", "size": "~80MB", "use_case": "production_strict"},
        ]
    }

    # Décision basée sur les priorités
    if priorities.image_size > priorities.compatibility:
        return min(options[tech], key=lambda x: x["size"])
    elif priorities.security > priorities.tools:
        return filter(lambda x: "distroless" in x["image"])
    else:
        return filter(lambda x: x["use_case"] == "balanced")
```

---

## Phase 3: Optimisation Multi-couches

### 3.1 Optimisation de Build

```dockerfile
# Optimisation automatique basée sur le profil

# Pour projets Node.js avec pnpm
FROM node:22-alpine AS deps
WORKDIR /app

# Cache intelligent - détection automatique du package manager
RUN corepack enable && corepack prepare pnpm@latest --activate

# Cache mount intelligent
COPY package.json pnpm-lock.yaml ./
RUN --mount=type=cache,id=pnpm,target=/root/.local/share/pnpm/store \
    pnpm install --frozen-lockfile --prod

# Pour projets avec Turborepo/Nx
FROM deps AS builder
COPY . .

# Build sélectif (seulement ce qui a changé)
RUN --mount=type=cache,target=/app/.turbo \
    pnpm turbo build --filter={app_name}

# Pour projets Python avec Poetry
FROM python:3.13-slim AS deps
WORKDIR /app

RUN pip install --no-cache-dir poetry

COPY pyproject.toml poetry.lock ./
RUN --mount=type=cache,target=/root/.cache/pypoetry \
    poetry install --no-dev --no-root

# Build avec compilation optimisée
RUN poetry build -f wheel && \
    pip install --no-cache-dir dist/*.whl
```

### 3.2 Optimisation de Taille

```python
optimization_strategies = {
    "aggressive": {
        "multi_stage": True,
        "strip_binaries": True,
        "remove_docs": True,
        "compress": True,
        "distroless": True,
        "target_size": "< 50MB"
    },
    "balanced": {
        "multi_stage": True,
        "alpine_base": True,
        "production_only": True,
        "target_size": "< 150MB"
    },
    "compatible": {
        "multi_stage": True,
        "slim_base": True,
        "cache_optimized": True,
        "target_size": "< 300MB"
    }
}

# Application automatique selon le profil
def apply_optimizations(dockerfile, strategy):
    """
    Applique les optimisations selon la stratégie choisie
    """
    if strategy == "aggressive":
        # Distroless, compression, strip
        base_image = "gcr.io/distroless/..."
        add_compression()
        strip_symbols()
    elif strategy == "balanced":
        # Alpine, production deps only
        base_image = "alpine:latest"
        production_only()

    return optimized_dockerfile
```

### 3.3 Optimisation de Performance Runtime

```dockerfile
# Optimisations runtime intelligentes

# Node.js - détection automatique du type d'app
FROM node:22-alpine AS runtime

# Si API high-performance détectée
ENV NODE_ENV=production \
    NODE_OPTIONS="--max-old-space-size=512 --enable-source-maps=false" \
    UV_THREADPOOL_SIZE=16

# Si application CPU-intensive
ENV NODE_OPTIONS="--max-old-space-size=2048 --optimize-for-size"

# Python - optimisations selon le type
FROM python:3.13-slim AS runtime

# Si ML/Data Science détecté
ENV PYTHONOPTIMIZE=2 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    OMP_NUM_THREADS=4

# Si API web détecté (FastAPI, etc.)
CMD ["gunicorn", "--workers=4", "--worker-class=uvicorn.workers.UvicornWorker", \
     "--bind=0.0.0.0:8000", "--access-logfile=-", "--error-logfile=-", \
     "--log-level=info", "main:app"]
```

---

## Phase 4: Architecture Adaptative

### 4.1 Templates par Scénario

```yaml
# Scénario 1: API Simple
scenario: simple_api
architecture:
  - Single Dockerfile multi-stage
  - Alpine base
  - Health check intelligent
  - Logs structurés
  - Resource limits auto

# Scénario 2: Full-stack avec BDD
scenario: fullstack_app
architecture:
  services:
    frontend:
      - Nginx alpine pour serving
      - Build assets en builder
      - Taille: ~50MB
    backend:
      - API runtime optimisé
      - Connexion DB pooling
      - Taille: ~150MB
    database:
      - PostgreSQL alpine
      - Volume persistence
      - Backup automatique
    cache:
      - Redis alpine
      - Eviction policy optimale

# Scénario 3: Microservices
scenario: microservices
architecture:
  base_image_shared: true
  services:
    - auth-service
    - user-service
    - payment-service
  networking:
    - Service mesh (Istio/Linkerd si >5 services)
    - Internal DNS
    - Load balancing
  observability:
    - Prometheus metrics
    - Distributed tracing
    - Centralized logging

# Scénario 4: Monorepo
scenario: monorepo
architecture:
  build_system: turborepo  # ou nx, lerna
  strategy: selective_build
  caching:
    - Remote cache (si CI/CD)
    - Shared layers
    - Build matrix
  dockerfile_per_app: true
  shared_dependencies: true
```

### 4.2 Décisions Contextuelles

```python
def make_contextual_decisions(project):
    """
    Prend des décisions intelligentes basées sur le contexte
    """

    decisions = {}

    # Décision: Utilisateur non-root
    decisions["non_root_user"] = True  # TOUJOURS

    # Décision: Read-only filesystem
    if project.type == "stateless_api":
        decisions["read_only_fs"] = True
    else:
        decisions["read_only_fs"] = False
        decisions["writable_paths"] = ["/tmp", "/app/logs"]

    # Décision: Health check
    if has_http_server():
        decisions["healthcheck"] = {
            "type": "http",
            "endpoint": detect_health_endpoint() or "/health",
            "interval": "30s"
        }
    else:
        decisions["healthcheck"] = {
            "type": "exec",
            "command": generate_health_command()
        }

    # Décision: Resource limits
    if project.profile.size == "small":
        decisions["resources"] = {
            "memory": "256M",
            "cpu": "0.5"
        }
    elif project.profile.size == "medium":
        decisions["resources"] = {
            "memory": "512M",
            "cpu": "1.0"
        }

    # Décision: Caching strategy
    if has_frequent_deploys():
        decisions["cache_strategy"] = "aggressive"
        decisions["remote_cache"] = True

    return decisions
```

---

## Phase 5: Validation et Benchmarking

### 5.1 Tests Automatiques

```python
def validate_generated_config(dockerfile, compose):
    """
    Valide la configuration générée
    """

    validations = {
        "security": [
            check_non_root_user(),
            check_no_secrets_hardcoded(),
            check_minimal_packages(),
            check_latest_tag_not_used(),
        ],
        "performance": [
            check_multi_stage(),
            check_cache_mounts(),
            check_layer_optimization(),
            estimate_build_time(),
        ],
        "size": [
            estimate_image_size(),
            check_size_threshold(),  # < 500MB warning
        ],
        "best_practices": [
            check_healthcheck_present(),
            check_signals_handled(),
            check_logs_to_stdout(),
        ]
    }

    return validation_report
```

### 5.2 Métriques et Recommandations

```python
def generate_metrics_report(build_result):
    """
    Génère un rapport avec métriques et recommandations
    """

    return {
        "build_metrics": {
            "total_size": "187MB",
            "build_time": "45s",
            "layers": 12,
            "cached_layers": 8,
            "cache_hit_rate": "67%"
        },
        "comparison": {
            "vs_baseline": "-60% size",
            "vs_best_practice": "+5% size (acceptable)",
        },
        "recommendations": [
            "✅ Taille optimale atteinte",
            "⚠️  Build time pourrait être amélioré avec remote cache",
            "✅ Sécurité: Tous les checks passés",
            "💡 Suggestion: Considérer distroless pour -40MB supplémentaires"
        ],
        "next_optimizations": [
            {
                "action": "Switch to distroless",
                "impact": "-40MB",
                "effort": "Low",
                "risk": "Low"
            },
            {
                "action": "Enable remote cache",
                "impact": "-30s build time",
                "effort": "Medium",
                "risk": "Low"
            }
        ]
    }
```

---

## Phase 6: Optimisation de Containers Existants

### 6.1 Analyse de Container Existant

```python
def analyze_existing_container(image_name):
    """
    Analyse un container/image existant et propose des optimisations
    """

    analysis = {
        "current_state": {
            "size": get_image_size(image_name),
            "layers": count_layers(image_name),
            "base_image": detect_base_image(image_name),
            "user": check_user(image_name),
            "vulnerabilities": scan_vulnerabilities(image_name),
        },
        "issues_found": [
            "❌ Running as root",
            "⚠️  Using outdated base image (node:16)",
            "❌ 23 vulnerabilities found (12 high)",
            "⚠️  Image size too large (892MB)",
            "❌ No health check defined",
            "⚠️  Unnecessary packages installed",
        ],
        "optimization_potential": {
            "size_reduction": "~600MB (-67%)",
            "security_improvement": "23 vulnerabilities → 0",
            "performance_gain": "Build 2x faster with cache mounts"
        }
    }

    return analysis

def generate_optimized_dockerfile(analysis):
    """
    Génère un Dockerfile optimisé basé sur l'analyse
    """

    # Reconstruction intelligente
    optimizations = [
        upgrade_base_image(),      # node:16 → node:22-alpine
        add_multi_stage(),         # Séparer build et runtime
        add_non_root_user(),       # Sécurité
        add_cache_mounts(),        # Performance
        remove_unnecessary_deps(), # Taille
        add_healthcheck(),         # Monitoring
    ]

    return optimized_dockerfile
```

### 6.2 Migration Progressive

```yaml
# Stratégie de migration pour containers existants

phase_1_quick_wins:
  - Update base image to latest alpine
  - Add non-root user
  - Remove dev dependencies
  - Impact: 30 minutes, -200MB, +security
  - Risk: Low

phase_2_optimization:
  - Implement multi-stage build
  - Add cache mounts
  - Optimize layer order
  - Impact: 2 hours, -400MB, 2x faster builds
  - Risk: Medium (needs testing)

phase_3_advanced:
  - Switch to distroless
  - Implement remote caching
  - Add SBOM generation
  - Impact: 1 day, -150MB, compliance ready
  - Risk: Medium (team training needed)
```

---

## Workflow Complet - Exemple

```
User: "Analyser et optimiser mon projet"
  ↓
[Phase 1: Scan Intelligent]
  ✓ Détecté: Full-stack (Next.js + FastAPI + PostgreSQL)
  ✓ Taille: Medium (~15k LOC)
  ✓ Monorepo: Turborepo détecté
  ✓ Environnement: Production
  ↓
[Phase 2: Profil Généré]
  {
    "type": "fullstack_monorepo",
    "complexity": "moderate",
    "priority": "balanced"
  }
  ↓
[Phase 3: Questions Contextuelles]
  ? "Séparer frontend/backend dans des containers différents ?" → Oui
  ? "Activer le remote caching pour Turborepo ?" → Oui
  ↓
[Phase 4: Génération Architecture]
  ✓ 3 Dockerfiles générés:
    - apps/web/Dockerfile (Next.js standalone: ~180MB)
    - apps/api/Dockerfile (FastAPI slim: ~150MB)
    - docker-compose.yml (avec PostgreSQL, Redis)
  ✓ BuildKit avec cache mounts
  ✓ Turborepo remote cache configuré
  ↓
[Phase 5: Optimisations Appliquées]
  ✓ Multi-stage builds (3 stages chacun)
  ✓ Cache mounts pour pnpm et pip
  ✓ Utilisateurs non-root
  ✓ Health checks intelligents
  ✓ Resource limits optimaux
  ↓
[Phase 6: Validation]
  ✓ Sécurité: 100% (0 vulnérabilités)
  ✓ Taille totale: 330MB (vs 1.2GB baseline = -73%)
  ✓ Build time: ~60s (avec cache: ~10s)
  ✓ Best practices: 18/18 ✓
  ↓
[Phase 7: Rapport et Recommandations]
  📊 Métriques:
    - Taille optimale atteinte ✓
    - Performance excellente ✓
    - Sécurité maximale ✓

  💡 Suggestions futures:
    1. Ajouter Prometheus metrics (-10min effort)
    2. Considérer k8s pour scaling (-1 jour migration)
    3. Activer SBOM generation (-5min setup)
```

---

## Configuration Avancée

### Enable Adaptive Mode

```yaml
# .docker-optimizer.yml (optionnel)
adaptive_mode: true

preferences:
  priority: balanced  # balanced | size | speed | security

  optimization_level: aggressive  # conservative | balanced | aggressive

  auto_detect: true

  ask_questions: minimal  # never | minimal | always

  target_metrics:
    max_image_size: 500MB
    max_build_time: 120s
    min_cache_hit_rate: 70%

  features:
    remote_cache: auto  # true | false | auto
    multi_platform: auto
    sbom_generation: true
    image_signing: false
```

Cette configuration rend le skill **vraiment intelligent** et capable de s'adapter à n'importe quel projet !
