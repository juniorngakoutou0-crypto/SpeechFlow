---
name: code-refactoring
description: Comprehensive code refactoring and quality analysis with detailed recommendations. Analyzes project structure, naming conventions, code smells, and provides actionable refactoring proposals with concrete examples across all major languages and frameworks. Use this skill when users request: (1) Code review or refactoring analysis, (2) Improving code quality or readability, (3) Auditing naming conventions, (4) Evaluating project organization, (5) Detecting code smells or anti-patterns, (6) Getting refactoring recommendations with examples, (7) Code quality assessment. Works with JavaScript/TypeScript, Python, Java, PHP, Go, Ruby, Rust, and all major frameworks (React, Node.js, Django, Spring Boot, Laravel, etc.).
---

# Code Refactoring Skill

Perform professional-grade code analysis with detailed refactoring recommendations and concrete examples.

## Workflow

### 1. Project Analysis

Analyze the project to understand its context:

```bash
# Detect project type and structure
find . -name "package.json" -o -name "requirements.txt" -o -name "pom.xml" -o -name "go.mod" -o -name "Cargo.toml" -o -name "composer.json"

# Get project structure overview
tree -L 3 -I 'node_modules|venv|vendor|target|dist|build' || ls -R
```

Identify:
- Primary language and framework
- Project type (frontend, backend, full-stack, mobile, data science)
- Build tools and package manager
- Testing framework (if present)
- Current folder structure pattern

### 2. Deep Code Inspection

Systematically scan the codebase for issues across four dimensions:

#### A. Structure Analysis

Evaluate project organization:
- Check if structure follows recommended patterns for the framework (see `references/project-structures.md`)
- Identify misplaced files (UI logic in services, business logic in controllers)
- Detect circular dependencies
- Find deeply nested directories (>5 levels)
- Check for proper separation of concerns

**Common structural issues:**
- Mixed concerns (business logic + data access + UI in same file)
- Feature logic scattered across multiple directories
- Flat structure with 50+ files in one folder
- Inconsistent grouping (some features grouped, others not)

#### B. Naming Convention Audit

Scan all files for naming issues using language-specific conventions from `references/naming-conventions.md`:

1. **Variable names**:
   - Single letters (except i, j, k in loops)
   - Vague names: `data`, `temp`, `value`, `info`, `obj`
   - Abbreviations: `usrMgr`, `getUserDt`
   - Inconsistent case: mixing camelCase and snake_case

2. **Function/method names**:
   - Non-descriptive: `doStuff()`, `process()`, `handle()`
   - Missing verb: `user()` instead of `getUser()`
   - Wrong convention for language

3. **Class/component names**:
   - Wrong case for language
   - Non-descriptive: `Manager`, `Handler`, `Util`
   - Redundant suffixes: `UserClass`, `DataObject`

4. **Constants**:
   - Not using UPPER_SNAKE_CASE
   - Magic numbers without names

5. **Files**:
   - Inconsistent naming across project
   - Non-descriptive: `utils.js`, `helpers.py`

Use Grep to find patterns:
```bash
# Find single-letter variables (except loop counters)
rg '\b(const|let|var|def|func|function)\s+[a-z]\s*=' --type js --type py --type go

# Find common vague names
rg '\b(data|temp|value|info|obj|item|result)\b' --type js --type py

# Find potential naming inconsistencies
rg '(function|const|let|var)\s+[a-z]+_[a-z]+' --type js  # snake_case in JS
rg 'def [A-Z]' --type py  # PascalCase function in Python
```

#### C. Code Quality Review

Detect code smells using patterns from `references/code-smells.md`:

1. **Duplication**:
```bash
# Find duplicate code blocks (using jscpd, simian, or manual review)
npx jscpd . --min-lines 3 --min-tokens 50
```

2. **Complexity**:
   - Functions >50 lines
   - Deep nesting (>3 levels)
   - Long parameter lists (>4 params)
   - Large classes (>500 lines, >10 methods)
   - Cyclomatic complexity >10

3. **Logic issues**:
   - Complex conditionals without extraction
   - Magic numbers
   - God objects
   - Feature envy
   - Switch statement chains

4. **Commented-out code**:
```bash
rg '^\s*//' --type js  # JavaScript comments
rg '^\s*#' --type py   # Python comments
```

5. **Error handling**:
   - Empty catch blocks
   - Swallowed exceptions
   - Missing validation

#### D. Best Practices Compliance

Check adherence to best practices from `references/best-practices.md`:

**Security:**
- Hardcoded credentials or secrets
- SQL injection vulnerabilities (string concatenation in queries)
- XSS vulnerabilities (unescaped output)
- Missing input validation
- Weak authentication

**Performance:**
- N+1 queries
- Missing indexes (check models)
- Large bundle sizes (check webpack/vite config)
- No lazy loading
- Inefficient algorithms

**Testing:**
- Missing tests for critical paths
- Low test coverage
- Untestable code (tight coupling)

**Dependencies:**
- Outdated packages
- Security vulnerabilities
- Unused dependencies

### 3. Prioritization

Categorize findings into priority levels:

**CRITICAL (Fix immediately):**
- Security vulnerabilities
- Major bugs
- Blocking architectural issues (circular dependencies)
- Production-breaking code

**HIGH (Fix soon):**
- Significant code duplication (>10 occurrences)
- Poor project structure impeding development
- Widespread naming inconsistencies
- Major performance issues

**MEDIUM (Should fix):**
- Code smells (long functions, god objects)
- Missing error handling
- Inconsistent patterns
- Some naming issues

**LOW (Nice to have):**
- Minor naming improvements
- Style inconsistencies
- Small optimizations
- Documentation improvements

### 4. Generate Refactoring Recommendations

Create detailed, actionable recommendations organized by priority and category. For each issue found, provide:
- Clear explanation of the problem
- Impact on code quality/maintainability
- Concrete before/after code examples
- Step-by-step implementation guidance

#### Category 1: Critical Fixes

For security vulnerabilities, major bugs, and blocking issues:

**Format:**
```markdown
### CRITICAL: [Issue Title]

**Location**: [File:line or multiple files]
**Impact**: [Security risk / Data loss / System failure / etc.]

**Problem**:
[Clear explanation of what's wrong]

**Current Code**:
```[language]
[Actual problematic code from the project]
```

**Recommended Fix**:
```[language]
[Corrected code with proper implementation]
```

**Implementation Steps**:
1. [Step-by-step instructions]
2. [How to test the change]
3. [What to verify]
```

#### Category 2: Structural Improvements

For project organization and architecture:

**Provide:**
1. **Current structure visualization**:
```
Current:
src/
├── component1.jsx
├── component2.jsx
├── api1.js
└── utils.js
```

2. **Recommended structure**:
```
Recommended:
src/
├── features/
│   ├── auth/
│   │   ├── components/
│   │   └── services/
│   └── dashboard/
└── shared/
    ├── components/
    └── utils/
```

3. **Migration plan**:
```markdown
**Step 1**: Create new directory structure
**Step 2**: Move files by feature (start with auth)
**Step 3**: Update imports in moved files
**Step 4**: Test each feature after migration
**Step 5**: Remove old directories
```

4. **Import update examples**:
```javascript
// Before
import { Login } from '../components/Login'

// After
import { Login } from '@/features/auth/components/Login'
```

#### Category 3: Naming Improvements

For each naming issue, provide specific rename recommendations:

**Format:**
```markdown
**File**: src/services/user.ts

**Issues Found**:
1. Line 12: `const data` → Vague variable name
2. Line 45: `function process()` → Non-descriptive function name
3. Line 78: `getUserDt()` → Unclear abbreviation

**Recommended Changes**:

1. **Rename: `data` → `userData`**
   ```typescript
   // Current (line 12)
   const data = await fetch('/api/users');

   // Recommended
   const userData = await fetch('/api/users');
   ```
   **Occurrences**: 12 times in this file (lines: 12, 34, 56, 78...)
   **Find/Replace**: Use "data" → "userData" (review each occurrence)

2. **Rename: `process()` → `processUserRegistration()`**
   ```typescript
   // Current (line 45)
   function process(obj) {
     return obj.id;
   }

   // Recommended
   function processUserRegistration(user) {
     return user.id;
   }
   ```
   **Also update parameter**: `obj` → `user` for clarity
```

#### Category 4: Code Quality Improvements

**A. Duplication Elimination:**

```markdown
**Issue**: Duplicate validation logic found in 5 files

**Locations**:
- src/components/UserForm.tsx:23
- src/components/ProfileEdit.tsx:45
- src/services/userService.ts:67
- src/pages/Register.tsx:89
- src/utils/validation.ts:12

**Duplicate Code**:
```javascript
if (user.age > 18 && user.country === 'US') {
  return true;
}
```

**Recommended Solution**:

1. **Create utility function** in `src/utils/userValidation.ts`:
```javascript
export function isUSAdult(user) {
  return user?.age > 18 && user.country === 'US';
}
```

2. **Replace in each file**:
```javascript
// Before
if (user.age > 18 && user.country === 'US') {
  return true;
}

// After
import { isUSAdult } from '@/utils/userValidation';

if (isUSAdult(user)) {
  return true;
}
```

**B. Complexity Reduction:**

```markdown
**Issue**: Deeply nested conditionals in src/services/auth.ts:45

**Current Code** (Cyclomatic Complexity: 8):
```javascript
function validateUser(user) {
  if (user) {
    if (user.email) {
      if (user.age) {
        if (user.age > 18) {
          return true;
        }
      }
    }
  }
  return false;
}
```

**Recommended Refactoring** (Complexity: 2):
```javascript
function validateUser(user) {
  // Early returns for clarity
  if (!user?.email) return false;
  if (!user?.age) return false;
  return user.age > 18;
}
```

**Or with optional chaining**:
```javascript
function validateUser(user) {
  return user?.email && user?.age > 18;
}
```

**Benefits**: Easier to read, test, and maintain
```

**C. Large File Breakdown:**

```markdown
**Issue**: `src/services/userService.ts` is 847 lines (recommended: <300)

**Current Structure**:
- Lines 1-200: User CRUD operations
- Lines 201-400: Authentication logic
- Lines 401-600: Profile management
- Lines 601-847: Settings and preferences

**Recommended Split**:

Create separate services:
1. `src/services/user/userCrudService.ts` - CRUD operations
2. `src/services/user/userAuthService.ts` - Authentication
3. `src/services/user/userProfileService.ts` - Profile management
4. `src/services/user/userSettingsService.ts` - Settings
5. `src/services/user/index.ts` - Barrel export

**Barrel Export** (index.ts):
```typescript
export * from './userCrudService';
export * from './userAuthService';
export * from './userProfileService';
export * from './userSettingsService';
```

**Import Updates**:
```typescript
// Before
import { getUser, loginUser, updateProfile } from './services/userService';

// After (same imports work via barrel)
import { getUser, loginUser, updateProfile } from './services/user';
```

#### Category 5: Best Practices Application

Provide specific code improvements for each technology:

**JavaScript/TypeScript:**
```markdown
**Issue**: Using `var` declarations (src/utils/helpers.js)

**Current**:
```javascript
var count = 0;
var message = "Hello " + name;
```

**Recommended**:
```javascript
const count = 0;  // Use const for values that don't change
const message = `Hello ${name}`;  // Template literals for string interpolation
```

**Python:**
```markdown
**Issue**: Missing type hints (src/services/user_service.py)

**Current**:
```python
def get_user(user_id):
    return db.query(User).filter(User.id == user_id).first()
```

**Recommended**:
```python
from typing import Optional

def get_user(user_id: int) -> Optional[User]:
    return db.query(User).filter(User.id == user_id).first()
```

**React:**
```markdown
**Issue**: Class component usage (src/components/UserProfile.tsx)

**Current**:
```typescript
class UserProfile extends React.Component {
  state = { user: null };

  componentDidMount() {
    fetchUser().then(user => this.setState({ user }));
  }

  render() {
    return <div>{this.state.user?.name}</div>;
  }
}
```

**Recommended**:
```typescript
function UserProfile() {
  const [user, setUser] = useState(null);

  useEffect(() => {
    fetchUser().then(setUser);
  }, []);

  return <div>{user?.name}</div>;
}
```

### 5. Implementation Guidance

For each recommendation, provide:

1. **Priority Order**: Which changes to implement first
2. **Dependencies**: What needs to be done before what
3. **Testing Strategy**: How to verify each change
4. **Rollback Plan**: How to undo if something breaks

**Example Implementation Plan**:
```markdown
## Recommended Implementation Order

### Phase 1: Critical Security Fixes (Implement immediately)
1. Fix SQL injection in src/api/users.ts:45
   - Test: Try malicious input before and after
   - Verify: Check database logs for query structure

2. Remove hardcoded API keys from src/config/settings.ts:12
   - Create .env file
   - Update deployment config
   - Test: Verify app still connects to services

### Phase 2: Structural Changes (Next sprint)
1. Migrate to feature-based structure
   - Start with 'auth' feature (lowest risk)
   - Test auth flows thoroughly
   - Continue with other features one at a time

### Phase 3: Naming and Quality (Ongoing)
1. Rename top 10 most confusing variables
2. Extract 5 most duplicated code blocks
3. Simplify 3 most complex functions
```

### 6. Generate Comprehensive Report

Create a detailed report with prioritized recommendations and concrete examples.

**Report Structure:**

```markdown
# Code Refactoring Analysis Report

## Project Overview
- **Type**: [React Frontend / Node.js Backend / etc.]
- **Language**: [JavaScript/TypeScript / Python / etc.]
- **Files Analyzed**: [count]
- **Lines of Code**: [count]
- **Test Coverage**: [percentage if available]

## Executive Summary
[2-3 sentences on overall code quality and main issues found]

**Overall Code Quality**: [Excellent / Good / Fair / Needs Improvement]

**Key Findings**:
- [Number] critical issues requiring immediate attention
- [Number] structural improvements recommended
- [Number] naming inconsistencies found
- [Number] code duplication instances detected

---

## Critical Issues (Fix Immediately)

### 1. [Issue Title]
**Location**: `src/api/users.ts:45`
**Impact**: Security vulnerability - SQL injection risk

**Problem**:
User input is directly concatenated into SQL queries, allowing potential SQL injection attacks.

**Current Code**:
```typescript
const query = `SELECT * FROM users WHERE id = ${userId}`;
db.execute(query);
```

**Recommended Fix**:
```typescript
const query = 'SELECT * FROM users WHERE id = ?';
db.execute(query, [userId]);
```

**Implementation Steps**:
1. Replace string concatenation with parameterized queries
2. Update all database queries in the file (5 occurrences)
3. Test with various inputs including malicious attempts
4. Review security audit logs

---

## High Priority Recommendations

### Structure Improvements

#### 1. Migrate to Feature-Based Architecture

**Current Structure** (all files in flat hierarchy):
```
src/
├── UserProfile.tsx
├── Dashboard.tsx
├── Login.tsx
├── api.ts
├── utils.ts
└── hooks.ts
```

**Recommended Structure**:
```
src/
├── features/
│   ├── auth/
│   │   ├── components/Login.tsx
│   │   ├── hooks/useAuth.ts
│   │   └── services/authService.ts
│   ├── dashboard/
│   │   ├── components/Dashboard.tsx
│   │   └── hooks/useDashboard.ts
│   └── profile/
│       └── components/UserProfile.tsx
└── shared/
    ├── components/
    ├── hooks/
    └── utils/
```

**Migration Guide**: See "Implementation Plan" section below.

### Naming Improvements

#### Top 10 Variables Requiring Rename

1. **`data` → `userData`** (src/services/user.ts)
   - Occurrences: 12 times (lines: 12, 34, 56, 78, 90, 102, 134, 156, 178, 200, 223, 245)
   - Recommendation: Use find/replace with care, review each occurrence
   ```typescript
   // Current
   const data = await fetchUsers();

   // Recommended
   const userData = await fetchUsers();
   ```

2. **`process()` → `processUserRegistration()`** (src/utils/processor.ts:45)
   - Occurrences: 1 function definition, 8 calls across 3 files
   - Also rename parameter: `obj` → `registrationData`
   ```typescript
   // Current
   function process(obj) { ... }

   // Recommended
   function processUserRegistration(registrationData) { ... }
   ```

3-10. [Continue with other major naming issues...]

### Code Quality Issues

#### Duplication Detected

**1. User Age Validation** (Duplicated in 5 files)
- src/components/UserForm.tsx:23
- src/components/ProfileEdit.tsx:45
- src/services/userService.ts:67
- src/pages/Register.tsx:89
- src/utils/validation.ts:12

**Duplicate Code**:
```javascript
if (user.age > 18 && user.country === 'US') {
  return true;
}
```

**Recommended Solution**:
Create `src/utils/userValidation.ts`:
```javascript
export function isUSAdult(user) {
  return user?.age > 18 && user.country === 'US';
}
```

**Estimated Impact**: Reduce code by ~25 lines, improve maintainability

---

## Medium Priority Recommendations

### Complexity Reduction

#### 1. Simplify `validateUser()` in src/services/auth.ts:45

**Current** (Cyclomatic Complexity: 8):
```javascript
function validateUser(user) {
  if (user) {
    if (user.email) {
      if (user.age) {
        if (user.age > 18) {
          return true;
        }
      }
    }
  }
  return false;
}
```

**Recommended** (Complexity: 2):
```javascript
function validateUser(user) {
  return user?.email && user?.age > 18;
}
```

#### 2. Break Down Large File: userService.ts (847 lines)

**Recommendation**: Split into 4 separate services
- Estimated effort: 2-3 hours
- Benefits: Better maintainability, easier testing

[Details in the recommendations above...]

### Best Practices Application

#### JavaScript/TypeScript Improvements

**Issue**: Using `var` instead of `const`/`let` (23 occurrences)
**Files**: src/utils/helpers.js, src/services/legacy.js

**Example Fix**:
```javascript
// Current
var count = 0;

// Recommended
const count = 0;
```

#### Python Type Hints

**Issue**: Missing type hints in 15 functions
**File**: src/services/user_service.py

**Example Fix**:
```python
# Current
def get_user(user_id):
    return db.query(User).filter(User.id == user_id).first()

# Recommended
from typing import Optional

def get_user(user_id: int) -> Optional[User]:
    return db.query(User).filter(User.id == user_id).first()
```

---

## Low Priority Recommendations

- Add JSDoc comments to exported functions (15 functions)
- Consolidate similar utility functions in utils/ (5 candidates)
- Update outdated dependencies (see package.json)
- Improve error messages for better debugging
- Add prop-types to React components without TypeScript

---

## Strengths Found

✓ **Good test coverage** (78%) for critical business logic
✓ **Consistent code formatting** with Prettier/ESLint
✓ **Well-documented API** with clear endpoint descriptions
✓ **Proper error handling** in async operations

---

## Implementation Plan

### Phase 1: Critical Fixes (This Week)
**Estimated Time**: 4-6 hours

1. ✓ Fix SQL injection vulnerabilities (3 files)
   - Priority: CRITICAL
   - Test thoroughly before deploying

2. ✓ Remove hardcoded credentials
   - Create .env file
   - Update deployment documentation

### Phase 2: Structural Improvements (Next Sprint)
**Estimated Time**: 1-2 days

1. Migrate to feature-based structure
   - Start with 'auth' feature (Day 1)
   - Migrate 'dashboard' and 'profile' (Day 2)
   - Update documentation

### Phase 3: Code Quality (Ongoing)
**Estimated Time**: 1 hour per week

- Week 1: Top 10 variable renames
- Week 2: Extract duplicate code (5 utilities)
- Week 3: Simplify complex functions (top 3)
- Week 4: Best practices application

---

## Summary Metrics

**Issues Found**:
- Critical: [count]
- High: [count]
- Medium: [count]
- Low: [count]

**Estimated Impact**:
- Code reduction: ~15% (through duplication removal)
- Maintainability: Significant improvement
- Security: 3 vulnerabilities addressed
- Performance: Minimal impact (mostly code quality)

**Estimated Effort**:
- Critical fixes: 4-6 hours
- High priority: 1-2 days
- Medium priority: 3-5 days
- Low priority: Ongoing

---

## Next Actions

1. **Immediate**: Review and implement critical security fixes
2. **This Week**: Plan structural migration strategy
3. **This Sprint**: Begin implementing high-priority recommendations
4. **Ongoing**: Address medium and low priority items incrementally

## Questions for Team Discussion

1. Preferred timeline for structural migration?
2. Should we enforce type hints/annotations via linter?
3. Target test coverage percentage?
4. Any legacy code that can be removed?
```

## Key Principles

1. **Actionable over theoretical**: Every recommendation must include concrete code examples
2. **Prioritized by impact**: Critical issues first, then high-impact improvements
3. **Context-aware**: Consider project size, team conventions, framework idioms
4. **Practical over perfect**: Focus on realistic improvements, avoid over-engineering
5. **Educational**: Explain WHY each change matters, not just WHAT to change
6. **Implementation-ready**: Provide step-by-step guidance for applying recommendations

## When to Load References

- **Always load** `naming-conventions.md` when analyzing naming
- **Load** `code-smells.md` when detecting quality issues
- **Load** `best-practices.md` for technology-specific recommendations
- **Load** `project-structures.md` when proposing structural changes

## Examples

### Example 1: React App Analysis

**User request:** "Analyze and recommend refactorings for this React app"

**Process:**
1. **Detect**: React with TypeScript, Create React App, 45 files
2. **Analyze** and find issues:
   - Flat structure (all components in src/)
   - Inconsistent naming (some UserProfile.tsx, some userProfile.js)
   - Duplicate API calls in 5 components
   - Long components (>200 lines)
3. **Generate recommendations**:
   - Structural: Propose feature-based structure with migration plan
   - Naming: List 15 components to rename with before/after examples
   - Quality: Show how to extract API calls to custom hooks (with code)
   - Complexity: Demonstrate splitting large components (with examples)
4. **Report**: Detailed analysis with:
   - 3 critical issues (security, performance)
   - 12 high-priority recommendations (structure, duplication)
   - 25 medium-priority items (naming, best practices)
   - Implementation plan with time estimates

**Sample Recommendation from Report**:
```markdown
### HIGH: Extract Duplicate API Calls to Custom Hook

**Found in**: 5 components (UserProfile.tsx, Dashboard.tsx, Settings.tsx, Admin.tsx, Header.tsx)

**Current Pattern** (repeated 5 times):
```typescript
const [user, setUser] = useState(null);
useEffect(() => {
  fetch('/api/user')
    .then(res => res.json())
    .then(setUser);
}, []);
```

**Recommended Solution**:
Create `src/hooks/useCurrentUser.ts`:
```typescript
export function useCurrentUser() {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetch('/api/user')
      .then(res => res.json())
      .then(data => {
        setUser(data);
        setLoading(false);
      })
      .catch(err => {
        setError(err);
        setLoading(false);
      });
  }, []);

  return { user, loading, error };
}
```

**Usage**:
```typescript
// Replace the pattern above with:
const { user, loading, error } = useCurrentUser();
```

**Impact**: Reduce code by ~50 lines, centralize user fetching logic
```

### Example 2: Python Backend Analysis

**User request:** "Review this Flask API and suggest improvements"

**Process:**
1. **Detect**: Flask REST API, 23 files, 3,400 lines
2. **Analyze** and find issues:
   - Business logic in route handlers (15 routes)
   - Inconsistent function names (camelCase and snake_case mixed)
   - No input validation
   - Missing type hints (89% of functions)
3. **Generate recommendations**:
   - Architecture: Propose service layer extraction
   - Naming: Document 47 function renames needed
   - Security: Identify 5 endpoints needing validation
   - Type Safety: Show type hints examples for each pattern
4. **Report**: Comprehensive analysis with:
   - 2 critical issues (SQL injection, missing auth)
   - 8 high-priority recommendations (service layer, validation)
   - 15 medium-priority items (type hints, naming)
   - 3-phase implementation plan

**Sample Recommendation from Report**:
```markdown
### HIGH: Extract Service Layer from Route Handlers

**Problem**: Business logic is mixed with HTTP handling in route files

**Example - Current Code** (src/routes/users.py:23):
```python
@app.route('/users/<int:user_id>', methods=['GET'])
def get_user(user_id):
    # Business logic in route handler
    user = db.session.query(User).filter_by(id=user_id).first()
    if not user:
        return {'error': 'Not found'}, 404

    # Data transformation in route handler
    return {
        'id': user.id,
        'name': user.name,
        'email': user.email,
        'created_at': user.created_at.isoformat()
    }, 200
```

**Recommended Refactoring**:

1. **Create Service** (src/services/user_service.py):
```python
from typing import Optional
from src.models.user import User
from src.schemas.user import UserSchema

class UserService:
    @staticmethod
    def get_user_by_id(user_id: int) -> Optional[User]:
        """Retrieve user by ID."""
        return db.session.query(User).filter_by(id=user_id).first()

    @staticmethod
    def serialize_user(user: User) -> dict:
        """Convert user to dict representation."""
        return UserSchema().dump(user)
```

2. **Update Route** (src/routes/users.py):
```python
from src.services.user_service import UserService

@app.route('/users/<int:user_id>', methods=['GET'])
def get_user(user_id: int):
    user = UserService.get_user_by_id(user_id)
    if not user:
        return {'error': 'Not found'}, 404

    return UserService.serialize_user(user), 200
```

**Implementation Steps**:
1. Create `src/services/` directory
2. Extract user operations to `UserService` class
3. Update routes to use service
4. Add unit tests for service layer
5. Repeat for other domains (posts, comments, etc.)

**Benefits**:
- Easier to test business logic
- Reusable across multiple routes
- Clear separation of concerns
- Better type safety
```

## Edge Cases

- **No tests**: Note in report, mark all recommendations as "requires manual testing"
- **Large codebase (>500 files)**: Ask user to specify directory to analyze, or provide high-level overview only
- **Legacy code**: Emphasize incremental improvements, include migration strategies in recommendations
- **Multiple languages**: Analyze each with appropriate conventions, provide language-specific sections in report
- **Build failures**: Analyze anyway but prominently note in report that fixes are needed before refactoring
- **User requests specific area**: Focus analysis on that area but mention related issues in other parts
- **Minimal issues found**: Still provide report highlighting strengths and suggesting minor optimizations
