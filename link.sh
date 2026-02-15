#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

backup_if_exists() {
    local file="$1"
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        mv "$file" "$file.backup"
        echo "  → Backed up to $file.backup"
    fi
}

link_file() {
    local src="$DOTFILES_DIR/$1"
    local dest="$2"
    mkdir -p "$(dirname "$dest")"
    backup_if_exists "$dest"
    ln -sf "$src" "$dest"
}

link_dir() {
    local src="$DOTFILES_DIR/$1"
    local dest="$2"
    mkdir -p "$(dirname "$dest")"
    backup_if_exists "$dest"
    ln -sfn "$src" "$dest"
}

echo "=== dotfiles link ==="

# Configs
link_file "ghostty/config"         ~/.config/ghostty/config
link_file "starship/starship.toml" ~/.config/starship.toml
link_file "git/.gitconfig"         ~/.gitconfig
link_file "git/.gitignore"         ~/.gitignore
link_file "tmux/.tmux.conf"       ~/.tmux.conf
link_file "zsh/.zshrc"            ~/.zshrc
link_file "sheldon/plugins.toml"  ~/.config/sheldon/plugins.toml
link_file "mise/config.toml"      ~/.config/mise/config.toml
link_file "serena/serena_config.yml" ~/.serena/serena_config.yml
link_file "claude/settings.json"  ~/.claude/settings.json
echo "✓ Configs linked"

# yazi
for f in yazi.toml keymap.toml theme.toml; do
    link_file "yazi/$f" ~/.config/yazi/$f
done
echo "✓ yazi config linked"

# Cursor / VSCode (shared keybindings)
for user_dir in "$HOME/Library/Application Support/Cursor/User" "$HOME/Library/Application Support/Code/User"; do
    [ -d "$user_dir" ] && link_file "cursor/keybindings.json" "$user_dir/keybindings.json"
done
echo "✓ Cursor/VSCode keybindings linked"

# cwt script
link_file "scripts/cwt" ~/.local/bin/cwt
chmod +x ~/.local/bin/cwt
echo "✓ cwt script linked"

# Skills (directory symlinks)
link_dir "claude/skills" ~/.claude/skills
link_dir "claude/skills" ~/.agents/skills
echo "✓ Skills linked"

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

# PATH check
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo ""
    echo "Note: Add ~/.local/bin to your PATH if not already:"
    echo '  export PATH="$HOME/.local/bin:$PATH"'
fi

echo "=== Done! ==="
