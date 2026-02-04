# shellcheck disable=SC2034
# shellcheck disable=SC1090
# shellcheck disable=SC1094

if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Load Zinit
if [[ -f "/opt/homebrew/opt/zinit/zinit.zsh" ]]; then
    source '/opt/homebrew/opt/zinit/zinit.zsh'
fi


eval "$(oh-my-posh init zsh --config ${HOME}/.config/ohmyposh/zen.toml)"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Add custom completion directories to fpath BEFORE compinit
fpath=("$HOME/.config/completions" "${fpath[@]}")
fpath=("$HOME/.docker/completions" "${fpath[@]}")

# Load zsh-completions
autoload -Uz compinit && compinit
# autoload -Uz bashcompinit && bashcompinit


export BUN_INSTALL="$HOME/.bun"
export PATH="/opt/homebrew/bin:${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$BUN_INSTALL/bin:$PATH"
export EDITOR="zed -n"
export TERM=xterm-256color
export WORDCHARS='*?[]~=&;!#$%^(){}<>'

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light Aloxaf/fzf-tab

zinit snippet OMZP::git
zinit snippet OMZP::git-commit
zinit snippet OMZP::sudo
# zinit snippet OMZP::aws
zinit snippet OMZP::ruby
zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose
zinit snippet OMZP::command-not-found
zinit snippet OMZP::dotenv
zinit snippet OMZP::1password

zinit cdreplay -q

bindkey -e

HISTSIZE=250000
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
zstyle ':fzf-tab:complete:z:*' fzf-preview "ls $(realpath)"
zstyle ':fzf-tab:complete:cd:*' fzf-preview "ls $(realpath)"
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview "ls $(realpath)"

source <(fzf --zsh)

eval "$(zoxide init zsh --cmd z)"

# Up Arrow for history substring search up
bindkey '^[[A' history-substring-search-up
# Down Arrow for history substring search down
bindkey '^[[B' history-substring-search-down

# Option+Home / Home to go to beginning of line
bindkey '^[^[[H' beginning-of-line
bindkey '^[[H' beginning-of-line

# Option+End / End to go to end of line
bindkey '^[^[[F' end-of-line
bindkey '^[[F' end-of-line

# Ctrl+Right to move forward by word
bindkey '^[[1;5C' forward-word
# Ctrl+Left to move backward by word
bindkey '^[[1;5D' backward-word

# Delete key to delete character under cursor
bindkey "^[[3~" delete-char

# Option+Delete to delete word backward
bindkey '^[^?' backward-kill-word

# Option+Left/Right to move by word (alternative keycodes for some terminals)
bindkey '^[^[[C' forward-word
bindkey '^[^[[D' backward-word

# Fn+Delete to delete word forward
bindkey '^[[3;5~' kill-word

# Command+Left/Right to move to beginning/end of line (terminal dependent)
bindkey '^[[1;9D' beginning-of-line
bindkey '^[[1;9C' end-of-line

# Command+Backspace to delete to beginning of line
bindkey '^[^H' backward-kill-line

# Control+U to delete entire line
bindkey '^U' kill-whole-line

# Control+K to delete from cursor to end of line
bindkey '^K' kill-line

# Control+W to delete word backward
bindkey '^W' backward-kill-word

nv() {
    if [[ "$1" == "--sync" ]]; then
        echo "Syncing plugins..."
        nvim --headless "+Lazy! sync" +qa
        shift
    fi
    nvim "$@"
}

eza_params="--icons --group-directories-first --git --classify"

alias vim="nv"
alias ls="eza $eza_params"
alias lsdf="eza -lah $eza_params"
alias l="eza --git-ignore $eza_params"
alias ll="eza -A --header --long $eza_params"
alias llm="eza -A --header --long --sort=modified $eza_params"
alias la="eza -lbhHigUmua $eza_params"
alias lx="eza -lbhHigUmua@ $eza_params"
alias lt="eza --tree $eza_params"
alias tree="eza --tree $eza_params"
alias zc='zellij action clear'

source ~/.asdf/plugins/golang/set-env.zsh

[ -f "$HOME"/.zprofile ] && source ~/.zprofile

eval "$(direnv hook zsh)"

source <(procs --gen-completion-out zsh)

eval "$(mise activate zsh)"

if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
  function terminal_title_preexec() {
    # Extract command name: ${1%% *} gets first word, :t gets basename
    local cmd_name="${${1%% *}:t}"
    local folder_name="${PWD:t}"
    print -Pn -- "\e]2;${cmd_name} * ${folder_name}\a"
  }

  # Only add the preexec hook. OMP handles the precmd behavior now.
  add-zsh-hook -Uz preexec terminal_title_preexec
fi


# export ZELLIJ_AUTO_ATTACH=true
# 
# if [[ $- == *i* ]] && [[ -t 0 ]] && [[ -z "$ZELLIJ" ]] && [[ "$TERM_PROGRAM" == "ghostty" ]]; then
#     ZJ_SESSIONS=$(zellij list-sessions)
# 
#     if [[ -n "$ZJ_SESSIONS" ]]; then
#         SELECTED_SESSION="$(echo -e "${ZJ_SESSIONS}\n[NEW SESSION]\n[NEW NAMED SESSION]" | sk --ansi --reverse --prompt="Select session: ")"
#         if [[ "$SELECTED_SESSION" == "[NEW SESSION]" ]]; then
#             zellij
#         elif [[ "$SELECTED_SESSION" == "[NEW NAMED SESSION]" ]]; then
#             echo -n "Enter session name: "
#             read SESSION_NAME
#             if [[ -n "$SESSION_NAME" ]]; then
#                 zellij -s "$SESSION_NAME"
#             else
#                 zellij attach -c
#             fi
#         elif [[ -n "$SELECTED_SESSION" ]]; then
#             # Extract the actual session name (strip ANSI codes and preserve full name)
#             SESSION_NAME=$(echo "$SELECTED_SESSION" | sed 's/\x1b\[[0-9;]*m//g' | sed 's/ \[Created.*$//' | sed 's/^ *//' | sed 's/ *$//')
# 
#             # Check if this is an exited session that can be resurrected
#             if echo "$SELECTED_SESSION" | grep -q "EXITED"; then
#                 echo "Attaching to exited session: $SESSION_NAME"
#                 zellij attach "$SESSION_NAME"
#             else
#                 # For active sessions, just attach directly
#                 echo "Attaching to session: $SESSION_NAME"
#                 zellij attach "$SESSION_NAME"
#             fi
#         fi
#     else
#         zellij attach -c
#     fi
#  fi
