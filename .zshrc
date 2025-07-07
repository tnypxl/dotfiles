
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
export EDITOR="zed -n"
export TERM=xterm-256color

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light Aloxaf/fzf-tab

fpath=($HOME/.config/completions $fpath)

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::ruby
zinit snippet OMZP::command-not-found

zinit cdreplay -q

export WORDCHARS='*?[]~=&;!#$%^(){}<>'

bindkey -e

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

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:z:*' fzf-preview 'ls $realpath'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls $realpath'

eval "$(zoxide init zsh --cmd z)"
source <(fzf --zsh)

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey '^[^[[H' beginning-of-line
bindkey '^[[H' beginning-of-line

bindkey '^[^[[F' end-of-line
bindkey '^[[F' end-of-line

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

bindkey "^[[3~" delete-char

alias task="task -t ~/Taskfile.yaml"
alias vim="nvim"

alias ls='eza $eza_params'
alias lsdf='eza -lah --group-directories-first $eza_params'
alias l='eza --git-ignore $eza_params'
alias ll='eza --all --header --group-directories-first --long $eza_params'
alias llm='eza --all --header --group-directories-first --long --sort=modified $eza_params'
alias la='eza -lbhHigUmuSa'
alias lx='eza -lbhHigUmuSa@'
alias lt='eza --tree --group-directories-first $eza_params'
alias tree='eza --tree --group-directories-first $eza_params'

alias zclear='zellij action clear'

eval "$(task --completion zsh)"
eval "$(direnv hook zsh)"

. ~/.asdf/plugins/golang/set-env.zsh

[ -f $HOME/.zprofile ] && source ~/.zprofile

export ZELLIJ_AUTO_ATTACH=true

ZJ_SESSIONS=$(zellij list-sessions | grep -v EXITED)
NO_SESSIONS=$(echo "${ZJ_SESSIONS}" | wc -l)

if [[ -z "$ZELLIJ" ]] && [[ "$TERM_PROGRAM" != "vscode" ]] && [[ "$TERM_PROGRAM" != "zed" ]]; then
    if [ "${NO_SESSIONS}" -ge 2 ]; then
        SELECTED_SESSION="$(echo "${ZJ_SESSIONS}" | sk --ansi --reverse | sed 's/ \[.*\].*$//')"
        zellij attach $SELECTED_SESSION
    else
        zellij attach -c
    fi
fi
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/arikj/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
