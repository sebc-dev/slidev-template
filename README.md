# Slidev Template

Template de presentation [Slidev](https://sli.dev) avec layouts personnalises et theme configurable.

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/sebc-dev/slidev-template/main/create-slidev.sh | bash
```

## Layouts

| Layout | Usage | Description |
|--------|-------|-------------|
| `cover-title` | `layout: cover-title` | Image de fond plein ecran + titre centre |
| `chapter` | `layout: chapter` | Image de fond + panneau droit avec titre de chapitre (separation oblique) |
| `content` | `layout: content` | Breadcrumb chapitre/section en haut + zone de contenu |

### Frontmatter

```yaml
---
layout: cover-title
image: /photo.jpg          # image de fond
---

---
layout: chapter
image: /photo.jpg           # image de fond
chapter: Mon Chapitre       # titre du chapitre
section: Ma Section         # sous-titre
---

---
layout: content
chapter: Mon Chapitre       # affiche dans le breadcrumb
section: Ma Section
---
```

## Theme

Editer `styles/index.css` :

```css
:root {
  --theme-primary: #1a365d;       /* couleur principale */
  --theme-accent: #e53e3e;        /* couleur d'accent (separateurs) */
  --theme-font-title: 'Inter';    /* police des titres */
  --theme-font-body: 'Inter';     /* police du corps */
  --theme-cover-overlay: rgba(0, 0, 0, 0.45); /* assombrissement cover */
}
```

## Commandes

```bash
pnpm dev      # serveur de dev → http://localhost:3030
pnpm build    # build statique
pnpm export   # export PDF (necessite playwright-chromium)
```
