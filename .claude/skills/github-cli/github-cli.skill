---
name: github-cli
description: Automate Git workflows and GitHub operations following best practices. Use when the user wants to: (1) Initialize a new project, (2) Start/finish features with feature branches, (3) Create/complete hotfixes, (4) Check repository status, (5) Switch branches, (6) Rebase or sync with main, (7) Undo commits, (8) View commit history, (9) Resolve merge conflicts, (10) Create experimental branches, (11) Squash commits, (12) Create release tags, (13) View commit changes, (14) Create/manage pull requests, (15) Manage GitHub issues, (16) View/trigger GitHub Actions, (17) Create releases, or any Git/GitHub workflow automation task.
---

# GitHub CLI Skill

Automate Git workflows and GitHub operations with best practices, conventional commits, Git Flow methodology, and GitHub CLI integration.

## GitHub CLI Integration

This skill uses the `gh` command (GitHub CLI) for all GitHub-related operations. The GitHub CLI is already installed on your system.

### Available GitHub CLI Commands

- **Pull Requests**: Create, view, merge, review PRs
- **Issues**: Create, list, view, close issues
- **Actions**: View workflows, runs, and trigger actions
- **Releases**: Create and manage releases
- **Repositories**: Clone, view, fork repositories
- **Gists**: Create and manage gists

### Documentation via MCP Context7

**IMPORTANT**: For any documentation needs, use the MCP context7 server to fetch the latest documentation:

- **GitHub CLI documentation**: Request via context7 for `gh` commands
- **Git documentation**: Request via context7 for Git concepts
- **GitHub API documentation**: Request via context7 for API references

When a user asks for help or documentation, use context7 to fetch current information instead of relying on static files.

## Core Workflow Patterns

Before executing any Git operation, **always validate current state**:
- Check `git status` for uncommitted changes
- Verify current branch with `git branch --show-current`
- Check if changes are staged with `git diff --staged`

### Pattern 1: Initialize New Project

**Triggers**: "Je veux créer un nouveau projet", "Initialize project", "Nouveau projet"

**Actions**:
1. Initialize Git repository
2. Set main branch as default
3. Create initial commit
4. Push to origin
5. Show final status

**Execution**:
```bash
git init
git branch -M main
git add .
git commit -m "chore: initial commit

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
git push -u origin main
git status
```

### Pattern 2: Start Feature Development

**Triggers**: "Je vais développer une nouvelle fonctionnalité", "Start feature", "Nouvelle feature", "Je vais coder une feature"

**Actions**:
1. Create feature branch (feature/descriptive-name)
2. Switch to feature branch
3. Pull latest changes
4. Confirm ready to develop

**Execution**:
```bash
# Ask user for feature name if not provided
git checkout -b feature/[feature-name]
git pull origin main
git status
```

Respond: "Tout est bon, tu peux commencer à développer ta fonctionnalité"

### Pattern 3: Finish Feature Development

**Triggers**: "J'ai fini de développer ma fonctionnalité", "Feature done", "Finish feature", "J'ai terminé"

**Actions**:
1. Validate changes exist
2. Commit changes with conventional commit message
3. Switch to main branch
4. Merge feature branch
5. Delete local and remote feature branch
6. Push to origin
7. Show completion status

**Execution**:
```bash
git status
# If changes exist:
git add .
git commit -m "feat: [description]

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
git checkout main
git pull origin main
git merge feature/[feature-name]
git branch -d feature/[feature-name]
git push origin --delete feature/[feature-name] 2>/dev/null || true
git push
git status
```

### Pattern 4: Create Hotfix

**Triggers**: "Je dois créer un hotfix", "Hotfix urgent", "Critical bug", "Fix production"

**Actions**:
1. Switch to main branch
2. Pull latest changes
3. Create hotfix branch (hotfix/bug-description)
4. Confirm ready for fix

**Execution**:
```bash
git checkout main
git pull origin main
git checkout -b hotfix/[bug-name]
git status
```

Respond: "Hotfix créé, tu peux corriger l'erreur critique"

### Pattern 5: Complete Hotfix

**Triggers**: "Le hotfix est prêt", "Hotfix done", "Critical fix complete"

**Actions**:
1. Commit hotfix
2. Return to main
3. Pull latest changes
4. Merge hotfix
5. Delete local and remote hotfix branch
6. Push changes
7. Show completion

**Execution**:
```bash
git add .
git commit -m "fix: [critical-description]

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
git checkout main
git pull origin main
git merge hotfix/[bug-name]
git branch -d hotfix/[bug-name]
git push origin --delete hotfix/[bug-name] 2>/dev/null || true
git push
git status
```

### Pattern 6: Repository Status

**Triggers**: "Montre-moi le statut", "Git status", "Où on en est?", "État du repo"

**Actions**:
1. Show current branch
2. Show uncommitted changes
3. Show last 5 commits
4. Show all branches (local and remote)
5. Check if up-to-date with origin

**Execution**:
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

### Pattern 7: Switch Branch

**Triggers**: "Je vais travailler sur [branche]", "Switch to feature/...", "Aller sur la feature"

**Actions**:
1. Check for uncommitted changes
2. Offer to stash if changes exist
3. Switch to target branch
4. Pull latest changes
5. Show current location

**Execution**:
```bash
git status
# If uncommitted changes, ask user if they want to stash
# If yes: git stash
git checkout [branch-name]
git pull
git status
```

### Pattern 8: Rebase on Main

**Triggers**: "Je veux mettre à jour ma branche", "Rebase sur main", "Synchroniser avec main"

**Actions**:
1. Verify on feature branch (not main)
2. Fetch remote changes
3. Rebase on origin/main
4. Report conflicts if any
5. Confirm branch updated

**Execution**:
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

Respond: "Ta branche est à jour avec les derniers changements de main" (if successful)

### Pattern 9: Undo Last Commit

**Triggers**: "Annule le dernier commit", "Undo last commit", "J'ai fait une erreur"

**Actions**:
1. Ask user if they want to keep changes or discard them
2. Execute appropriate reset command
3. Show state after reset
4. Offer to help re-add changes differently

**Execution**:
```bash
# Ask user: Keep changes (soft) or discard (hard)?
# If keep: git reset --soft HEAD~1
# If discard: git reset --hard HEAD~1
git status
```

**Warning**: Alert user before `--hard` reset about data loss

### Pattern 10: View Commit History

**Triggers**: "Montre-moi l'historique", "Show commits", "Voir les 10 derniers commits"

**Actions**:
1. Show commits with author, date, and description
2. Display 10 commits by default
3. Allow comparison between branches

**Execution**:
```bash
git log --oneline --decorate --graph -10
# For branch comparison:
# git log main..feature/[branch-name] --oneline --decorate
```

### Pattern 11: Resolve Merge Conflicts

**Triggers**: "Il y a un conflit", "Merge conflict", "Comment gérer les conflits?"

**Actions**:
1. Show which files have conflicts
2. Display conflicting sections
3. Offer resolution strategies (ours/theirs)
4. Complete merge after resolution

**Execution**:
```bash
git status
git diff
# Guide user through conflict resolution
# After resolution:
git add .
git commit -m "merge: resolve conflicts

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

### Pattern 12: Create Experimental Branch

**Triggers**: "Je veux expérimenter", "Create experiment", "Branche de test"

**Actions**:
1. Create experiment/ or dev/ branch
2. Inform user it's a safe test branch
3. Offer to delete or merge when done

**Execution**:
```bash
git checkout -b experiment/[experiment-name]
git status
```

Respond: "C'est une branche de test, tu peux faire des trucs sans risque"

### Pattern 13: Squash Commits

**Triggers**: "Squash mes commits", "Regrouper les commits", "Nettoyer l'historique"

**Actions**:
1. List commits to squash
2. Perform interactive rebase
3. Combine commits into one
4. Create clean commit message
5. Confirm history cleaned

**Execution**:
```bash
# Ask user how many commits to squash
git log --oneline -n [number]
git rebase -i HEAD~[number]
# Guide through squash process
git push --force-with-lease
```

**Warning**: Alert user about force push implications

### Pattern 14: Create Release Tag

**Triggers**: "Créer une release", "Version 1.0", "Tag release"

**Actions**:
1. Create annotated tag
2. Push tag to origin
3. Show existing tags
4. Confirm release tagged

**Execution**:
```bash
git tag -a v[version] -m "Release [version]"
git push origin v[version]
git tag -l
```

Respond: "Release taguée et poussée"

### Pattern 15: View Commit Changes

**Triggers**: "Montre-moi les changements du commit", "Diff du commit", "Voir ce qui a changé"

**Actions**:
1. Show modified files
2. Display diff of commit
3. Show added/removed lines per file

**Execution**:
```bash
git show [commit-hash]
# Or for latest commit:
git show HEAD
```

## GitHub CLI Workflow Patterns

### Pattern 16: Create Pull Request

**Triggers**: "Créer une pull request", "Create PR", "Ouvrir une PR", "Je veux faire une PR"

**Actions**:
1. Verify current branch (not main)
2. Push current branch to origin
3. Create PR with title and description
4. Open PR in browser (optional)
5. Show PR URL

**Execution**:
```bash
# Verify not on main
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" = "main" ]; then
    echo "Error: Cannot create PR from main branch"
    exit 1
fi

# Push branch
git push -u origin $CURRENT_BRANCH

# Create PR (interactive or with provided info)
gh pr create --title "[PR Title]" --body "[PR Description]"

# Or interactive mode:
# gh pr create --web
```

**Documentation**: Use context7 to fetch `gh pr create` documentation if needed.

### Pattern 17: View Pull Requests

**Triggers**: "Montre-moi les PRs", "Liste des pull requests", "Voir les PRs ouvertes"

**Actions**:
1. List open pull requests
2. Show PR details (number, title, author, status)
3. Offer to view specific PR

**Execution**:
```bash
# List all open PRs
gh pr list

# View specific PR
gh pr view [PR-NUMBER]

# Check PR status and checks
gh pr checks [PR-NUMBER]
```

### Pattern 18: Merge Pull Request

**Triggers**: "Merger la PR", "Merge pull request", "Accepter la PR"

**Actions**:
1. View PR details
2. Check if PR is mergeable
3. Merge PR with chosen strategy (merge/squash/rebase)
4. Delete branch after merge (optional)
5. Pull updated main branch

**Execution**:
```bash
# View PR details
gh pr view [PR-NUMBER]

# Merge PR (ask user for merge strategy)
gh pr merge [PR-NUMBER] --merge  # or --squash or --rebase

# Delete branch after merge
gh pr merge [PR-NUMBER] --merge --delete-branch

# Update local main
git checkout main
git pull origin main
```

### Pattern 19: Create GitHub Issue

**Triggers**: "Créer une issue", "Signaler un bug", "Create issue", "Nouvelle issue"

**Actions**:
1. Create issue with title and description
2. Add labels if specified
3. Assign to user if specified
4. Show issue URL

**Execution**:
```bash
# Create issue interactively
gh issue create --title "[Issue Title]" --body "[Issue Description]"

# With labels and assignee
gh issue create --title "[Title]" --body "[Body]" --label "bug,urgent" --assignee "@me"

# Or interactive web mode
gh issue create --web
```

**Documentation**: Use context7 to fetch `gh issue create` documentation if needed.

### Pattern 20: List and View Issues

**Triggers**: "Liste des issues", "Voir les issues", "Issues ouvertes"

**Actions**:
1. List issues with filters (open/closed/all)
2. Show issue details
3. Offer to comment or close

**Execution**:
```bash
# List open issues
gh issue list

# List with filters
gh issue list --label "bug" --state "open"

# View specific issue
gh issue view [ISSUE-NUMBER]
```

### Pattern 21: Close GitHub Issue

**Triggers**: "Fermer l'issue", "Close issue", "Résoudre l'issue"

**Actions**:
1. Close issue with optional comment
2. Confirm issue closed

**Execution**:
```bash
# Close issue
gh issue close [ISSUE-NUMBER]

# Close with comment
gh issue close [ISSUE-NUMBER] --comment "Fixed in PR #123"
```

### Pattern 22: View GitHub Actions

**Triggers**: "Voir les workflows", "GitHub Actions", "CI/CD status", "Voir les builds"

**Actions**:
1. List workflow runs
2. Show run details
3. View logs if requested

**Execution**:
```bash
# List workflow runs
gh run list

# View specific run
gh run view [RUN-ID]

# Watch run in real-time
gh run watch [RUN-ID]

# View logs
gh run view [RUN-ID] --log
```

### Pattern 23: Trigger GitHub Action

**Triggers**: "Lancer un workflow", "Trigger action", "Run workflow"

**Actions**:
1. List available workflows
2. Trigger specific workflow
3. Monitor workflow run

**Execution**:
```bash
# List workflows
gh workflow list

# Trigger workflow
gh workflow run [WORKFLOW-NAME]

# Trigger with inputs
gh workflow run [WORKFLOW-NAME] -f param1=value1 -f param2=value2
```

**Documentation**: Use context7 to fetch `gh workflow` documentation if needed.

### Pattern 24: Create GitHub Release

**Triggers**: "Créer une release", "Publish release", "Release version"

**Actions**:
1. Create git tag (if not exists)
2. Create GitHub release
3. Upload release assets (optional)
4. Generate release notes automatically

**Execution**:
```bash
# Create release with auto-generated notes
gh release create v[VERSION] --generate-notes

# Create release with specific notes
gh release create v[VERSION] --title "Release [VERSION]" --notes "[Release Notes]"

# Create with assets
gh release create v[VERSION] --generate-notes dist/*.zip dist/*.tar.gz

# Create draft release
gh release create v[VERSION] --draft --generate-notes
```

### Pattern 25: View Repository Information

**Triggers**: "Info du repo", "Repository details", "Voir les infos GitHub"

**Actions**:
1. Show repository details
2. Display clone count, stars, forks
3. Show topics and description

**Execution**:
```bash
# View current repository
gh repo view

# View with web browser
gh repo view --web

# View specific repository
gh repo view [OWNER/REPO]
```

### Pattern 26: Clone Repository

**Triggers**: "Clone ce repo", "Clone repository", "Télécharger le projet"

**Actions**:
1. Clone repository with gh
2. Set up authentication automatically
3. Navigate to cloned directory

**Execution**:
```bash
# Clone repository
gh repo clone [OWNER/REPO]

# Clone and navigate
gh repo clone [OWNER/REPO] && cd [REPO]
```

### Pattern 27: Fork Repository

**Triggers**: "Fork le repo", "Créer un fork", "Fork repository"

**Actions**:
1. Create fork on GitHub
2. Clone fork locally
3. Add upstream remote

**Execution**:
```bash
# Fork and clone
gh repo fork [OWNER/REPO] --clone

# Fork without cloning
gh repo fork [OWNER/REPO]
```

## MCP Context7 Integration

**CRITICAL**: Always use MCP context7 for documentation lookups instead of static reference files.

### When to Use Context7

1. **User asks for help**: "Comment utiliser gh?", "How to create a PR?"
2. **User requests documentation**: "Docs for gh issue", "Git rebase documentation"
3. **User wants latest information**: "Latest GitHub CLI features", "New gh commands"
4. **Error troubleshooting**: "Why did gh pr create fail?", "Git merge conflict help"

### How to Use Context7

When documentation is needed, make a request to the MCP context7 server:

```
Request documentation from context7:
- Topic: "GitHub CLI pull request commands"
- Topic: "Git rebase interactive tutorial"
- Topic: "GitHub Actions workflow syntax"
- Topic: "Conventional commits specification"
```

The context7 server will fetch the most current and accurate documentation.

### Context7 Priority Topics

1. **GitHub CLI commands**: `gh pr`, `gh issue`, `gh workflow`, `gh release`, etc.
2. **Git advanced topics**: rebase, cherry-pick, bisect, reflog, worktree
3. **GitHub Actions**: workflow syntax, triggers, jobs, steps
4. **Conventional Commits**: latest specification and examples
5. **Git Flow**: feature/hotfix/release workflows
6. **GitHub API**: REST and GraphQL API documentation

## Commit Message Format

Use **Conventional Commits** format:

```
<type>: <description>

[optional body]

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

**Types**:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `refactor:` - Code refactoring
- `test:` - Adding tests
- `chore:` - Maintenance tasks
- `style:` - Code formatting
- `perf:` - Performance improvements

Generate commit messages based on user's description:
- "J'ai ajouté l'authentification" → `feat: add authentication`
- "J'ai fixé le bug du login" → `fix: login button bug`
- "J'ai mis à jour la doc" → `docs: update documentation`

## Branch Naming Conventions

All branch names in lowercase with hyphens:

- **Features**: `feature/descriptive-name`
- **Hotfixes**: `hotfix/bug-description`
- **Experiments**: `experiment/test-name`
- **Development**: `dev/feature-name`

## Error Handling

**Git not initialized**:
```bash
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not a git repository. Run 'git init' first."
    exit 1
fi
```

**Branch doesn't exist**:
```bash
if ! git show-ref --verify --quiet refs/heads/[branch-name]; then
    echo "Error: Branch [branch-name] doesn't exist"
    exit 1
fi
```

**Uncommitted changes**:
```bash
if ! git diff-index --quiet HEAD --; then
    echo "Warning: You have uncommitted changes"
    # Offer to stash or commit
fi
```

**Merge conflicts**:
```bash
if git ls-files -u | grep -q .; then
    echo "Error: Merge conflicts detected. Resolve conflicts first."
    exit 1
fi
```

## Destructive Operations Warning

Before executing destructive operations, **always warn the user**:

- `git reset --hard` - Discards all uncommitted changes
- `git push --force` / `git push --force-with-lease` - Overwrites remote history
- `git clean -f` - Deletes untracked files
- `git branch -D` - Force deletes branch with unmerged changes

## Additional Resources

### Primary Documentation Source: MCP Context7

**ALWAYS USE CONTEXT7 FIRST** for documentation requests. Context7 provides:
- Latest GitHub CLI documentation
- Current Git documentation and tutorials
- GitHub Actions workflow references
- Conventional Commits specification
- GitHub API documentation

### Fallback Reference Documents

Only use these static files if context7 is unavailable:

- **Git Best Practices**: `references/git-best-practices.md`
- **Conventional Commits**: `references/conventional-commits.md`
- **Git Flow Guide**: `references/git-flow-guide.md`
- **Advanced Commands**: `references/advanced-git-commands.md`

### GitHub CLI Help Commands

For quick reference without context7:
```bash
# General help
gh help

# Command-specific help
gh pr --help
gh issue --help
gh workflow --help
gh release --help
```

## Usage Notes

1. **Always validate state** before operations
2. **Confirm each action** with user feedback
3. **Show git status** after operations
4. **Generate descriptive commit messages** from user's description
5. **Warn before destructive operations**
6. **Use conventional commit format**
7. **Follow branch naming conventions**
8. **Offer alternatives** when appropriate
9. **Use GitHub CLI (`gh`)** for all GitHub operations (PRs, issues, actions, releases)
10. **Request documentation from MCP context7** for help and latest information
11. **Verify `gh` authentication** before GitHub operations: `gh auth status`
12. **Provide GitHub operation feedback** with URLs and status
