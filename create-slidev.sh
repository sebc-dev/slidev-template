#!/usr/bin/env bash
set -euo pipefail

# === Slidev Template Installer ===
# Usage: ./create-slidev.sh <nom-du-projet> [titre]
# Exemple: ./create-slidev.sh ma-presentation "Mon Super Talk"

PROJECT_NAME="${1:-}"
TITLE="${2:-Ma Presentation}"

if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: $0 <nom-du-projet> [titre]"
  echo "Exemple: $0 ma-presentation \"Mon Super Talk\""
  exit 1
fi

if [ -d "$PROJECT_NAME" ]; then
  echo "Erreur: le dossier '$PROJECT_NAME' existe deja."
  exit 1
fi

echo "=> Creation du projet '$PROJECT_NAME'..."
mkdir -p "$PROJECT_NAME"/{styles,layouts,public}
cd "$PROJECT_NAME"

# --- package.json ---
cat > package.json << 'PKGJSON'
{
  "name": "slidev-template",
  "private": true,
  "scripts": {
    "dev": "slidev",
    "build": "slidev build",
    "export": "slidev export"
  },
  "dependencies": {
    "@slidev/cli": "^51.0.0",
    "@slidev/theme-default": "latest"
  }
}
PKGJSON

# --- styles/index.css ---
cat > styles/index.css << 'CSSEOF'
:root {
  /* === Couleurs === */
  --theme-primary: #1a365d;
  --theme-primary-light: #2b6cb0;
  --theme-accent: #e53e3e;
  --theme-text: #1a202c;
  --theme-text-light: #718096;
  --theme-bg: #ffffff;
  --theme-breadcrumb-bg: #f7fafc;
  --theme-breadcrumb-border: #e2e8f0;

  /* === Typographie === */
  --theme-font-title: 'Inter', sans-serif;
  --theme-font-body: 'Inter', sans-serif;

  /* === Espacement === */
  --theme-slide-padding: 2.5rem;

  /* === Cover overlay === */
  --theme-cover-overlay: rgba(0, 0, 0, 0.45);
  --theme-cover-text: #ffffff;

  /* === Separateur === */
  --theme-separator-width: 4rem;
  --theme-separator-thickness: 3px;
}
CSSEOF

# --- layouts/cover-title.vue ---
cat > layouts/cover-title.vue << 'VUEEOF'
<template>
  <div class="slidev-layout cover-title">
    <div
      class="cover-title__bg"
      :style="{ backgroundImage: `url(${$attrs.image || ''})` }"
    />
    <div class="cover-title__overlay" />
    <div class="cover-title__content">
      <slot />
    </div>
  </div>
</template>

<style scoped>
.cover-title {
  position: relative;
  width: 100%;
  height: 100%;
  overflow: hidden;
}

.cover-title__bg {
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
}

.cover-title__overlay {
  position: absolute;
  inset: 0;
  background: var(--theme-cover-overlay);
}

.cover-title__content {
  position: relative;
  z-index: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100%;
  padding: var(--theme-slide-padding);
  text-align: center;
  color: var(--theme-cover-text);
}

.cover-title__content :deep(h1) {
  font-family: var(--theme-font-title);
  font-size: 3.5rem;
  font-weight: 700;
  line-height: 1.2;
  margin: 0;
}

.cover-title__content :deep(h2) {
  font-family: var(--theme-font-body);
  font-size: 1.5rem;
  font-weight: 400;
  margin-top: 1rem;
  opacity: 0.85;
}

.cover-title__content :deep(p) {
  font-size: 1.25rem;
  opacity: 0.8;
  margin-top: 0.5rem;
}
</style>
VUEEOF

# --- layouts/chapter.vue ---
cat > layouts/chapter.vue << 'VUEEOF'
<template>
  <div class="slidev-layout chapter-layout">
    <div
      class="chapter-layout__bg"
      :style="{ backgroundImage: `url(${$attrs.image || ''})` }"
    />
    <div class="chapter-layout__right">
      <div class="chapter-layout__text">
        <div class="chapter-layout__separator" />
        <h1 class="chapter-layout__title">{{ $attrs.chapter }}</h1>
        <p class="chapter-layout__subtitle" v-if="$attrs.section">{{ $attrs.section }}</p>
        <div class="chapter-layout__slot">
          <slot />
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.chapter-layout {
  position: relative;
  height: 100%;
  width: 100%;
}

.chapter-layout__bg {
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
}

.chapter-layout__right {
  position: absolute;
  z-index: 1;
  top: 0;
  right: 0;
  display: flex;
  align-items: center;
  width: calc(50% + 30px);
  height: 100%;
  padding: var(--theme-slide-padding);
  padding-left: calc(var(--theme-slide-padding) + 40px);
  background: var(--theme-bg);
  clip-path: polygon(60px 0, 100% 0, 100% 100%, 0 100%);
}

.chapter-layout__text {
  max-width: 100%;
}

.chapter-layout__separator {
  width: var(--theme-separator-width);
  height: var(--theme-separator-thickness);
  background: var(--theme-accent);
  margin-bottom: 1.5rem;
}

.chapter-layout__title {
  font-family: var(--theme-font-title);
  font-size: 2.5rem;
  font-weight: 700;
  color: var(--theme-primary);
  margin: 0 0 0.75rem 0;
  line-height: 1.2;
}

.chapter-layout__subtitle {
  font-family: var(--theme-font-body);
  font-size: 1.25rem;
  color: var(--theme-text-light);
  margin: 0;
}

.chapter-layout__slot :deep(*) {
  margin-top: 1rem;
}
</style>
VUEEOF

# --- layouts/content.vue ---
cat > layouts/content.vue << 'VUEEOF'
<template>
  <div class="slidev-layout content-layout">
    <div class="content-layout__breadcrumb" v-if="$attrs.chapter">
      <span class="content-layout__chapter">{{ $attrs.chapter }}</span>
      <span class="content-layout__divider" v-if="$attrs.section">/</span>
      <span class="content-layout__section" v-if="$attrs.section">{{ $attrs.section }}</span>
    </div>
    <div class="content-layout__body">
      <slot />
    </div>
  </div>
</template>

<style scoped>
.content-layout {
  display: flex;
  flex-direction: column;
  height: 100%;
  width: 100%;
  background: var(--theme-bg);
  padding: 0;
}

.content-layout__breadcrumb {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: var(--theme-breadcrumb-bg);
  border-bottom: 1px solid var(--theme-breadcrumb-border);
  font-family: var(--theme-font-body);
  font-size: 0.875rem;
  flex-shrink: 0;
  margin: 0;
  width: 100%;
}

.content-layout__chapter {
  color: var(--theme-primary);
  font-weight: 600;
}

.content-layout__divider {
  color: var(--theme-text-light);
}

.content-layout__section {
  color: var(--theme-text-light);
}

.content-layout__body {
  flex: 1;
  padding: var(--theme-slide-padding);
  overflow: auto;
  color: var(--theme-text);
}

.content-layout__body :deep(h1) {
  font-family: var(--theme-font-title);
  font-size: 2rem;
  font-weight: 700;
  color: var(--theme-primary);
  margin: 0 0 1rem 0;
}

.content-layout__body :deep(h2) {
  font-family: var(--theme-font-title);
  font-size: 1.5rem;
  font-weight: 600;
  color: var(--theme-primary-light);
  margin: 1.5rem 0 0.75rem 0;
}

.content-layout__body :deep(ul),
.content-layout__body :deep(ol) {
  margin: 0.5rem 0;
  padding-left: 1.5rem;
}

.content-layout__body :deep(li) {
  margin: 0.25rem 0;
}

.content-layout__body :deep(code) {
  background: #edf2f7;
  padding: 0.125rem 0.375rem;
  border-radius: 0.25rem;
  font-size: 0.9em;
}
</style>
VUEEOF

# --- slides.md ---
cat > slides.md << MDEOF
---
theme: default
title: ${TITLE}
author: Your Name
fonts:
  sans: Inter
  provider: google
layout: cover-title
image: https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=1920
---

# ${TITLE}

Sous-titre de la presentation

---
layout: chapter
image: https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=1280
chapter: Chapitre 1
section: Introduction
---

---
layout: content
chapter: Chapitre 1
section: Introduction
---

# Premier slide de contenu

- Point 1
- Point 2
- Point 3

---
layout: cover-title
image: https://images.unsplash.com/photo-1519681393784-d120267933ba?w=1920
---

# Merci
MDEOF

# --- Installation des dependances ---
echo "=> Installation des dependances..."
if command -v pnpm &> /dev/null; then
  pnpm install
elif command -v npm &> /dev/null; then
  npm install
else
  echo "Erreur: ni pnpm ni npm n'est installe."
  exit 1
fi

echo ""
echo "=> Projet '$PROJECT_NAME' cree avec succes !"
echo ""
echo "   cd $PROJECT_NAME"
echo "   pnpm dev"
echo ""
echo "   Ouvrir http://localhost:3030"
echo ""
echo "   Pour personnaliser le theme : styles/index.css"
echo "   Pour editer les slides :      slides.md"
