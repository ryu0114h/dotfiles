#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== dotfiles install ==="

# Ghostty
mkdir -p ~/.config/ghostty
ln -sf "$DOTFILES_DIR/ghostty/config" ~/.config/ghostty/config
echo "✓ Ghostty config linked"

# Starship
mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/starship/starship.toml" ~/.config/starship.toml
echo "✓ Starship config linked"

# Git
ln -sf "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig
echo "✓ Git config linked"

echo "=== Done! ==="
