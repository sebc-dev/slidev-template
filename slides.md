---
theme: default
title: Slidev Template Demo
author: Your Name
fonts:
  sans: Inter
  provider: google
layout: cover-title
image: https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=1920
---

# Slidev Template

Un template moderne avec des layouts personnalisés

---
layout: chapter
image: https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=1280
chapter: Chapitre 1
section: Premiers pas
---

---
layout: content
chapter: Chapitre 1
section: Premiers pas
---

# Installation

- Cloner ce repository
- Lancer `pnpm install` pour installer les dépendances
- Lancer `pnpm dev` pour démarrer le serveur
- Ouvrir `http://localhost:3030` dans le navigateur

---
layout: content
chapter: Chapitre 1
section: Premiers pas
---

# Structure du projet

| Fichier | Rôle |
|---------|------|
| `slides.md` | Contenu de la présentation |
| `styles/index.css` | Variables CSS du thème |
| `layouts/` | Layouts personnalisés |
| `public/` | Assets statiques (images) |

---
layout: chapter
image: https://images.unsplash.com/photo-1555949963-aa79dcee981c?w=1280
chapter: Chapitre 2
section: Thème & Personnalisation
---

---
layout: content
chapter: Chapitre 2
section: Thème & Personnalisation
---

# Personnaliser le thème

Éditez `styles/index.css` pour modifier :

- **Couleurs** : `--theme-primary`, `--theme-accent`
- **Typographie** : `--theme-font-title`, `--theme-font-body`
- **Espacement** : `--theme-slide-padding`
- **Overlay cover** : `--theme-cover-overlay`

---
layout: cover-title
image: https://images.unsplash.com/photo-1519681393784-d120267933ba?w=1920
---

# Merci

Commencez à créer votre présentation
