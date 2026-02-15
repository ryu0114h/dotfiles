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

echo "=== dotfiles link ==="

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
backup_if_exists ~/.gitignore
ln -sf "$DOTFILES_DIR/git/.gitignore" ~/.gitignore
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
ln -sf "$DOTFILES_DIR/mise/config.toml" ~/.config/mise/config.toml
echo "✓ mise config linked"

# yazi
mkdir -p ~/.config/yazi
for f in yazi.toml keymap.toml theme.toml; do
    backup_if_exists ~/.config/yazi/$f
    ln -sf "$DOTFILES_DIR/yazi/$f" ~/.config/yazi/$f
done
echo "✓ yazi config linked"

# Cursor / VSCode (shared keybindings)
CURSOR_USER_DIR="$HOME/Library/Application Support/Cursor/User"
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
for user_dir in "$CURSOR_USER_DIR" "$VSCODE_USER_DIR"; do
    if [ -d "$user_dir" ]; then
        backup_if_exists "$user_dir/keybindings.json"
        ln -sf "$DOTFILES_DIR/cursor/keybindings.json" "$user_dir/keybindings.json"
    fi
done
echo "✓ Cursor/VSCode keybindings linked"

# Serena
mkdir -p ~/.serena
backup_if_exists ~/.serena/serena_config.yml
ln -sf "$DOTFILES_DIR/serena/serena_config.yml" ~/.serena/serena_config.yml
echo "✓ Serena config linked"

# Claude Code
mkdir -p ~/.claude
backup_if_exists ~/.claude/settings.json
ln -sf "$DOTFILES_DIR/claude/settings.json" ~/.claude/settings.json
echo "✓ Claude Code config linked"

# Claude Code skills
backup_if_exists ~/.claude/skills
ln -sfn "$DOTFILES_DIR/claude/skills" ~/.claude/skills
echo "✓ Claude Code skills linked"

# Agent skills (shared across Cursor, Gemini CLI, Kiro CLI, Windsurf, etc.)
mkdir -p ~/.agents
backup_if_exists ~/.agents/skills
ln -sfn "$DOTFILES_DIR/claude/skills" ~/.agents/skills
echo "✓ Agent skills linked"

# Claude Code plugins
if command -v claude &> /dev/null && [ -f "$DOTFILES_DIR/claude/plugins.txt" ]; then
    while read -r plugin; do
        [ -n "$plugin" ] && claude plugin install "$plugin" --scope user 2>/dev/null || true
    done < "$DOTFILES_DIR/claude/plugins.txt"
    echo "✓ Claude Code plugins installed"
fi

# Claude Code MCP servers
if command -v claude &> /dev/null && [ -f "$DOTFILES_DIR/claude/mcp-servers.txt" ]; then
    while IFS='|' read -r name cmd; do
        [ -n "$name" ] && claude mcp add "$name" --scope user -- $cmd 2>/dev/null || true
    done < "$DOTFILES_DIR/claude/mcp-servers.txt"
    echo "✓ Claude Code MCP servers configured"
fi

# PATH に ~/.local/bin を追加するよう案内
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo ""
    echo "Note: Add ~/.local/bin to your PATH if not already:"
    echo '  export PATH="$HOME/.local/bin:$PATH"'
fi

echo "=== Done! ==="
