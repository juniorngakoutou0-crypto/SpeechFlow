# Git Best Practices

## Table of Contents
- [Commit Guidelines](#commit-guidelines)
- [Branch Strategy](#branch-strategy)
- [Collaboration](#collaboration)
- [Security](#security)
- [Performance](#performance)

## Commit Guidelines

### Commit Often, Push Regularly
- Commit logical units of work
- Each commit should represent one complete change
- Push at least once per day when working on shared branches

### Write Meaningful Commit Messages
```
feat: add user authentication system

Implement JWT-based authentication with refresh tokens.
Includes login, logout, and session management.

Fixes #123
```

**Structure**:
- **Line 1**: Type + short description (50 chars max)
- **Line 2**: Blank
- **Line 3+**: Detailed explanation (72 chars per line)

### Keep Commits Atomic
- One logical change per commit
- Can be reverted independently
- Easy to understand in isolation

### Don't Commit Half-Done Work
- Commits should be complete units
- Use `git stash` for temporary storage
- Exception: Use WIP commits on feature branches

## Branch Strategy

### Main Branch Protection
- `main` (or `master`) should always be deployable
- Require pull requests for changes
- Enable branch protection rules
- Run CI/CD before merging

### Feature Branch Workflow
```bash
# Start feature
git checkout -b feature/user-profile main

# Work and commit
git add .
git commit -m "feat: add profile page"

# Keep up-to-date
git fetch origin
git rebase origin/main

# Finish feature
git checkout main
git merge feature/user-profile
git branch -d feature/user-profile
```

### Hotfix Workflow
```bash
# Create hotfix from main
git checkout -b hotfix/critical-bug main

# Fix and commit
git commit -m "fix: resolve critical security issue"

# Merge to main
git checkout main
git merge hotfix/critical-bug

# Merge to develop if exists
git checkout develop
git merge hotfix/critical-bug

# Delete hotfix branch
git branch -d hotfix/critical-bug
```

### Branch Naming
- `feature/` - New features
- `hotfix/` - Critical production fixes
- `bugfix/` - Non-critical bug fixes
- `experiment/` - Experimental work
- `refactor/` - Code refactoring

Use lowercase with hyphens: `feature/user-authentication`

## Collaboration

### Before Pushing
```bash
# Check status
git status

# Review changes
git diff

# Test your code
npm test  # or your test command

# Pull latest changes
git pull --rebase origin main

# Push
git push
```

### Pull Request Best Practices
- Keep PRs small and focused (< 400 lines)
- Write descriptive PR titles and descriptions
- Reference related issues
- Request specific reviewers
- Respond to feedback promptly
- Keep PR branch up-to-date with main

### Code Review Guidelines
- Review within 24 hours
- Be constructive and respectful
- Focus on logic, not style (use linters)
- Approve only when ready to deploy

## Security

### Never Commit Sensitive Data
**Never commit**:
- API keys, passwords, tokens
- `.env` files with secrets
- Private keys
- Database credentials

**Use instead**:
- Environment variables
- Secret management tools (Vault, AWS Secrets Manager)
- `.gitignore` to exclude sensitive files

### Verify .gitignore
```bash
# Check what would be committed
git status

# View .gitignore
cat .gitignore
```

**Common .gitignore entries**:
```
.env
.env.local
*.key
*.pem
config/secrets.yml
node_modules/
.DS_Store
```

### Remove Accidentally Committed Secrets
```bash
# Remove from history (dangerous!)
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch path/to/secret" \
  --prune-empty --tag-name-filter cat -- --all

# Force push (coordinate with team)
git push origin --force --all

# Rotate the exposed secret immediately!
```

## Performance

### Keep Repository Clean
```bash
# Remove untracked files (dry run first)
git clean -n
git clean -f

# Remove stale branches
git remote prune origin

# Garbage collection
git gc
```

### Optimize Repository Size
```bash
# Check repository size
du -sh .git

# Aggressive garbage collection
git gc --aggressive --prune=now

# Reduce history depth (use with caution)
git fetch --depth=1
```

### Use .gitattributes
```
# Normalize line endings
* text=auto

# Treat as binary
*.png binary
*.jpg binary

# Don't diff large files
*.lock -diff
```

## Common Mistakes to Avoid

### Don't Commit to Main Directly
```bash
# Bad
git checkout main
git commit -m "fix bug"

# Good
git checkout -b hotfix/bug-description
git commit -m "fix: bug description"
# Then create PR
```

### Don't Force Push to Shared Branches
```bash
# Bad
git push --force origin main

# Good (only for your feature branches)
git push --force-with-lease origin feature/my-work
```

### Don't Mix Concerns in Commits
```bash
# Bad
git commit -m "fix login bug and add new feature and refactor auth"

# Good
git commit -m "fix: login button not responding"
git commit -m "feat: add password reset"
git commit -m "refactor: simplify auth logic"
```

### Don't Ignore Merge Conflicts
```bash
# Always resolve conflicts properly
git status  # See conflicted files
# Edit files to resolve
git add resolved-file.js
git commit -m "merge: resolve conflicts"
```

## Git Workflow Summary

**Daily workflow**:
```bash
# Morning: update your branch
git checkout main
git pull
git checkout feature/my-work
git rebase main

# During day: commit regularly
git add .
git commit -m "feat: add component"

# End of day: push
git push origin feature/my-work
```

**Feature completion**:
```bash
# Rebase on latest main
git fetch origin
git rebase origin/main

# Create pull request
gh pr create --title "feat: my feature" --body "Description"

# After approval: merge
git checkout main
git merge feature/my-work
git branch -d feature/my-work
git push
```

## Emergency Procedures

### Undo Last Commit (Keep Changes)
```bash
git reset --soft HEAD~1
```

### Undo Last Commit (Discard Changes)
```bash
git reset --hard HEAD~1
```

### Recover Deleted Commits
```bash
# Find lost commit
git reflog

# Restore it
git checkout [commit-hash]
git checkout -b recovery-branch
```

### Abort Merge
```bash
git merge --abort
```

### Abort Rebase
```bash
git rebase --abort
```

## Resources

- [Pro Git Book](https://git-scm.com/book/en/v2)
- [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/)
- [Semantic Versioning](https://semver.org/)
- [Keep a Changelog](https://keepachangelog.com/)
