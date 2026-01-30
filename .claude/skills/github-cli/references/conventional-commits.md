# Conventional Commits

## Table of Contents
- [Format](#format)
- [Commit Types](#commit-types)
- [Examples](#examples)
- [Scopes](#scopes)
- [Breaking Changes](#breaking-changes)
- [Tools](#tools)

## Format

Conventional Commits follow this structure:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Example**:
```
feat(auth): add JWT authentication

Implement token-based authentication using JWT.
Includes login, logout, and token refresh endpoints.

Fixes #123
BREAKING CHANGE: Auth API now requires Bearer token
```

## Commit Types

### feat
**New features or functionality**

```bash
feat: add user registration form
feat(api): add GET /users endpoint
feat: implement dark mode toggle
```

Use when:
- Adding new features
- Implementing new capabilities
- Creating new components

### fix
**Bug fixes**

```bash
fix: resolve login button not responding
fix(database): prevent SQL injection in query
fix: correct calculation in checkout total
```

Use when:
- Fixing bugs
- Resolving errors
- Patching issues

### docs
**Documentation changes**

```bash
docs: update API documentation
docs(readme): add installation instructions
docs: fix typos in contribution guide
```

Use when:
- Updating README
- Writing/updating docs
- Adding code comments
- Fixing documentation errors

### style
**Code style changes (formatting, whitespace)**

```bash
style: format code with prettier
style: fix indentation in auth module
style: remove trailing whitespace
```

Use when:
- Formatting code
- Fixing whitespace
- Organizing imports
- **NOT for CSS/UI changes** (use `feat` or `fix`)

### refactor
**Code refactoring (no functional changes)**

```bash
refactor: simplify authentication logic
refactor(api): extract validation into middleware
refactor: rename getUserData to fetchUserProfile
```

Use when:
- Restructuring code
- Improving code quality
- Renaming variables/functions
- Extracting functions
- No behavior changes

### perf
**Performance improvements**

```bash
perf: optimize database queries
perf(images): implement lazy loading
perf: reduce bundle size by 40%
```

Use when:
- Improving speed
- Reducing memory usage
- Optimizing algorithms
- Reducing bundle size

### test
**Adding or updating tests**

```bash
test: add unit tests for auth service
test(api): add integration tests for users endpoint
test: fix flaky test in checkout flow
```

Use when:
- Adding new tests
- Updating existing tests
- Fixing test failures
- Improving test coverage

### build
**Build system or dependency changes**

```bash
build: update webpack to v5
build(deps): upgrade react to 18.2.0
build: configure esbuild for production
```

Use when:
- Updating dependencies
- Changing build configuration
- Modifying bundler settings
- Updating package.json

### ci
**CI/CD configuration changes**

```bash
ci: add GitHub Actions workflow
ci(deploy): update production deployment script
ci: configure automated testing on PR
```

Use when:
- Updating CI/CD pipelines
- Changing deployment scripts
- Modifying GitHub Actions
- Configuring automated tests

### chore
**Maintenance tasks, no production code change**

```bash
chore: update .gitignore
chore: configure prettier
chore: organize project structure
```

Use when:
- Updating tooling
- Configuration files
- Maintenance tasks
- No code changes

### revert
**Reverting previous commits**

```bash
revert: feat: add user registration form

This reverts commit 1234567.
```

Use when:
- Undoing previous commits
- Rolling back changes

## Examples

### Simple Commit
```bash
git commit -m "feat: add logout button"
```

### With Scope
```bash
git commit -m "fix(auth): prevent token expiration error"
```

### With Body
```bash
git commit -m "feat(api): add pagination to users endpoint

Implement cursor-based pagination for better performance.
Returns 50 users per page by default.

Closes #456"
```

### With Breaking Change
```bash
git commit -m "feat(auth)!: change authentication method

BREAKING CHANGE: Switch from session-based to JWT authentication.
All existing sessions will be invalidated."
```

## Scopes

Scopes provide additional context about which part of the codebase is affected.

**Common scopes**:
- `(auth)` - Authentication
- `(api)` - API endpoints
- `(database)` - Database
- `(ui)` - User interface
- `(config)` - Configuration
- `(deps)` - Dependencies

**Examples**:
```bash
feat(auth): add password reset
fix(api): handle 404 errors correctly
refactor(database): optimize query performance
style(ui): update button styling
```

**Scope is optional** - use when it adds clarity.

## Breaking Changes

Breaking changes **must** be indicated in commits:

### Method 1: ! after type/scope
```bash
feat!: change API response format
fix(auth)!: require email verification
```

### Method 2: BREAKING CHANGE in footer
```bash
feat(api): add new user endpoint

BREAKING CHANGE: /api/users now requires authentication
```

### Both methods together (most clear)
```bash
feat(auth)!: switch to JWT authentication

BREAKING CHANGE: Session-based auth is removed.
All users must re-authenticate.
```

## Multi-line Commits

Use heredoc for multi-line commits:

```bash
git commit -m "$(cat <<'EOF'
feat(auth): implement two-factor authentication

Add 2FA support using TOTP (Time-based One-Time Password).
Users can enable 2FA in account settings.

Features:
- QR code generation for authenticator apps
- Backup codes for account recovery
- Optional 2FA enforcement

Closes #789

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
EOF
)"
```

## Commit Message Guidelines

### Description (first line)
- **50 characters max**
- Lowercase (except proper nouns)
- No period at the end
- Imperative mood ("add" not "added" or "adds")
- Clear and descriptive

**Good**:
```
feat: add user profile page
fix: resolve memory leak in worker
docs: update installation guide
```

**Bad**:
```
feat: Added a new user profile page with lots of features.
fix: fixed bug
docs: Update docs
```

### Body (optional)
- **72 characters per line**
- Explain **what** and **why**, not **how**
- Separate from description with blank line

**Example**:
```
refactor: simplify authentication middleware

The previous implementation was overly complex with nested
callbacks. This refactor uses async/await for better
readability and error handling.

No functional changes to authentication logic.
```

### Footer (optional)
- Reference issues: `Fixes #123`, `Closes #456`, `Refs #789`
- Breaking changes: `BREAKING CHANGE: description`
- Co-authors: `Co-Authored-By: Name <email>`

## Automatic Commit Message Generation

Based on user's natural language description:

**User says** → **Commit message**

| User Input | Commit Message |
|------------|----------------|
| "J'ai ajouté l'authentification" | `feat: add authentication` |
| "J'ai fixé le bug du login" | `fix: login button bug` |
| "J'ai mis à jour la doc" | `docs: update documentation` |
| "J'ai refactorisé le code" | `refactor: improve code structure` |
| "J'ai ajouté des tests" | `test: add unit tests` |
| "J'ai optimisé les performances" | `perf: optimize performance` |

### Mapping Rules

**Keywords → Types**:
- "ajouté", "créé", "nouveau" → `feat:`
- "fixé", "corrigé", "résolu" → `fix:`
- "mis à jour doc", "documenté" → `docs:`
- "refactorisé", "restructuré" → `refactor:`
- "optimisé", "amélioré perf" → `perf:`
- "ajouté tests" → `test:`

## Tools

### Commitlint
Validates commit messages:

```bash
npm install --save-dev @commitlint/{config-conventional,cli}

# .commitlintrc.json
{
  "extends": ["@commitlint/config-conventional"]
}
```

### Commitizen
Interactive commit message builder:

```bash
npm install --save-dev commitizen cz-conventional-changelog

# Use it
npx cz
```

### Husky
Git hooks for validation:

```bash
npm install --save-dev husky

# .husky/commit-msg
npx --no -- commitlint --edit $1
```

## Semantic Versioning

Conventional commits enable automatic versioning:

- `fix:` → Patch version (0.0.X)
- `feat:` → Minor version (0.X.0)
- `BREAKING CHANGE:` → Major version (X.0.0)

**Example**:
```
v1.2.3
   │ │ │
   │ │ └─ fix: commits
   │ └─── feat: commits
   └───── BREAKING CHANGE: commits
```

## Changelog Generation

Automatically generate changelogs from commits:

```bash
# Install
npm install --save-dev standard-version

# Generate changelog
npx standard-version
```

**Generated CHANGELOG.md**:
```markdown
# Changelog

## [1.2.0] - 2026-01-30

### Features
- add user profile page
- implement dark mode

### Bug Fixes
- resolve login button issue
- fix memory leak in worker

### BREAKING CHANGES
- authentication now requires JWT tokens
```

## Best Practices

1. **One commit = one logical change**
2. **Write in imperative mood** ("add" not "added")
3. **Keep first line under 50 chars**
4. **Use body for detailed explanation**
5. **Reference issues in footer**
6. **Indicate breaking changes clearly**
7. **Be consistent across project**

## Common Mistakes

### Too Vague
```bash
# Bad
fix: bug fix
feat: new feature

# Good
fix: resolve login timeout after 5 minutes
feat: add email notifications for new messages
```

### Wrong Type
```bash
# Bad
feat: fix typo in README

# Good
docs: fix typo in README
```

### Too Long
```bash
# Bad
feat: add user authentication with JWT tokens and refresh tokens and login and logout endpoints

# Good
feat: add JWT authentication

Implement token-based auth with refresh tokens.
Includes login and logout endpoints.
```

## Quick Reference

```
feat      - New feature
fix       - Bug fix
docs      - Documentation
style     - Code style (formatting)
refactor  - Code refactoring
perf      - Performance improvement
test      - Tests
build     - Build/dependencies
ci        - CI/CD configuration
chore     - Maintenance
revert    - Revert commit
```

**Format**: `<type>[scope]: <description>`

**Breaking change**: Add `!` or `BREAKING CHANGE:` footer
