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

# tmux
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" ~/.tmux.conf
echo "✓ tmux config linked"

# cwt script
mkdir -p ~/.local/bin
ln -sf "$DOTFILES_DIR/scripts/cwt" ~/.local/bin/cwt
chmod +x ~/.local/bin/cwt
echo "✓ cwt script linked to ~/.local/bin/cwt"

# Sheldon
mkdir -p ~/.config/sheldon
ln -sf "$DOTFILES_DIR/sheldon/plugins.toml" ~/.config/sheldon/plugins.toml
echo "✓ Sheldon config linked"

# PATH に ~/.local/bin を追加するよう案内
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo ""
    echo "Note: Add ~/.local/bin to your PATH if not already:"
    echo '  export PATH="$HOME/.local/bin:$PATH"'
fi

echo "=== Done! ==="
