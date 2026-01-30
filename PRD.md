C'est très juste. Pour qu'un développeur (ou une IA) comprenne bien la mission, il faut d'abord poser le contexte global avant de parler de planning. C'est ce qu'on appelle un **PRD (Product Requirements Document)**.

Voici la **Description Complète du Projet**, structurée de manière professionnelle, suivie du découpage en phases.

---

# 📄 DOCUMENT DE RÉFÉRENCE DU PROJET (PRD)

## 1. Vision et Objectif
L'objectif est de développer un **SaaS de documentation intelligente** automatisée. L'outil résout le problème de la consommation de contenu long (réunions, cours, conférences) en transformant des fichiers lourds (Audio/Vidéo) en documents écrits structurés et pérennes.

La valeur ajoutée unique de ce SaaS réside dans sa capacité à **construire une base de connaissance cumulative** : l'utilisateur ne crée pas juste des résumés isolés, il peut alimenter et faire grandir des documents PDF existants avec de nouvelles sources.

## 2. Le Cœur Fonctionnel (Core Features)

### A. Gestion des Entrées (Input)
*   **Sources acceptées :** Fichiers Vidéo (ex: MP4) et Audio (ex: MP3, WAV).
*   **Durée :** Capacité à traiter des fichiers très longs (jusqu'à 2 heures et plus).
*   **Intelligence d'ingestion :** Le système est agnostique. L'utilisateur fournit un fichier, le système détecte automatiquement le format (Audio vs Vidéo) et extrait la piste audio nécessaire sans intervention humaine.

### B. Traitement et Analyse (Processing)
*   **Transcription (Speech-to-Text) :** Conversion haute fidélité de la parole en texte.
*   **Analyse IA (LLM) :** Le texte transcrit est envoyé à un modèle de langage (via OpenRouter/LLM) pour analyse.
*   **Consigne Éditoriale (Prompting) :**
    *   **Langue :** Sortie exclusivement en **Français**, quelle que soit la langue source.
    *   **Profondeur :** Résumé **exhaustif**. Interdiction de synthétiser à outrance. Tous les points importants doivent être conservés, structurés chronologiquement ou thématiquement. Le but est de remplacer le visionnage de la vidéo par la lecture.

### C. Gestion Documentaire et Sortie (Output & Storage)
*   **Organisation :** Système de fichiers intuitif basé sur des **Dossiers** (création, renommage, gestion).
*   **Logique d'Agrégation (Feature Clé) :** Au moment de l'upload, l'utilisateur choisit la destination du résumé :
    1.  **Nouveau Document :** Création d'un nouveau PDF.
    2.  **Incrémentation :** Sélection d'un PDF existant dans le dossier. Le nouveau résumé est ajouté **à la suite** du contenu précédent, mettant à jour le fichier.
*   **Format de Sortie :** Fichier PDF téléchargeable et stocké dans le cloud.

---

## 3. Parcours Utilisateur (User Flow)

1.  **Login :** L'utilisateur arrive sur son Dashboard.
2.  **Navigation :** Il voit ses dossiers (ex: "Cours Physique", "Marketing"). Il entre dans un dossier ou en crée un nouveau.
3.  **Upload :** Il dépose son fichier (Audio/Vidéo).
4.  **Routage :** Une modale s'ouvre : *"Voulez-vous créer un nouveau PDF ou ajouter ce résumé à un PDF existant de ce dossier ?"*.
5.  **Traitement :** Barre de chargement (Upload -> Transcribe -> Analyze -> Generate).
6.  **Résultat :** Le PDF est mis à jour/créé. Il apparaît dans la liste du dossier. L'utilisateur peut l'ouvrir ou le télécharger.

---

## 4. Planification du Développement (Roadmap)

Maintenant que le projet est défini, voici la stratégie de déploiement pour assurer la faisabilité technique.

### 🚀 PHASE 1 : MVP (Minimum Viable Product)
*Objectif : Valider la chaîne technique "Fichier -> PDF cumulatif".*

*   **Authentification :** Simple (Email/Password).
*   **Dashboard :** Liste simple de dossiers. Création de dossiers.
*   **Upload :** Support MP3/MP4.
*   **Moteur IA :** Transcription + Résumé exhaustif en Français.
*   **Agrégation PDF :** La logique conditionnelle (Nouveau vs Ajout) doit être fonctionnelle.
*   **Téléchargement :** Bouton pour télécharger le PDF final.
*   *Note technique : On se concentre sur le fonctionnement backend, le design reste basique.*

### ⭐ PHASE 2 : V1 (Version Commerciale)
*Objectif : Rendre le produit robuste, beau et capable de gérer de gros volumes.*

*   **Gestion des Longs Fichiers (2h+) :** Implémentation de tâches en arrière-plan (Background Jobs) pour éviter que le navigateur ne plante pendant l'analyse d'une longue vidéo. Notifications email quand c'est prêt.
*   **UX/UI Design :** Interface soignée, Drag & Drop fluide.
*   **Gestion de Fichiers Avancée :** Renommer les PDF, déplacer un PDF d'un dossier à l'autre, supprimer des éléments.
*   **Prévisualisation :** Possibilité de lire le PDF directement dans le navigateur sans le télécharger.

### 🌟 PHASE 3 : V2 (Version d'Expansion)
*Objectif : Flexibilité et Intelligence contextuelle.*

*   **Édition avant génération :** Possibilité de relire et modifier le texte généré par l'IA avant qu'il ne soit "gravé" dans le PDF.
*   **Recherche (Search) :** Barre de recherche pour trouver un mot-clé dans tous les résumés stockés.
*   **Chat avec les données (RAG) :** Poser une question à l'IA sur le contenu d'un dossier entier.
