#!/usr/bin/env bash
set -euo pipefail

REPO="sebc-dev/slidev-template"
BRANCH="main"

echo ""
echo "  Slidev Template Installer"
echo "  ========================="
echo ""

read -rp "Nom du projet: " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
  echo "Erreur: nom du projet requis."
  exit 1
fi

if [ -d "$PROJECT_NAME" ]; then
  echo "Erreur: le dossier '$PROJECT_NAME' existe deja."
  exit 1
fi

echo ""
echo "=> Telechargement du template..."
tmpdir=$(mktemp -d)
curl -sL "https://github.com/$REPO/archive/refs/heads/$BRANCH.tar.gz" | tar -xz -C "$tmpdir"

mv "$tmpdir/slidev-template-$BRANCH" "$PROJECT_NAME"
rm -rf "$tmpdir"

cd "$PROJECT_NAME"

# Nettoyage des fichiers du repo template
rm -f create-slidev.sh
rm -rf .agents .git

echo "=> Installation des dependances..."
if command -v pnpm &> /dev/null; then
  pnpm install --silent
elif command -v npm &> /dev/null; then
  npm install --silent
else
  echo "Erreur: ni pnpm ni npm n'est installe."
  exit 1
fi

echo "=> Installation du skill Slidev (derniere version)..."
npx -y skills add slidevjs/slidev 2>/dev/null || echo "   Skill non installe (npx indisponible). Lancez: npx skills add slidevjs/slidev"

echo ""
echo "=> Projet '$PROJECT_NAME' pret !"
echo ""
echo "   cd $PROJECT_NAME"
echo "   pnpm dev"
echo ""
echo "   Theme :  styles/index.css"
echo "   Slides : slides.md"
echo ""
