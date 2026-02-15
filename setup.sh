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

# yazi
if ! command -v yazi &> /dev/null; then
    echo "Installing yazi..."
    brew install yazi
else
    echo "✓ yazi already installed"
fi

# yazi dependencies
# ffmpeg (video thumbnails)
if ! command -v ffmpeg &> /dev/null; then
    echo "Installing ffmpeg..."
    brew install ffmpeg
else
    echo "✓ ffmpeg already installed"
fi

# 7-Zip (archive extraction/preview)
if ! command -v 7zz &> /dev/null; then
    echo "Installing 7-Zip..."
    brew install sevenzip
else
    echo "✓ 7-Zip already installed"
fi

# jq (JSON preview)
if ! command -v jq &> /dev/null; then
    echo "Installing jq..."
    brew install jq
else
    echo "✓ jq already installed"
fi

# poppler (PDF preview)
if ! command -v pdftotext &> /dev/null; then
    echo "Installing poppler..."
    brew install poppler
else
    echo "✓ poppler already installed"
fi

# fd (file searching)
if ! command -v fd &> /dev/null; then
    echo "Installing fd..."
    brew install fd
else
    echo "✓ fd already installed"
fi

# ripgrep (file content searching)
if ! command -v rg &> /dev/null; then
    echo "Installing ripgrep..."
    brew install ripgrep
else
    echo "✓ ripgrep already installed"
fi

# resvg (SVG preview)
if ! command -v resvg &> /dev/null; then
    echo "Installing resvg..."
    brew install resvg
else
    echo "✓ resvg already installed"
fi

# ImageMagick (Font/HEIC/JPEG XL preview)
if ! command -v magick &> /dev/null; then
    echo "Installing ImageMagick..."
    brew install imagemagick
else
    echo "✓ ImageMagick already installed"
fi

# mise
if ! command -v mise &> /dev/null; then
    echo "Installing mise..."
    brew install mise
else
    echo "✓ mise already installed"
fi

# Claude Code
if ! command -v claude &> /dev/null; then
    echo "Installing Claude Code..."
    npm install -g @anthropic-ai/claude-code
else
    echo "✓ Claude Code already installed"
fi

echo ""
echo "=== Setup complete! ==="
echo "Next: run ./install.sh to create symlinks"
