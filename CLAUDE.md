# SpeechFlow - Instructions pour Claude AI

## Aperçu de l'objectif du projet

SpeechFlow est un SaaS de documentation intelligente automatisée qui transforme des fichiers Audio/Vidéo en documents PDF structurés avec transcription automatique et résumé IA cumulé. La valeur unique réside dans la capacité à construire une base de connaissance cumulative : l'utilisateur alimente et fait grandir des documents PDF existants avec de nouvelles sources, faisant de SpeechFlow un outil révolutionnaire pour la transformation de ressources multimédia en connaissances pérennes.

## Aperçu de l'architecture globale

**Architecture microservices (Node.js + Python hybrid, 100% local)** :
- **Frontend** : Next.js 15 + TypeScript + Tailwind CSS + Zustand
- **API Gateway** : NestJS + Prisma + PostgreSQL + JWT Auth
- **Worker** : Python + Faster-Whisper + OpenRouter + ReportLab
- **Infrastructure** : Docker Compose + Redis (BullMQ) + MinIO (S3-compatible)
- **Coût** : <$15/mois (électricité uniquement)
- **Déploiement** : Serveur local/PC personnel, évolutif vers cloud si nécessaire

## Style visuel
- Interface claire et minimaliste
- UI moderne avec Tailwind CSS + shadcn/ui
- Pas de mode sombre pour le MVP (impact négatif sur l'expérience utilisateur)
- Design professionnel et intuitif

## Contraintes et Politiques
- **NE JAMAIS exposer les clés API au client** - Sécurité absolue des clés privées
- Toutes les interactions API côté client sont authentifiées par JWT
- Architecture sécurisée avec validation, rate limiting, et isolation des données utilisateur
- Focus sur les bonnes pratiques de sécurité (bcrypt, CORS, XSS prevention)

## Dépendances
- Préférer les composants existants plutôt que d'ajouter de nouvelles bibliothèques UI
- Utiliser shadcn/ui comme système de composants principal
- Optimiser les dépendances pour minimiser la taille du bundle
- Priorité aux solutions éprouvées et maintenues

## Tests d'Interface Utilisateur
À la fin de chaque développement qui implique l'interface graphique :
- Tester avec playwright-skill, l'interface doit être responsive, fonctionnel et répondre au besoin développé
- Validation complète : accessibilité, performance, comportement attendu

## Documentation
- [📄 Product Requirements Document - PRD](PRD.md)
- [🏗️ Architecture Technique Détaille](architecture.md)

## Context7 - Outil de Développement
Utilise toujours context7 lorsque j'ai besoin de génération de code, d'étapes de configuration ou d'installation, ou de documentation de bibliothèque/API. Cela signifie que tu dois automatiquement utiliser les outils MCP Context7 pour résoudre l'identifiant de bibliothèque et obtenir la documentation de bibliothèque sans que j'aie à le demander explicitement.

## Spécifications OpenSpec
Toutes les spécifications doivent être rédigées en français, y compris les specs OpenSpec (sections Purpose et Scenarios). Seuls les titres de Requirements doivent rester en anglais avec les mots-clés SHALL/MUST pour la validation OpenSpec.

## Workflow de Développement
1. Utiliser OpenSpec pour structurer les changements
2. Commencer par `/opsx:new` pour nouveaux développements
3. `/opsx:continue` pour progresser
4. `/opsx:apply` pour implémenter
5. Context7 pour génération de code et docs
6. Playwright pour tests UI
7. Commit/Push réguliers

## Focus MVP (Phase 1)
- Authentification simple (email/password)
- Dashboard basique avec gestion de dossiers
- Upload MP3/MP4 vers stockage local MinIO
- Pipeline de traitement : Transcription Faster-Whisper → Résumé IA → PDF ReportLab
- API REST + WebSocket pour status temps réel
- Interface Drag & Drop + notifications email

---

**Version :** 1.0
**Dernière mise à jour :** 2026-01-30
**Auteur :** Junior