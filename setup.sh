#!/bin/bash

echo "=== dotfiles setup ==="

# Homebrew
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✓ Homebrew already installed"
fi

# Ghostty
if ! brew list --cask ghostty &> /dev/null; then
    echo "Installing Ghostty..."
    brew install --cask ghostty
else
    echo "✓ Ghostty already installed"
fi

# Starship
if ! command -v starship &> /dev/null; then
    echo "Installing Starship..."
    brew install starship
else
    echo "✓ Starship already installed"
fi

# tmux
if ! command -v tmux &> /dev/null; then
    echo "Installing tmux..."
    brew install tmux
else
    echo "✓ tmux already installed"
fi

# fzf
if ! command -v fzf &> /dev/null; then
    echo "Installing fzf..."
    brew install fzf
else
    echo "✓ fzf already installed"
fi

# Sheldon
if ! command -v sheldon &> /dev/null; then
    echo "Installing Sheldon..."
    brew install sheldon
else
    echo "✓ Sheldon already installed"
fi

# zoxide
if ! command -v zoxide &> /dev/null; then
    echo "Installing zoxide..."
    brew install zoxide
else
    echo "✓ zoxide already installed"
fi

echo ""
echo "=== Setup complete! ==="
echo "Next: run ./install.sh to create symlinks"
