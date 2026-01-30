# Advanced Git Commands

## Table of Contents
- [Rebase](#rebase)
- [Squash](#squash)
- [Stash](#stash)
- [Cherry-Pick](#cherry-pick)
- [Reset](#reset)
- [Reflog](#reflog)
- [Bisect](#bisect)
- [Worktree](#worktree)
- [Submodules](#submodules)

## Rebase

### Interactive Rebase

Rewrite commit history interactively:

```bash
# Rebase last 3 commits
git rebase -i HEAD~3

# Rebase on develop
git rebase -i develop
```

**Interactive options**:
- `pick` - Keep commit as-is
- `reword` - Change commit message
- `edit` - Modify commit
- `squash` - Combine with previous commit
- `fixup` - Like squash but discard message
- `drop` - Remove commit

**Example**:
```bash
pick 1234567 feat: add login
squash 2345678 fix: typo in login
reword 3456789 feat: add logout
drop 4567890 debug: temporary logging
```

### Standard Rebase

Update branch with latest changes:

```bash
# Update feature branch with main
git checkout feature/my-feature
git fetch origin
git rebase origin/main

# Abort if issues
git rebase --abort

# Continue after resolving conflicts
git add resolved-file.js
git rebase --continue

# Skip problematic commit
git rebase --skip
```

### Rebase vs Merge

**Rebase** (clean linear history):
```bash
git rebase main
# Result: feature commits appear after main
```

**Merge** (preserves branch history):
```bash
git merge main
# Result: merge commit created
```

**When to use**:
- **Rebase**: Private feature branches, keeping history clean
- **Merge**: Shared branches, preserving branch history

## Squash

### Squash Last N Commits

Combine multiple commits into one:

```bash
# Squash last 3 commits
git rebase -i HEAD~3

# In editor, change:
pick 1234567 feat: add component
pick 2345678 fix: component styling
pick 3456789 fix: component tests

# To:
pick 1234567 feat: add component
squash 2345678 fix: component styling
squash 3456789 fix: component tests

# Save and edit combined commit message
```

### Squash During Merge

```bash
git checkout main
git merge --squash feature/my-feature
git commit -m "feat: complete feature implementation"
```

**Result**: All feature commits combined into single commit on main.

### Soft Reset + Recommit

Alternative squash method:

```bash
# Reset to 3 commits ago (keep changes)
git reset --soft HEAD~3

# All changes now staged
git status

# Commit as single commit
git commit -m "feat: complete feature"
```

## Stash

### Basic Stash

Temporarily save uncommitted changes:

```bash
# Save changes
git stash

# Save with message
git stash save "work in progress on login"

# Include untracked files
git stash -u

# Include all (even ignored files)
git stash -a
```

### List and Apply Stashes

```bash
# List all stashes
git stash list
# stash@{0}: WIP on feature: add login
# stash@{1}: work in progress on logout

# Apply latest stash (keep in stash list)
git stash apply

# Apply specific stash
git stash apply stash@{1}

# Apply and remove from stash list
git stash pop

# Apply specific and remove
git stash pop stash@{0}
```

### Manage Stashes

```bash
# Show stash contents
git stash show stash@{0}

# Show full diff
git stash show -p stash@{0}

# Drop specific stash
git stash drop stash@{0}

# Clear all stashes
git stash clear

# Create branch from stash
git stash branch new-branch-name stash@{0}
```

### Partial Stash

Stash only specific files:

```bash
# Stash specific file
git stash push -m "save login work" src/login.js

# Stash interactively
git stash -p
# Choose yes/no for each change
```

## Cherry-Pick

### Pick Specific Commits

Apply commits from one branch to another:

```bash
# Cherry-pick single commit
git cherry-pick 1234567

# Cherry-pick multiple commits
git cherry-pick 1234567 2345678 3456789

# Cherry-pick range
git cherry-pick 1234567..3456789

# Cherry-pick without committing
git cherry-pick -n 1234567
git commit -m "feat: cherry-picked feature"
```

### Resolve Conflicts

```bash
git cherry-pick 1234567
# CONFLICT

# Resolve conflict
git add resolved-file.js
git cherry-pick --continue

# Abort
git cherry-pick --abort

# Skip
git cherry-pick --skip
```

### Use Cases

**Scenario 1: Port fix to release branch**
```bash
# Fix committed on main
git checkout release/1.2.0
git cherry-pick abc1234  # Fix commit hash
git push
```

**Scenario 2: Extract specific features**
```bash
# Feature branch has multiple commits
# Only want specific feature
git checkout new-branch
git cherry-pick feature-commit-hash
```

## Reset

### Reset Types

#### --soft (Keep changes staged)
```bash
git reset --soft HEAD~1
# Commit removed, changes staged
git status  # Shows staged changes
```

#### --mixed (Keep changes unstaged)
```bash
git reset --mixed HEAD~1
# Or just: git reset HEAD~1
# Commit removed, changes unstaged
git status  # Shows unstaged changes
```

#### --hard (Discard changes)
```bash
git reset --hard HEAD~1
# WARNING: Changes permanently lost!
git status  # Working directory clean
```

### Reset to Specific Commit

```bash
# Reset to specific commit
git reset --soft abc1234

# Reset to origin/main
git reset --hard origin/main

# Reset single file
git checkout HEAD -- file.js
```

### Undo Reset

```bash
# Find commit before reset
git reflog

# Reset back to that commit
git reset --hard HEAD@{1}
```

## Reflog

### View Reference Logs

See history of HEAD movements:

```bash
# Show reflog
git reflog

# Output:
# abc1234 HEAD@{0}: commit: feat: add login
# def5678 HEAD@{1}: rebase: finish
# ghi9012 HEAD@{2}: checkout: moving to main
```

### Recover Lost Commits

```bash
# View reflog
git reflog

# Find lost commit
# abc1234 HEAD@{5}: commit: important feature

# Recover commit
git checkout abc1234
git checkout -b recovered-branch

# Or reset to it
git reset --hard HEAD@{5}
```

### Use Cases

**Scenario 1: Undo hard reset**
```bash
git reset --hard HEAD~3  # Oops!
git reflog
git reset --hard HEAD@{1}  # Recovered!
```

**Scenario 2: Recover deleted branch**
```bash
git branch -D feature/lost  # Oops!
git reflog
# Find last commit on branch
git checkout -b feature/recovered abc1234
```

## Bisect

### Find Bug-Introducing Commit

Binary search through commits:

```bash
# Start bisect
git bisect start

# Mark current as bad
git bisect bad

# Mark known good commit
git bisect good abc1234

# Git checks out middle commit
# Test it, then mark:
git bisect good  # or git bisect bad

# Repeat until bug found
# Git identifies problematic commit

# End bisect
git bisect reset
```

### Automated Bisect

Use script to automate:

```bash
# Start bisect
git bisect start HEAD abc1234

# Run automated test
git bisect run npm test

# Git automatically finds bad commit
# Output: abc1234 is the first bad commit
```

### Example

```bash
# Bug exists now, worked at v1.0
git bisect start
git bisect bad HEAD
git bisect good v1.0

# Git checks out commit
# Test manually
npm test

# If passes:
git bisect good
# If fails:
git bisect bad

# Continue until found
# Git outputs: "commit xyz is the first bad commit"

git bisect reset
```

## Worktree

### Multiple Working Directories

Work on multiple branches simultaneously:

```bash
# Create new worktree
git worktree add ../my-feature feature/my-feature

# Create new worktree with new branch
git worktree add -b hotfix/bug ../hotfix main

# List worktrees
git worktree list

# Remove worktree
git worktree remove ../my-feature
```

### Use Cases

**Scenario 1: Review PR while working**
```bash
# Working on feature
cd ~/project

# Need to review PR
git worktree add ../review feature/pr-branch
cd ../review
# Review code

# Back to work
cd ~/project
# Continue working

# Done reviewing
git worktree remove ../review
```

**Scenario 2: Hotfix during feature work**
```bash
# Working on feature
cd ~/project

# Urgent hotfix needed
git worktree add -b hotfix/critical ../hotfix main
cd ../hotfix
# Fix bug
git commit -m "fix: critical bug"
git push

# Back to feature work
cd ~/project
```

## Submodules

### Add Submodule

Include another repository:

```bash
# Add submodule
git submodule add https://github.com/user/repo.git libs/external

# Commit submodule
git commit -m "chore: add external library submodule"
```

### Clone Repository with Submodules

```bash
# Clone with submodules
git clone --recursive https://github.com/user/repo.git

# Or after cloning
git submodule init
git submodule update
```

### Update Submodules

```bash
# Update all submodules
git submodule update --remote

# Update specific submodule
git submodule update --remote libs/external

# Commit updates
git commit -am "chore: update submodules"
```

### Remove Submodule

```bash
# Remove from .gitmodules
git submodule deinit libs/external

# Remove from index
git rm libs/external

# Commit removal
git commit -m "chore: remove external submodule"
```

## Advanced Techniques

### Fixup Commits

Create commit that fixes previous commit:

```bash
# Make fix
git add fixed-file.js
git commit --fixup abc1234

# Later, squash fixups
git rebase -i --autosquash HEAD~5
```

### Commit Amend

Modify last commit:

```bash
# Amend last commit
git commit --amend

# Amend without changing message
git commit --amend --no-edit

# Amend author
git commit --amend --author="Name <email>"
```

### Interactive Staging

Stage parts of files:

```bash
# Stage interactively
git add -p

# Choose for each change:
# y - stage this hunk
# n - don't stage
# s - split into smaller hunks
# e - manually edit hunk
```

### Blame with Ignore

Find who changed code (ignore formatting commits):

```bash
# Normal blame
git blame file.js

# Ignore specific commit
git blame --ignore-rev abc1234 file.js

# Ignore all formatting commits
echo "abc1234" >> .git-blame-ignore-revs
git blame --ignore-revs-file .git-blame-ignore-revs file.js
```

### Archive

Create archive of repository:

```bash
# Create ZIP archive
git archive -o latest.zip HEAD

# Create TAR archive
git archive -o latest.tar.gz --format=tar.gz HEAD

# Archive specific branch
git archive -o v1.0.zip v1.0
```

## Dangerous Commands

These commands can cause data loss - use with caution:

### Force Push
```bash
# Overwrites remote history
git push --force origin main  # DANGEROUS

# Safer alternative (fails if remote updated)
git push --force-with-lease origin feature/my-branch
```

### Hard Reset
```bash
# Permanently deletes uncommitted changes
git reset --hard HEAD  # DANGEROUS
```

### Clean
```bash
# Deletes untracked files
git clean -f  # DANGEROUS

# Dry run first
git clean -n
```

### Filter Branch
```bash
# Rewrites entire history
git filter-branch --tree-filter 'rm -f secret.key' HEAD  # DANGEROUS
# Use git-filter-repo instead
```

## Best Practices

1. **Always check status** before destructive operations
2. **Use `--dry-run`** when available
3. **Create backup branch** before rebasing
4. **Communicate** before force-pushing shared branches
5. **Test** before marking bisect good/bad
6. **Keep stash list clean** - apply or drop old stashes
7. **Use descriptive names** for stashes and worktrees

## Quick Reference

**Rebase**:
```bash
git rebase -i HEAD~3  # Interactive rebase
git rebase main       # Update with main
```

**Squash**:
```bash
git rebase -i HEAD~3  # Mark commits as squash
git reset --soft HEAD~3 && git commit  # Alternative
```

**Stash**:
```bash
git stash             # Save changes
git stash pop         # Apply and remove
git stash list        # View stashes
```

**Cherry-pick**:
```bash
git cherry-pick abc1234  # Apply specific commit
```

**Reset**:
```bash
git reset --soft HEAD~1   # Keep changes staged
git reset --hard HEAD~1   # Discard changes
```

**Reflog**:
```bash
git reflog            # View HEAD history
git reset --hard HEAD@{1}  # Recover
```
