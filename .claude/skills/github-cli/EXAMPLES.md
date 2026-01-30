# GitHub CLI Skill - Examples

Quick reference for using the github-cli skill.

## Example Usage

### Example 1: Initialize New Project
**User**: "Je veux créer un nouveau projet"

**Claude executes**:
```bash
git init
git branch -M main
git add .
git commit -m "chore: initial commit

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
git push -u origin main
git status
```

### Example 2: Start Feature
**User**: "Je vais développer une nouvelle fonctionnalité d'authentification"

**Claude executes**:
```bash
git checkout -b feature/authentication
git pull origin main
git status
```

**Claude responds**: "Tout est bon, tu peux commencer à développer ta fonctionnalité"

### Example 3: Finish Feature
**User**: "J'ai fini ma fonctionnalité d'authentification"

**Claude executes**:
```bash
git status
git add .
git commit -m "feat: add authentication system

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
git checkout main
git pull origin main
git merge feature/authentication
git branch -d feature/authentication
git push origin --delete feature/authentication 2>/dev/null || true
git push
git status
```

### Example 4: Create Hotfix
**User**: "Je dois créer un hotfix pour le bug de login"

**Claude executes**:
```bash
git checkout main
git pull origin main
git checkout -b hotfix/login-bug
git status
```

**Claude responds**: "Hotfix créé, tu peux corriger l'erreur critique"

### Example 5: Repository Status
**User**: "Montre-moi le statut"

**Claude executes**:
```bash
echo "Current branch:"
git branch --show-current
echo "\nUncommitted changes:"
git status
echo "\nLast 5 commits:"
git log --oneline --decorate -5
echo "\nAll branches:"
git branch -a
echo "\nSync status with origin:"
git fetch
git status
```

### Example 6: Rebase on Main
**User**: "Je veux mettre à jour ma branche"

**Claude executes**:
```bash
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" = "main" ]; then
    echo "Error: Cannot rebase on main branch"
    exit 1
fi
git fetch
git rebase origin/main
git status
```

**Claude responds**: "Ta branche est à jour avec les derniers changements de main"

### Example 7: Squash Commits
**User**: "Squash mes 3 derniers commits"

**Claude guides through**:
```bash
git log --oneline -n 3
git rebase -i HEAD~3
# Interactive rebase with squash instructions
git push --force-with-lease
```

### Example 8: Create Release Tag
**User**: "Créer une release version 1.0.0"

**Claude executes**:
```bash
git tag -a v1.0.0 -m "Release 1.0.0"
git push origin v1.0.0
git tag -l
```

**Claude responds**: "Release taguée et poussée"

## Commit Message Translation

The skill automatically translates natural language to conventional commits:

| Natural Language | Commit Message |
|-----------------|----------------|
| "J'ai ajouté l'authentification" | `feat: add authentication` |
| "J'ai fixé le bug du login" | `fix: login button bug` |
| "J'ai mis à jour la documentation" | `docs: update documentation` |
| "J'ai refactorisé le code auth" | `refactor: improve auth code structure` |
| "J'ai optimisé les requêtes" | `perf: optimize database queries` |
| "J'ai ajouté des tests unitaires" | `test: add unit tests` |

## Advanced Scenarios

### Scenario: Conflict Resolution
**User**: "Il y a un conflit"

**Claude helps**:
```bash
git status
git diff
# Shows conflicted files and sections
# Guides user through resolution
# After resolution:
git add .
git commit -m "merge: resolve conflicts

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

### Scenario: Undo Last Commit
**User**: "Annule le dernier commit mais garde mes changements"

**Claude executes**:
```bash
git reset --soft HEAD~1
git status
```

### Scenario: View Commit History
**User**: "Montre-moi les 10 derniers commits"

**Claude executes**:
```bash
git log --oneline --decorate --graph -10
```

## Getting Help

To access detailed documentation:

**User**: "Comment faire un rebase?"
**Claude**: Loads `references/advanced-git-commands.md` and explains rebase

**User**: "C'est quoi Git Flow?"
**Claude**: Loads `references/git-flow-guide.md` and explains Git Flow

**User**: "Comment écrire de bons commits?"
**Claude**: Loads `references/conventional-commits.md` and explains conventional commits

## Tips

1. Use natural language - the skill understands French and English
2. Be specific about feature names for better branch/commit messages
3. The skill always validates state before operations
4. Destructive operations trigger warnings
5. All commits include Co-Authored-By attribution
