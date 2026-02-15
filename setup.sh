#!/bin/bash

echo "=== dotfiles setup ==="

# Homebrew
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✓ Homebrew already installed"
fi

# Brew packages
echo "Installing Brew packages..."
brew bundle --file="$(cd "$(dirname "$0")" && pwd)/Brewfile"

# Claude Code
if ! command -v claude &> /dev/null; then
    echo "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | sh
else
    echo "✓ Claude Code already installed"
fi

echo ""
echo "=== Setup complete! ==="
echo "Next: run ./link.sh to create symlinks"
