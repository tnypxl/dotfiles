
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git q "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load zsh-completions
autoload -Uz compinit && compinit

# bun
export BUN_INSTALL="$HOME/.bun"

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$BUN_INSTALL/bin:$PATH"
export EDITOR="nvim"
export TERM=xterm-256color


# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light Aloxaf/fzf-tab

# Setup custom completions
fpath=($HOME/.config/completions $fpath)

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::ruby
zinit snippet OMZP::command-not-found

zinit cdreplay -q

bindkey -e

# History
HISTSIZE=100000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:z:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Initialize zoxide and fzf completions
eval "$(zoxide init zsh --cmd z)"
source <(fzf --zsh)

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Jump to the start of the line
bindkey '^[^[[H' beginning-of-line
bindkey '^[[H' beginning-of-line

# Jump to the end of the line
bindkey '^[^[[F' end-of-line
bindkey '^[[F' end-of-line

# Skip words forwards and backwards
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word


# Aliases
alias task="task -t ~/Taskfile.yaml"
# alias t="task -g $1"
alias vim="nvim"

# ls to eza aliases
alias ls='eza $eza_params'
alias lsdf='eza -lah --group-directories-first $eza_params'
alias l='eza --git-ignore $eza_params'
alias ll='eza --all --header --long $eza_params'
alias llm='eza --all --header --long --sort=modified $eza_params'
alias la='eza -lbhHigUmuSa'
alias lx='eza -lbhHigUmuSa@'
alias lt='eza --tree --group-directories-first $eza_params'
alias tree='eza --tree --group-directories-first $eza_params'

eval "$(task --completion zsh)"

# Dynamically set GO env vars
. ~/.asdf/plugins/golang/set-env.zsh

[ -f $HOME/.zprofile ] && source ~/.zprofile

# Only start Zellij if not already in a Zellij session and not in VSCode or Zed terminal
if [[ -z "$ZELLIJ" ]] && [[ "$TERM_PROGRAM" != "vscode" ]] && [[ "$TERM_PROGRAM" != "zed" ]]; then
    # Check if Zellij is installed
    if command -v zellij >/dev/null 2>&1; then
        if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
            zellij attach -c
        else
            zellij
        fi

        if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
            exit
        fi
    else
        echo "Zellij is not installed. Please install it first."
    fi
fi

