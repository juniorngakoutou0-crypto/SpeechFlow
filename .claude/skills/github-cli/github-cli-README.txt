════════════════════════════════════════════════════════════════════
  GITHUB-CLI SKILL - INSTALLATION ET UTILISATION
════════════════════════════════════════════════════════════════════

📦 SKILL CRÉÉ AVEC SUCCÈS!

📍 Emplacement:
   C:\Users\junio\.claude\skills\github-cli.skill (20 KB)

📂 Structure du skill:
   github-cli/
   ├── SKILL.md                               (Enhanced with gh CLI + MCP)
   ├── EXAMPLES.md                            (4.5 KB)
   └── references/
       ├── git-best-practices.md              (6.4 KB)
       ├── conventional-commits.md            (10 KB)
       ├── git-flow-guide.md                  (11.6 KB)
       └── advanced-git-commands.md           (11.6 KB)

════════════════════════════════════════════════════════════════════
  FONCTIONNALITÉS DU SKILL (27 CAS D'USAGE)
════════════════════════════════════════════════════════════════════

GIT WORKFLOWS (15):
✅ 1.  Initialize New Project
✅ 2.  Start Feature Development
✅ 3.  Finish Feature Development
✅ 4.  Create Hotfix
✅ 5.  Complete Hotfix
✅ 6.  Repository Status
✅ 7.  Switch Branch
✅ 8.  Rebase on Main
✅ 9.  Undo Last Commit
✅ 10. View Commit History
✅ 11. Resolve Merge Conflicts
✅ 12. Create Experimental Branch
✅ 13. Squash Commits
✅ 14. Create Release Tag
✅ 15. View Commit Changes

GITHUB CLI OPERATIONS (12):
✅ 16. Create Pull Request
✅ 17. View Pull Requests
✅ 18. Merge Pull Request
✅ 19. Create GitHub Issue
✅ 20. List and View Issues
✅ 21. Close GitHub Issue
✅ 22. View GitHub Actions
✅ 23. Trigger GitHub Action
✅ 24. Create GitHub Release
✅ 25. View Repository Information
✅ 26. Clone Repository
✅ 27. Fork Repository

════════════════════════════════════════════════════════════════════
  CARACTÉRISTIQUES PRINCIPALES
════════════════════════════════════════════════════════════════════

🎯 SMART FEATURES:
   • Conventional Commits automatiques
   • Traduction français/anglais des messages de commit
   • Validation de l'état Git avant chaque opération
   • Messages d'erreur clairs et explicites
   • Avertissements avant opérations destructives
   • Intégration complète GitHub CLI (gh)
   • Création/gestion de PRs, issues, releases
   • Contrôle GitHub Actions depuis le terminal

📚 DOCUMENTATION DYNAMIQUE (MCP CONTEXT7):
   • Documentation GitHub CLI en temps réel
   • Documentation Git à jour via MCP
   • Spécifications Conventional Commits
   • Références GitHub Actions
   • Documentation GitHub API
   • Fallback sur fichiers locaux si MCP indisponible

🔒 SÉCURITÉ:
   • Confirmation avant force push
   • Avertissement avant reset --hard
   • Vérification des changements non commités
   • Protection contre les erreurs communes
   • Authentification GitHub automatique via gh

⚡ GITHUB CLI INTEGRATION:
   • Pull Requests: create, view, merge, review
   • Issues: create, list, view, close, comment
   • Actions: view workflows, trigger runs, monitor
   • Releases: create, publish, manage assets
   • Repositories: clone, fork, view info

════════════════════════════════════════════════════════════════════
  INSTALLATION
════════════════════════════════════════════════════════════════════

Le skill est déjà installé dans:
C:\Users\junio\.claude\skills\github-cli\

Pour utiliser le skill, Claude le chargera automatiquement quand vous:
- Demandez d'initialiser un projet
- Voulez créer une feature/hotfix
- Avez besoin d'aide avec Git
- Demandez le statut du repo
- Voulez faire un commit, merge, rebase, etc.

════════════════════════════════════════════════════════════════════
  EXEMPLES D'UTILISATION
════════════════════════════════════════════════════════════════════

GIT WORKFLOWS:
💬 "Je veux créer un nouveau projet"
   → Initialize Git, commit initial, push to origin

💬 "Je vais développer une nouvelle fonctionnalité d'authentification"
   → Crée feature/authentication, pull, ready to code

💬 "J'ai fini ma fonctionnalité"
   → Commit, merge to main, delete feature branch, push

💬 "Je dois créer un hotfix pour un bug critique"
   → Crée hotfix/bug-description from main

💬 "Montre-moi le statut"
   → Affiche branch, changes, commits, sync status

💬 "Squash mes 3 derniers commits"
   → Interactive rebase pour regrouper les commits

GITHUB CLI OPERATIONS:
💬 "Créer une pull request pour ma feature"
   → gh pr create avec titre et description, ouvre dans le navigateur

💬 "Montre-moi les PRs ouvertes"
   → Liste toutes les PRs avec statut et checks

💬 "Merger la PR #42"
   → Merge avec stratégie choisie, supprime la branche

💬 "Créer une issue pour le bug de login"
   → gh issue create avec labels et assignation

💬 "Voir les workflows GitHub Actions"
   → Liste les workflows et leurs statuts

💬 "Lancer le workflow de déploiement"
   → Trigger workflow avec paramètres

💬 "Créer une release version 2.0.0"
   → gh release create avec notes auto-générées

💬 "Fork ce repository"
   → Fork et clone avec upstream configuré

════════════════════════════════════════════════════════════════════
  TRADUCTION AUTOMATIQUE DES COMMITS
════════════════════════════════════════════════════════════════════

Le skill traduit automatiquement votre description en commit message:

"J'ai ajouté l'authentification"     → feat: add authentication
"J'ai fixé le bug du login"          → fix: login button bug
"J'ai mis à jour la doc"             → docs: update documentation
"J'ai refactorisé le code"           → refactor: improve code structure
"J'ai optimisé les performances"     → perf: optimize performance
"J'ai ajouté des tests"              → test: add unit tests

════════════════════════════════════════════════════════════════════
  CONVENTIONS DE NOMMAGE
════════════════════════════════════════════════════════════════════

📌 Branches:
   feature/descriptive-name          (nouvelles fonctionnalités)
   hotfix/bug-description            (corrections urgentes)
   experiment/test-name              (tests et expérimentations)

📌 Commits:
   feat:      Nouvelle fonctionnalité
   fix:       Correction de bug
   docs:      Documentation
   refactor:  Refactoring
   perf:      Optimisation
   test:      Tests
   chore:     Maintenance

📌 Tags:
   v1.0.0     (semantic versioning)

════════════════════════════════════════════════════════════════════
  MCP CONTEXT7 INTEGRATION
════════════════════════════════════════════════════════════════════

🌐 DOCUMENTATION DYNAMIQUE:
Le skill utilise MCP context7 pour récupérer la documentation à jour:

✅ Quand utiliser context7:
   • User demande de l'aide: "Comment utiliser gh pr?"
   • User veut la doc: "Docs GitHub CLI"
   • User cherche les dernières features: "Nouvelles commandes gh"
   • Dépannage d'erreurs: "Pourquoi gh pr create échoue?"

✅ Topics prioritaires context7:
   • Commandes GitHub CLI (gh pr, gh issue, gh workflow, gh release)
   • Topics Git avancés (rebase, cherry-pick, bisect, reflog)
   • GitHub Actions (syntax, triggers, jobs, steps)
   • Conventional Commits (spécification)
   • Git Flow (workflows)
   • GitHub API (REST et GraphQL)

✅ Avantages:
   • Documentation toujours à jour
   • Pas de fichiers statiques obsolètes
   • Exemples récents et pertinents
   • Erreurs et solutions actuelles

════════════════════════════════════════════════════════════════════
  DOCUMENTATION LOCALE (FALLBACK)
════════════════════════════════════════════════════════════════════

📖 Utilisé uniquement si MCP context7 indisponible:

📖 git-best-practices.md
   • Bonnes pratiques générales
   • Stratégies de branches
   • Sécurité Git
   • Performance

📖 conventional-commits.md
   • Format des commits
   • Types de commits (feat, fix, docs, etc.)
   • Exemples pratiques
   • Génération automatique de changelog

📖 git-flow-guide.md
   • Git Flow expliqué
   • Workflows complets
   • Feature/Release/Hotfix
   • Exemples détaillés

📖 advanced-git-commands.md
   • Rebase interactif
   • Squash commits
   • Stash
   • Cherry-pick
   • Reset, Reflog, Bisect
   • Worktree, Submodules

════════════════════════════════════════════════════════════════════
  GITHUB CLI QUICK REFERENCE
════════════════════════════════════════════════════════════════════

📝 COMMANDES ESSENTIELLES:

Pull Requests:
   gh pr create              Créer une PR
   gh pr list                Lister les PRs
   gh pr view [#]            Voir détails PR
   gh pr merge [#]           Merger une PR
   gh pr review [#]          Review une PR

Issues:
   gh issue create           Créer une issue
   gh issue list             Lister les issues
   gh issue view [#]         Voir détails issue
   gh issue close [#]        Fermer une issue
   gh issue comment [#]      Commenter une issue

Actions:
   gh workflow list          Lister workflows
   gh workflow run [name]    Lancer workflow
   gh run list               Lister les runs
   gh run view [id]          Voir détails run
   gh run watch [id]         Suivre run en temps réel

Releases:
   gh release create [tag]   Créer release
   gh release list           Lister releases
   gh release view [tag]     Voir détails release

Repos:
   gh repo view              Voir info repo
   gh repo clone [owner/repo] Cloner repo
   gh repo fork [owner/repo] Fork repo

════════════════════════════════════════════════════════════════════
  NOTES IMPORTANTES
════════════════════════════════════════════════════════════════════

⚠️  Le skill valide TOUJOURS l'état avant chaque opération
⚠️  Avertissement avant opérations destructives (force push, reset --hard)
⚠️  Tous les commits incluent "Co-Authored-By: Claude Sonnet 4.5"
⚠️  Documentation via MCP context7 (prioritaire)
⚠️  Fallback sur fichiers locaux si MCP indisponible
⚠️  Support français et anglais
⚠️  Authentification GitHub via `gh auth login` si nécessaire
⚠️  Toutes les opérations GitHub utilisent `gh` CLI
⚠️  Documentation dynamique toujours à jour via context7

════════════════════════════════════════════════════════════════════
  CONFIGURATION REQUISE
════════════════════════════════════════════════════════════════════

✅ Git installé (déjà configuré)
✅ GitHub CLI (gh) installé - Version 2.86.0 détectée
✅ MCP context7 server configuré (recommandé)

🔑 Première utilisation GitHub CLI:
   1. Authentifiez-vous: gh auth login
   2. Choisissez GitHub.com ou GitHub Enterprise
   3. Suivez les instructions d'authentification
   4. Vérifiez: gh auth status

📡 Configuration MCP context7:
   Le skill utilisera automatiquement context7 pour la documentation.
   Si context7 n'est pas disponible, le skill utilise les fichiers locaux.

════════════════════════════════════════════════════════════════════
  PROCHAINES ÉTAPES
════════════════════════════════════════════════════════════════════

1. ✅ Le skill est prêt à l'emploi avec Git + GitHub CLI + MCP context7

2. 🔑 Si première utilisation GitHub CLI:
   Authentifiez-vous avec: gh auth login

3. 🧪 Testez les workflows Git:
   "Je veux créer un nouveau projet"
   "Je vais développer une feature"

4. 🚀 Testez les opérations GitHub:
   "Créer une pull request"
   "Montre-moi les issues ouvertes"
   "Voir les workflows GitHub Actions"

5. 📚 Demandez de l'aide (via MCP context7):
   "Comment créer une PR avec gh?"
   "Documentation Git rebase"
   "Qu'est-ce que les conventional commits?"

6. 📖 Consultez EXAMPLES.md pour plus de scénarios

7. 🔧 Personnalisez selon vos besoins:
   - Ajoutez vos propres workflows
   - Configurez des alias gh
   - Intégrez avec vos outils CI/CD

════════════════════════════════════════════════════════════════════
  NOUVEAUTÉS VERSION 2.0.0
════════════════════════════════════════════════════════════════════

✨ GitHub CLI Integration (12 nouveaux patterns):
   • Gestion complète des Pull Requests
   • Gestion des Issues GitHub
   • Contrôle GitHub Actions
   • Création et publication de Releases
   • Clone et Fork de repositories

🌐 MCP Context7 Integration:
   • Documentation dynamique et à jour
   • Récupération automatique de la doc GitHub CLI
   • Documentation Git fraîche
   • Spécifications Conventional Commits actuelles
   • Fallback automatique sur fichiers locaux

🎯 Améliorations:
   • 27 patterns au lieu de 15
   • Support bilingue (FR/EN) amélioré
   • Validation d'authentification GitHub
   • Feedback détaillé avec URLs GitHub
   • Quick reference intégrée

════════════════════════════════════════════════════════════════════

Créé le: 2026-01-30
Version: 2.0.0 (Updated with GitHub CLI + MCP context7)
Auteur: Claude Sonnet 4.5
