# Zsh configuration
export EDITOR=nvim
export VISUAL=zed

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# Completion
autoload -Uz compinit
compinit

# Aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias notepad='$VISUAL ~/Nextcloud/notepad/'
alias ssh='kitten ssh'

# Tools
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

# FZF
source <(fzf --zsh)
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# Path
export PATH="$HOME/.local/bin:$PATH"

# TikTok Alias
alias tiktok='/home/pguin/Desktop/tiktok/tiktok.sh'


function y() {
  local tmp="$(mktemp -t "yazi-cwd-XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "cwd" != "$PWD" ]; then 
    cd -- "$cwd"
  fi 
  rm -f -- "$tmp"
}
