
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

export BUN_INSTALL="$HOME/.bun"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$BUN_INSTALL/bin:$PATH"
export EDITOR="zed -n"
export TERM=xterm-256color
export WORDCHARS='*?[]~=&;!#$%^(){}<>'

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light Aloxaf/fzf-tab


zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::ruby

zinit snippet OMZP::command-not-found

zinit cdreplay -q


fpath=($HOME/.config/completions $fpath)

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
alias claude-mcp-config='cd /Users/arikj/Library/Application\ Support/Claude && nvim claude_desktop_config.json'

eval "$(task --completion zsh)"
eval "$(direnv hook zsh)"

. ~/.asdf/plugins/golang/set-env.zsh

[ -f $HOME/.zprofile ] && source ~/.zprofile

export ZELLIJ_AUTO_ATTACH=true

if [[ -z "$ZELLIJ" ]] && [[ "$TERM_PROGRAM" != "vscode" ]] && [[ "$TERM_PROGRAM" != "zed" ]]; then
    ZJ_SESSIONS=$(zellij list-sessions)

    if [[ -n "$ZJ_SESSIONS" ]]; then
        SELECTED_SESSION="$(echo -e "${ZJ_SESSIONS}\n[NEW SESSION]\n[NEW NAMED SESSION]" | sk --ansi --reverse --prompt="Select session: ")"
        if [[ "$SELECTED_SESSION" == "[NEW SESSION]" ]]; then
            zellij attach -c
        elif [[ "$SELECTED_SESSION" == "[NEW NAMED SESSION]" ]]; then
            echo -n "Enter session name: "
            read SESSION_NAME
            if [[ -n "$SESSION_NAME" ]]; then
                zellij -s "$SESSION_NAME"
            else
                zellij attach -c
            fi
        elif [[ -n "$SELECTED_SESSION" ]]; then
            # Extract the actual session name (strip ANSI codes and preserve full name)
            SESSION_NAME=$(echo "$SELECTED_SESSION" | sed 's/\x1b\[[0-9;]*m//g' | sed 's/ \[Created.*$//' | sed 's/^ *//' | sed 's/ *$//')

            # Check if this is an exited session that can be resurrected
            if echo "$SELECTED_SESSION" | grep -q "EXITED"; then
                echo "Attaching to exited session: $SESSION_NAME"
                zellij attach "$SESSION_NAME"
            else
                # For active sessions, just attach directly
                echo "Attaching to session: $SESSION_NAME"
                zellij attach "$SESSION_NAME"
            fi
        fi
    else
        zellij attach -c
    fi
fi


# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/arikj/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# opencode
export PATH=/Users/arik/.opencode/bin:$PATH
