#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Backup existing file if it's not a symlink
backup_if_exists() {
    local file="$1"
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        mv "$file" "$file.backup"
        echo "  → Backed up to $file.backup"
    fi
}

echo "=== dotfiles install ==="

# Ghostty
mkdir -p ~/.config/ghostty
backup_if_exists ~/.config/ghostty/config
ln -sf "$DOTFILES_DIR/ghostty/config" ~/.config/ghostty/config
echo "✓ Ghostty config linked"

# Starship
mkdir -p ~/.config
backup_if_exists ~/.config/starship.toml
ln -sf "$DOTFILES_DIR/starship/starship.toml" ~/.config/starship.toml
echo "✓ Starship config linked"

# Git
backup_if_exists ~/.gitconfig
ln -sf "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig
echo "✓ Git config linked"

# tmux
backup_if_exists ~/.tmux.conf
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" ~/.tmux.conf
echo "✓ tmux config linked"

# cwt script
mkdir -p ~/.local/bin
backup_if_exists ~/.local/bin/cwt
ln -sf "$DOTFILES_DIR/scripts/cwt" ~/.local/bin/cwt
chmod +x ~/.local/bin/cwt
echo "✓ cwt script linked to ~/.local/bin/cwt"

# Zsh
backup_if_exists ~/.zshrc
ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
echo "✓ Zsh config linked"

# Sheldon
mkdir -p ~/.config/sheldon
backup_if_exists ~/.config/sheldon/plugins.toml
ln -sf "$DOTFILES_DIR/sheldon/plugins.toml" ~/.config/sheldon/plugins.toml
echo "✓ Sheldon config linked"

# mise
mkdir -p ~/.config/mise
backup_if_exists ~/.config/mise/config.toml
ln -sf "$DOTFILES_DIR/.config/mise/config.toml" ~/.config/mise/config.toml
echo "✓ mise config linked"

# Claude Code
mkdir -p ~/.claude
backup_if_exists ~/.claude/settings.json
ln -sf "$DOTFILES_DIR/.claude/settings.json" ~/.claude/settings.json
echo "✓ Claude Code config linked"

# Claude Code plugins
if command -v claude &> /dev/null && [ -f "$DOTFILES_DIR/.claude/plugins.txt" ]; then
    while read -r plugin; do
        [ -n "$plugin" ] && claude plugin install "$plugin" --scope user 2>/dev/null || true
    done < "$DOTFILES_DIR/.claude/plugins.txt"
    echo "✓ Claude Code plugins installed"
fi

# Claude Code MCP servers
if command -v claude &> /dev/null && [ -f "$DOTFILES_DIR/.claude/mcp-servers.txt" ]; then
    while IFS='|' read -r name cmd; do
        [ -n "$name" ] && claude mcp add "$name" --scope user -- $cmd 2>/dev/null || true
    done < "$DOTFILES_DIR/.claude/mcp-servers.txt"
    echo "✓ Claude Code MCP servers configured"
fi

# PATH に ~/.local/bin を追加するよう案内
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo ""
    echo "Note: Add ~/.local/bin to your PATH if not already:"
    echo '  export PATH="$HOME/.local/bin:$PATH"'
fi

echo "=== Done! ==="
