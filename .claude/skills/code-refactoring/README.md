# Code Refactoring Skill

Skill professionnelle de refactoring de code avec analyse complète et recommandations détaillées.

## Installation

1. Copier le fichier `code-refactoring.skill` dans votre dossier de skills Claude
2. La skill sera automatiquement disponible lors de votre prochaine session

## Utilisation

Invoquez la skill avec une de ces commandes :

```
/code-refactoring
```

Ou simplement demandez :
- "Analyse ce code et propose des refactorings"
- "Fais une revue de code de ce projet"
- "Quelles améliorations recommandes-tu ?"
- "Évalue la qualité de ce code"
- "Propose des refactorings pour ce projet"

## Ce que fait la skill

### 1. Analyse de structure
- Évalue l'organisation des dossiers et fichiers
- Compare avec les patterns recommandés (feature-based, layer-based, etc.)
- **Propose** une meilleure hiérarchie avec plan de migration détaillé

### 2. Audit de nomenclature
- Identifie les variables mal nommées (vagues, confuses, incohérentes)
- Détecte les fonctions avec des noms non descriptifs
- Vérifie que les classes et composants suivent les conventions
- **Recommande** des renommages spécifiques avec exemples avant/après

### 3. Revue de qualité du code
- Détecte le code dupliqué avec emplacements précis
- Identifie les fonctions trop complexes ou trop longues
- Pointe les violations des bonnes pratiques
- **Suggère** des solutions concrètes avec code exemple

### 4. Rapport détaillé avec recommandations
- Résume les points forts du code
- Liste les problèmes par priorité (Critical, High, Medium, Low)
- Fournit des exemples de code avant/après pour chaque recommandation
- Propose un plan d'implémentation par phases
- Estime l'effort et l'impact de chaque changement

## Technologies supportées

- **Frontend**: React, Vue, Angular, Next.js, Svelte
- **Backend**: Node.js, Python (Django/Flask), Java (Spring Boot), PHP (Laravel), Go
- **Mobile**: React Native, Flutter
- **Data Science**: Python (Pandas, NumPy)
- **Et plus**: Ruby, Rust, C#, etc.

## Approche

La skill utilise une méthodologie d'analyse en 6 étapes :

1. **Détection** - Identification du type de projet et des technologies
2. **Analyse structurelle** - Évaluation de l'architecture et organisation
3. **Audit de nommage** - Scan des conventions et cohérence
4. **Revue qualité** - Détection de duplication, complexité, code smells
5. **Priorisation** - Classification par niveau d'urgence et impact
6. **Recommandations** - Génération de propositions actionnables avec exemples

## Mode de sortie

**La skill génère des recommandations détaillées** au lieu d'appliquer automatiquement les changements. Chaque recommandation inclut :

- ✅ **Explication claire** du problème
- ✅ **Impact** sur la qualité/maintenabilité
- ✅ **Code avant/après** avec exemples concrets
- ✅ **Étapes d'implémentation** détaillées
- ✅ **Estimation d'effort** et de bénéfices

**Vous décidez** quels changements appliquer et quand.

## Ressources incluses

La skill inclut des guides de référence pour :
- Conventions de nommage par langage (9 langages)
- Détection de code smells (catalogue complet)
- Bonnes pratiques par technologie (sécurité, performance, tests)
- Structures de projet recommandées (par framework)

## Exemple de rapport

```markdown
# Code Refactoring Analysis Report

## Project Overview
- Type: React Frontend
- Files Analyzed: 45
- Lines of Code: 3,847

## Executive Summary
Code quality is GOOD overall. Main issues: flat structure, some naming
inconsistencies, and duplicate API calls. No critical security issues found.

## Critical Issues (0)
No critical issues detected ✓

## High Priority Recommendations (3)

### 1. Migrate to Feature-Based Architecture

**Current Structure**:
```
src/
├── UserProfile.tsx
├── Dashboard.tsx
├── Login.tsx
└── api.ts
```

**Recommended Structure**:
```
src/
├── features/
│   ├── auth/
│   │   ├── components/Login.tsx
│   │   └── services/authService.ts
│   └── dashboard/
└── shared/
```

**Migration Plan**: [Detailed steps...]
**Estimated Effort**: 1-2 days
**Impact**: High - Better scalability and maintainability

### 2. Extract Duplicate API Calls to Custom Hook

**Found in**: 5 components
**Current Pattern** (repeated):
```typescript
const [user, setUser] = useState(null);
useEffect(() => {
  fetch('/api/user').then(res => res.json()).then(setUser);
}, []);
```

**Recommended Solution**:
```typescript
// Create src/hooks/useCurrentUser.ts
export function useCurrentUser() {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch('/api/user')
      .then(res => res.json())
      .then(data => {
        setUser(data);
        setLoading(false);
      });
  }, []);

  return { user, loading };
}

// Usage in components
const { user, loading } = useCurrentUser();
```

**Impact**: Reduce ~50 lines, centralize user fetching
**Estimated Effort**: 1 hour

## Medium Priority (8 items)
[...]

## Implementation Plan

### Phase 1: Quick Wins (This Week)
- Extract duplicate hooks (1 hour)
- Rename top 10 confusing variables (2 hours)

### Phase 2: Structural (Next Sprint)
- Migrate to feature-based structure (1-2 days)

## Metrics
- Issues Found: 11 (0 critical, 3 high, 8 medium)
- Potential Code Reduction: ~15%
- Estimated Total Effort: 2-3 days
```

## Avantages de l'approche par recommandations

✅ **Vous gardez le contrôle** - Décidez quoi implémenter et quand
✅ **Éducatif** - Comprenez le "pourquoi" derrière chaque suggestion
✅ **Flexible** - Adaptez les recommandations à votre contexte
✅ **Sûr** - Pas de modifications automatiques non désirées
✅ **Planifiable** - Estimations d'effort pour prioriser

## Notes

- La skill analyse sans modifier le code
- Pour les gros projets (>500 fichiers), vous pouvez spécifier un dossier à analyser
- Les recommandations sont adaptées au contexte du projet (taille, conventions existantes)
- Les exemples de code sont générés à partir du code réel du projet
