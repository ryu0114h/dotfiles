# =============================================================================
# Environment
# =============================================================================
export CLICOLOR=1
export TERM=xterm-256color

# =============================================================================
# History
# =============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt share_history          # Share history between terminals
setopt hist_ignore_dups       # Ignore duplicates
setopt hist_ignore_all_dups   # Remove older duplicates
setopt hist_ignore_space      # Ignore commands starting with space
setopt hist_reduce_blanks     # Remove extra blanks
setopt inc_append_history     # Add commands immediately

# =============================================================================
# Completions (must be before sheldon for fzf-tab)
# =============================================================================
autoload -Uz compinit
compinit

# =============================================================================
# Sheldon (Plugin Manager)
# =============================================================================
eval "$(sheldon source)"

# =============================================================================
# Abbreviations (zsh-abbr)
# =============================================================================
abbr -S g="git" 2>/dev/null

# =============================================================================
# Tools
# =============================================================================
# mise (runtime version manager)
eval "$(mise activate zsh)"

# fzf
eval "$(fzf --zsh)"

# zoxide (smart cd)
eval "$(zoxide init zsh)"

# Starship prompt
eval "$(starship init zsh)"

# =============================================================================
# Local config (machine-specific, not tracked in git)
# =============================================================================
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
