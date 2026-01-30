# Quick Start - Code Refactoring Skill

## Installation rapide

La skill est déjà installée dans votre projet :
```
C:\Users\junio\Desktop\my_plugins\code-refactoring\
```

## Utilisation immédiate

### Option 1 : Commande directe
```bash
/code-refactoring
```

### Option 2 : Demande naturelle
Dites simplement :
- "Analyse ce code et propose des refactorings"
- "Fais une revue de qualité de mon projet"
- "Quelles améliorations recommandes-tu ?"
- "Évalue ce code"

## Workflow en 3 étapes

### 1. Analyse automatique
La skill détecte et analyse :
- Type de projet (React, Node.js, Python, etc.)
- Problèmes de structure
- Nommage incohérent
- Code dupliqué
- Violations des bonnes pratiques

### 2. Génération de recommandations
Vous recevez des propositions détaillées avec :
1. **Priorité** : Critical, High, Medium, Low
2. **Code avant/après** : Exemples concrets
3. **Plan d'implémentation** : Étapes détaillées
4. **Estimation d'effort** : Temps et impact

### 3. Vous décidez
**Vous choisissez** quelles recommandations appliquer :
- Implémentez les changements à votre rythme
- Adaptez les suggestions à votre contexte
- Priorisez selon vos besoins

## Exemple concret

**Votre code** :
```javascript
// src/utils.js
const data = async () => {
  const result = await fetch('/api/users');
  return result.json();
}

function process(obj) {
  if (obj) {
    if (obj.age) {
      if (obj.age > 18) {
        return true;
      }
    }
  }
  return false;
}
```

**Recommandations reçues** :

### MEDIUM: Improve Naming Clarity

**File**: src/utils.js:2

**Issue**: Variable name `data` is too vague

**Recommended Change**:
```javascript
// Current
const data = async () => {
  const result = await fetch('/api/users');
  return result.json();
}

// Recommended
const fetchUserData = async () => {
  const response = await fetch('/api/users');
  return response.json();
}
```

**Changes**:
- `data` → `fetchUserData` (more descriptive function name)
- `result` → `response` (clearer variable name)

**Impact**: Better code readability
**Effort**: 2 minutes

---

### MEDIUM: Reduce Nested Conditionals

**File**: src/utils.js:8

**Issue**: Deeply nested if statements (complexity: 4)

**Current Code**:
```javascript
function process(obj) {
  if (obj) {
    if (obj.age) {
      if (obj.age > 18) {
        return true;
      }
    }
  }
  return false;
}
```

**Recommended Solution**:
```javascript
function isAdult(user) {
  return user?.age > 18;
}
```

**Changes**:
- Use optional chaining for safer property access
- Rename `process` → `isAdult` (descriptive)
- Rename `obj` → `user` (clearer)
- Simplify logic (complexity: 1)

**Benefits**:
- Easier to read and test
- Handles null/undefined safely
- More maintainable

**Effort**: 5 minutes

---

**Vous recevez** ces recommandations, puis **vous décidez** si et quand les implémenter.

## Langages supportés

✅ JavaScript/TypeScript
✅ Python
✅ Java
✅ PHP
✅ Go
✅ Ruby
✅ Rust
✅ C#

## Avantages

✅ **Sûr** - Pas de modifications automatiques
✅ **Éducatif** - Comprenez le pourquoi
✅ **Flexible** - Adaptez à votre contexte
✅ **Contrôle total** - Vous décidez quoi appliquer

## Type de rapport généré

Vous recevez un rapport structuré avec :

```markdown
# Code Refactoring Analysis Report

## Executive Summary
Overall quality: GOOD
Main issues: naming inconsistencies, some duplication

## Critical Issues (0)
No critical issues ✓

## High Priority (2)
1. Rename confusing variables (15 occurrences)
2. Extract duplicate code (5 files)

## Medium Priority (8)
[...]

## Implementation Plan
Phase 1 (This Week): Quick wins - 3 hours
Phase 2 (Next Sprint): Structural changes - 1-2 days
```

## Besoin d'aide ?

Consultez les guides de référence :
- `references/naming-conventions.md` - Conventions de nommage
- `references/code-smells.md` - Problèmes de code
- `references/best-practices.md` - Bonnes pratiques
- `references/project-structures.md` - Architectures

---

**Prêt à analyser ?** Lancez `/code-refactoring` sur votre projet !
