# Recommended Project Structures

## React/Next.js

### Feature-based Structure (Recommended for large apps)
```
src/
├── features/
│   ├── auth/
│   │   ├── components/
│   │   ├── hooks/
│   │   ├── api/
│   │   ├── types.ts
│   │   └── index.ts
│   ├── dashboard/
│   └── users/
├── shared/
│   ├── components/      # Reusable UI components
│   ├── hooks/
│   ├── utils/
│   ├── types/
│   └── constants/
├── lib/                 # Third-party integrations
├── styles/
└── app/                 # Next.js App Router pages
```

### Layer-based Structure (Recommended for small-medium apps)
```
src/
├── components/
│   ├── ui/             # Reusable UI components
│   ├── forms/
│   └── layouts/
├── pages/              # or app/ for Next.js
├── hooks/
├── services/           # API calls
├── store/              # State management
├── utils/
├── types/
├── constants/
└── styles/
```

## Node.js/Express Backend

### Clean Architecture (Recommended)
```
src/
├── domain/             # Business logic
│   ├── entities/
│   ├── repositories/   # Interfaces
│   └── services/
├── application/        # Use cases
│   └── use-cases/
├── infrastructure/     # Implementation details
│   ├── database/
│   │   ├── models/
│   │   └── repositories/
│   ├── http/
│   │   ├── controllers/
│   │   ├── middlewares/
│   │   └── routes/
│   └── external/       # Third-party services
├── config/
└── shared/
    ├── errors/
    ├── types/
    └── utils/
```

### MVC Pattern (Simpler projects)
```
src/
├── controllers/
├── models/
├── routes/
├── middlewares/
├── services/           # Business logic
├── utils/
├── config/
└── validators/
```

## Python/Django

### Django Project
```
project/
├── apps/
│   ├── users/
│   │   ├── migrations/
│   │   ├── models.py
│   │   ├── views.py
│   │   ├── serializers.py
│   │   ├── urls.py
│   │   └── tests/
│   ├── products/
│   └── orders/
├── core/               # Project configuration
│   ├── settings/
│   │   ├── base.py
│   │   ├── development.py
│   │   └── production.py
│   ├── urls.py
│   └── wsgi.py
├── static/
├── media/
├── templates/
└── manage.py
```

### Flask Project
```
app/
├── api/
│   ├── v1/
│   │   ├── endpoints/
│   │   ├── schemas/
│   │   └── __init__.py
│   └── v2/
├── core/
│   ├── config.py
│   ├── security.py
│   └── database.py
├── models/
├── services/
├── utils/
└── __init__.py
```

## Python Data Science

```
project/
├── data/
│   ├── raw/            # Original, immutable data
│   ├── processed/      # Cleaned, transformed data
│   └── external/       # Third-party data
├── notebooks/          # Jupyter notebooks
│   ├── exploratory/
│   └── reports/
├── src/
│   ├── data/           # Data loading, processing
│   ├── features/       # Feature engineering
│   ├── models/         # Model training, prediction
│   ├── visualization/  # Plotting functions
│   └── utils/
├── tests/
├── models/             # Saved models
├── reports/            # Generated analysis
│   └── figures/
└── requirements.txt
```

## Java/Spring Boot

```
src/main/java/com/company/project/
├── domain/
│   ├── model/          # Entities, Value Objects
│   ├── repository/     # Repository interfaces
│   └── service/        # Domain services
├── application/
│   ├── dto/            # Data Transfer Objects
│   ├── mapper/         # DTO ↔ Entity mapping
│   └── service/        # Application services
├── infrastructure/
│   ├── persistence/    # JPA repositories implementation
│   │   ├── entity/     # JPA entities
│   │   └── repository/
│   ├── web/
│   │   ├── controller/
│   │   └── exception/  # Exception handlers
│   └── config/         # Spring configuration
└── shared/
    ├── exception/
    └── util/
```

## Go

### Standard Layout
```
project/
├── cmd/
│   └── api/            # Application entrypoints
│       └── main.go
├── internal/           # Private application code
│   ├── domain/         # Business logic
│   ├── handlers/       # HTTP handlers
│   ├── repository/     # Data access
│   ├── service/        # Business services
│   └── middleware/
├── pkg/                # Public libraries (can be imported)
│   └── utils/
├── api/                # API definitions (OpenAPI, protobuf)
├── web/                # Static assets
├── scripts/            # Build, install scripts
├── migrations/         # Database migrations
└── config/
```

## Monorepo (Multiple apps)

### Nx/Turborepo Structure
```
monorepo/
├── apps/
│   ├── web/            # Main web app
│   ├── admin/          # Admin panel
│   └── mobile/         # Mobile app
├── packages/
│   ├── ui/             # Shared UI components
│   ├── utils/          # Shared utilities
│   ├── config/         # Shared configs
│   └── types/          # Shared types
├── libs/               # Shared libraries
└── tools/              # Build tools, scripts
```

## Key Principles

### Good Structure Characteristics
1. **Clear separation of concerns**: Business logic, data access, presentation
2. **Scalable**: Easy to add new features without restructuring
3. **Consistent**: Similar features organized similarly
4. **Discoverable**: Easy to find where things belong
5. **Testable**: Structure supports testing

### Anti-Patterns to Avoid
1. **Flat structure**: Everything in one directory
2. **Deep nesting**: More than 4-5 levels deep
3. **Mixed concerns**: Business logic in UI components
4. **Type-based grouping at top level**: All controllers together, all models together
5. **Circular dependencies**: Module A imports B, B imports A

### Feature vs Layer Organization

**Use Feature-based when:**
- Large application with many features
- Teams work on specific features
- Features are relatively independent

**Use Layer-based when:**
- Small to medium application
- Clear separation of concerns needed
- Shared logic across features

**Hybrid approach:**
```
src/
├── features/           # Feature-specific code
│   ├── auth/
│   └── dashboard/
└── shared/             # Shared layers
    ├── components/
    ├── services/
    └── utils/
```
