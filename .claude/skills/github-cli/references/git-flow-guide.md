# Git Flow Guide

## Table of Contents
- [Introduction](#introduction)
- [Branch Structure](#branch-structure)
- [Workflows](#workflows)
- [Feature Development](#feature-development)
- [Release Management](#release-management)
- [Hotfix Process](#hotfix-process)
- [Best Practices](#best-practices)

## Introduction

Git Flow is a branching model designed for managing releases in software projects. It defines a strict branching strategy for project development.

**Key Principles**:
- `main` branch always reflects production-ready state
- `develop` branch reflects latest development changes
- Feature branches for new development
- Release branches for release preparation
- Hotfix branches for emergency production fixes

## Branch Structure

### Main Branches

#### main (or master)
- **Purpose**: Production-ready code
- **Lifetime**: Permanent
- **Merges from**: Release branches, hotfix branches
- **Merges to**: Never (except hotfixes to develop)

```bash
git checkout main
git pull origin main
```

#### develop
- **Purpose**: Integration branch for features
- **Lifetime**: Permanent
- **Merges from**: Feature branches, release branches, hotfix branches
- **Merges to**: Release branches

```bash
git checkout develop
git pull origin develop
```

### Supporting Branches

#### feature/*
- **Purpose**: Develop new features
- **Lifetime**: Temporary (deleted after merge)
- **Branches from**: develop
- **Merges to**: develop

```bash
git checkout -b feature/user-authentication develop
```

#### release/*
- **Purpose**: Prepare production release
- **Lifetime**: Temporary (deleted after merge)
- **Branches from**: develop
- **Merges to**: main and develop

```bash
git checkout -b release/1.2.0 develop
```

#### hotfix/*
- **Purpose**: Emergency production fixes
- **Lifetime**: Temporary (deleted after merge)
- **Branches from**: main
- **Merges to**: main and develop

```bash
git checkout -b hotfix/critical-security-patch main
```

## Workflows

### Simplified Git Flow (Recommended)

For smaller teams or projects, use simplified Git Flow:

**Branches**:
- `main` - Production code
- `feature/*` - New features (branch from main)
- `hotfix/*` - Emergency fixes (branch from main)

**No `develop` branch** - Feature branches merge directly to main via pull requests.

### Full Git Flow

For larger teams with scheduled releases:

**Branches**:
- `main` - Production code
- `develop` - Integration branch
- `feature/*` - New features (branch from develop)
- `release/*` - Release preparation (branch from develop)
- `hotfix/*` - Emergency fixes (branch from main)

## Feature Development

### 1. Start Feature

```bash
# From develop (full Git Flow)
git checkout develop
git pull origin develop
git checkout -b feature/user-profile

# From main (simplified Git Flow)
git checkout main
git pull origin main
git checkout -b feature/user-profile
```

### 2. Develop Feature

```bash
# Make changes
git add .
git commit -m "feat: add user profile page"

# Keep feature updated (rebase on develop/main)
git fetch origin
git rebase origin/develop  # or origin/main
```

### 3. Finish Feature

```bash
# Full Git Flow: Merge to develop
git checkout develop
git pull origin develop
git merge --no-ff feature/user-profile
git push origin develop
git branch -d feature/user-profile

# Simplified Git Flow: Create pull request to main
git push origin feature/user-profile
# Create PR on GitHub/GitLab
```

**Use `--no-ff`** to preserve feature branch history:

```bash
# Without --no-ff (fast-forward)
*   main
|\
| * commit 3
| * commit 2
| * commit 1

# With --no-ff (preserves branch)
*   main
|\
| * feature branch
| |\
| | * commit 3
| | * commit 2
| | * commit 1
```

## Release Management

### 1. Create Release Branch

```bash
git checkout develop
git pull origin develop
git checkout -b release/1.2.0
```

### 2. Prepare Release

```bash
# Update version numbers
echo "1.2.0" > VERSION
git commit -m "chore: bump version to 1.2.0"

# Bug fixes only (no new features)
git commit -m "fix: resolve edge case in checkout"

# Update changelog
git commit -m "docs: update CHANGELOG for 1.2.0"
```

### 3. Finish Release

```bash
# Merge to main
git checkout main
git pull origin main
git merge --no-ff release/1.2.0
git tag -a v1.2.0 -m "Release version 1.2.0"
git push origin main --tags

# Merge back to develop
git checkout develop
git pull origin develop
git merge --no-ff release/1.2.0
git push origin develop

# Delete release branch
git branch -d release/1.2.0
```

## Hotfix Process

### 1. Create Hotfix Branch

```bash
git checkout main
git pull origin main
git checkout -b hotfix/security-patch
```

### 2. Fix Critical Issue

```bash
# Make fix
git add .
git commit -m "fix: patch critical security vulnerability"

# Test thoroughly
npm test
```

### 3. Finish Hotfix

```bash
# Bump version (patch)
echo "1.2.1" > VERSION
git commit -m "chore: bump version to 1.2.1"

# Merge to main
git checkout main
git pull origin main
git merge --no-ff hotfix/security-patch
git tag -a v1.2.1 -m "Hotfix 1.2.1"
git push origin main --tags

# Merge to develop (or current release branch)
git checkout develop
git pull origin develop
git merge --no-ff hotfix/security-patch
git push origin develop

# Delete hotfix branch
git branch -d hotfix/security-patch
```

## Branch Lifecycle Examples

### Example 1: Feature Development

```bash
# Day 1: Start feature
git checkout -b feature/payment-integration develop
git commit -m "feat: add payment form"

# Day 2: Continue development
git commit -m "feat: integrate Stripe API"
git rebase origin/develop  # Stay updated

# Day 3: Finish feature
git checkout develop
git merge --no-ff feature/payment-integration
git push origin develop
git branch -d feature/payment-integration
```

### Example 2: Release Cycle

```bash
# Week 1-2: Features developed on develop
git checkout develop

# Week 3: Create release branch
git checkout -b release/2.0.0 develop

# Week 3-4: Test and fix bugs
git commit -m "fix: handle empty cart scenario"
git commit -m "docs: update user guide"

# Week 4: Deploy release
git checkout main
git merge --no-ff release/2.0.0
git tag -a v2.0.0 -m "Release 2.0.0"
git push origin main --tags

git checkout develop
git merge --no-ff release/2.0.0
git push origin develop
```

### Example 3: Emergency Hotfix

```bash
# Production issue discovered
git checkout main
git checkout -b hotfix/login-crash

# Fix immediately
git commit -m "fix: resolve login crash on Safari"

# Deploy to production
git checkout main
git merge --no-ff hotfix/login-crash
git tag -a v2.0.1 -m "Hotfix 2.0.1"
git push origin main --tags

# Merge back to develop
git checkout develop
git merge --no-ff hotfix/login-crash
git push origin develop
```

## Best Practices

### Branch Naming

**Consistent naming**:
- `feature/descriptive-name` - Features
- `release/1.2.0` - Releases (semantic version)
- `hotfix/critical-bug` - Hotfixes
- Use lowercase with hyphens

### Commit Practices

- **Atomic commits**: One logical change per commit
- **Conventional commits**: Use `feat:`, `fix:`, etc.
- **Descriptive messages**: Explain what and why

### Merging Strategy

**Use `--no-ff` for important branches**:
```bash
git merge --no-ff feature/important-feature
```

**Fast-forward for trivial changes**:
```bash
git merge feature/typo-fix
```

### Keep Branches Updated

```bash
# Rebase feature on develop regularly
git checkout feature/my-feature
git fetch origin
git rebase origin/develop

# Handle conflicts
git add resolved-file.js
git rebase --continue
```

### Pull Request Workflow

1. Push feature branch
2. Create pull request
3. Code review
4. CI/CD passes
5. Merge to develop/main
6. Delete branch

```bash
git push origin feature/my-feature
# Create PR on GitHub
# After approval:
git checkout develop
git pull origin develop
git merge --no-ff feature/my-feature
git push origin develop
git branch -d feature/my-feature
git push origin --delete feature/my-feature
```

## Versioning Strategy

Use **Semantic Versioning** (SemVer):

```
MAJOR.MINOR.PATCH
  │     │     │
  │     │     └─ Bug fixes (hotfixes)
  │     └─────── New features (releases)
  └───────────── Breaking changes
```

**Examples**:
- `v1.0.0` → `v1.0.1` - Hotfix
- `v1.0.1` → `v1.1.0` - New feature release
- `v1.1.0` → `v2.0.0` - Breaking change

## Conflict Resolution

### During Merge

```bash
git merge feature/my-feature
# CONFLICT in file.js

# View conflicts
git status

# Edit file.js to resolve
# Remove conflict markers (<<<, ===, >>>)

# Mark as resolved
git add file.js
git commit -m "merge: resolve conflicts in file.js"
```

### During Rebase

```bash
git rebase develop
# CONFLICT in file.js

# Resolve conflict in file.js
git add file.js
git rebase --continue

# Or abort
git rebase --abort
```

## Common Scenarios

### Scenario 1: Feature takes too long

**Problem**: Feature branch diverged significantly from develop

**Solution**:
```bash
git checkout feature/long-feature
git fetch origin
git rebase origin/develop
# Resolve conflicts
git push --force-with-lease origin feature/long-feature
```

### Scenario 2: Bug found during release

**Problem**: Bug discovered in release branch

**Solution**:
```bash
git checkout release/1.2.0
git commit -m "fix: resolve bug found in testing"
# Continue release process
```

### Scenario 3: Hotfix during release

**Problem**: Hotfix needed while release branch exists

**Solution**:
```bash
# Create hotfix from main
git checkout -b hotfix/critical main
git commit -m "fix: critical patch"

# Merge to main
git checkout main
git merge --no-ff hotfix/critical
git tag -a v1.1.1 -m "Hotfix 1.1.1"

# Merge to BOTH develop and release
git checkout develop
git merge --no-ff hotfix/critical

git checkout release/1.2.0
git merge --no-ff hotfix/critical
```

### Scenario 4: Abandon feature

**Problem**: Feature no longer needed

**Solution**:
```bash
git checkout develop
git branch -D feature/abandoned-feature
git push origin --delete feature/abandoned-feature
```

## Git Flow vs GitHub Flow

### Git Flow
- Multiple long-lived branches (main, develop)
- Scheduled releases
- Release branches
- Best for: Traditional software with release cycles

### GitHub Flow
- Single long-lived branch (main)
- Continuous deployment
- No release branches
- Best for: Web apps with continuous deployment

**Choose based on deployment strategy**:
- **Scheduled releases**: Use Git Flow
- **Continuous deployment**: Use GitHub Flow (simplified)

## Tools

### Git Flow Extension

```bash
# Install
brew install git-flow  # macOS
apt-get install git-flow  # Linux

# Initialize
git flow init

# Start feature
git flow feature start user-profile

# Finish feature
git flow feature finish user-profile

# Start release
git flow release start 1.2.0

# Finish release
git flow release finish 1.2.0
```

### Visualization

```bash
# View branch graph
git log --graph --oneline --all --decorate

# Better visualization
git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
```

## Quick Reference

**Feature**:
```bash
git checkout -b feature/name develop
# ... develop ...
git checkout develop
git merge --no-ff feature/name
```

**Release**:
```bash
git checkout -b release/1.2.0 develop
# ... prepare ...
git checkout main
git merge --no-ff release/1.2.0
git tag -a v1.2.0
```

**Hotfix**:
```bash
git checkout -b hotfix/bug main
# ... fix ...
git checkout main
git merge --no-ff hotfix/bug
git tag -a v1.1.1
git checkout develop
git merge --no-ff hotfix/bug
```
