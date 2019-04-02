#!/usr/bin/env bash
# Initialization file for non-login, interactive shell
# Maintainer: Faris Chugthai

# Don't run if not interactive: {{{1
case $- in
    *i*);;
    *) return 0;;
esac

pathadd() {  # {{{1
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

# $_ROOT: {{{1
# shellcheck disable=2153
if [[ -n "$PREFIX" ]]; then
    export _ROOT="$PREFIX"
else
    export _ROOT="/usr"
fi

# Python: {{{1

# Put python first because we need conda initialized right away

# Conda: {{{2
if [[ -d "$HOME/miniconda3/bin/" ]]; then
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$($HOME/miniconda3/bin/conda shell.bash hook 2> /dev/null)"
if [[ $__conda_setup == 0 ]]; then
    eval "$__conda_setup"
else
    if [[ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]]; then
        # shellcheck source=/home/faris/miniconda3/etc/profile.d/conda.sh
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        pathadd "$HOME/miniconda3/bin"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
fi

# }}}
# https://pip.pypa.io/en/stable/user_guide/#command-completion
if [[ -n "$(command -v pip)" ]]; then
    eval "$(pip completion --bash)"
fi

export PYTHONDONTWRITEBYTECODE=1

# GCloud: {{{2

if [[ -d ~/google-cloud-sdk ]]; then
    # shellcheck source=~/google-cloud-sdk/completion.bash.inc
    source "$HOME/google-cloud-sdk/completion.bash.inc"
    # shellcheck source=~/google-cloud-sdk/path.bash.inc
    source "$HOME/google-cloud-sdk/path.bash.inc"
fi

# Defaults in Ubuntu bashrcs: {{{1

# make less more friendly for non-text input files, see lesspipe(1)
# Also lesspipe is described in Input Preprocessors in man 1 less.
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/bash lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [[ -z "${debian_chroot:-}" ]] && [[ -r /etc/debian_chroot ]]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# GBT: {{{1
if [[ -n "$(command -v gbt)" ]]; then
    prompt_tmp=$(gbt $?)
    export PS1=$prompt_tmp

    export GBT_CARS="Status, Os, Hostname, Dir, Git, Sign"
    export GBT_CAR_STATUS_FORMAT=" {{ Code }} {{ Signal }} "
fi

# Vim: {{{1

set -o vi

if [[ -n "$(command -v nvim)" ]]; then
    export VISUAL="nvim"
else
    export VISUAL="vim"
fi
export EDITOR="$VISUAL"

# JavaScript: {{{1

# Source npm completion if its installed.
if [[ -n "$(command -v npm)" ]]; then
    # shellcheck source=/home/faris/.bashrc.d/npm-completion.bash
    source ~/.bashrc.d/npm-completion.bash
fi

# Export nvm if the directory exists
if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
    # Load nvm and bash completion
    # shellcheck source=/home/faris/.nvm/nvm.sh
    [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh" # This loads nvm
    # shellcheck source=/home/faris/.nvm/bash_completion
    [[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
fi

# Testing out the language servers to see if they'll link up with neovim
pathadd "$HOME/.local/share/nvim/site/node_modules/.bin"

# FZF: {{{1

# Remember to keep this below set -o vi or else FZF won't inherit vim keybindings!
if [[ -f ~/.fzf.bash ]]; then
    export FZF_TMUX_HEIGHT=80%
    # shellcheck source=/home/faris/.fzf.bash
    source "$HOME/.fzf.bash"
fi


if [[ -n "$(command -v rg)" ]]; then

    export FZF_DEFAULT_COMMAND='rg --hidden --no-messages $*'
    export FZF_DEFAULT_OPTS='--multi --cycle  --ansi'

    export FZF_CTRL_T_COMMAND='rg --hidden --no-messages --max-count 10 --files $* '
    export FZF_CTRL_T_OPTS='--multi --cycle --border --reverse --preview-window=right:60%:wrap --ansi --bind ?:toggle-preview --header "Press ? to toggle preview." '

    export FZF_CTRL_R_COMMAND="rg --no-messages $*"
    export FZF_CTRL_R_OPTS="--cycle --ansi --preview 'echo {}' --preview-window=down:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip)+abort' --header 'Press CTRL-Y to copy command into clipboard' "

    export FZF_ALT_C_COMMAND="rg --files $*"

    if [[ -x ~/.local/share/nvim/plugged/fzf.vim/bin/preview.rb ]]; then
        export FZF_CTRL_T_OPTS+=" --preview '~/.local/share/nvim/plugged/fzf.vim/bin/preview.rb {} | head -200'"
    else
        export FZF_CTRL_T_OPTS+='--preview "head -100 {}"'
    fi
    Ag() { ag -l -g "" | fzf; };
    Rg() { $FZF_DEFAULT_COMMAND  | fzf-tmux $FZF_DEFAULT_OPTS -r 40; };


elif [[ -n "$(command -v fd)" ]]; then

    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow -j 8 -d 6 --exclude .git'
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow -j 8 -e --exclude .git'
    export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow -j 8 -d 6 --exclude .git'

    export FZF_CTRL_T_OPTS='--multi --cycle --border --reverse --preview "head -100 {}" --preview-window=down:50%:wrap --ansi --bind ?:toggle-preview --header "Press ? to toggle preview."'

    if [[ -x ~/.local/share/nvim/plugged/fzf.vim/bin/preview.rb ]]; then
        export FZF_CTRL_T_OPTS+=" --preview '~/.local/share/nvim/plugged/fzf.vim/bin/preview.rb {} | head -200'"
    fi


else
    export FZF_DEFAULT_COMMAND='find * -type f'

    # Options for FZF no matter what.
    export FZF_DEFAULT_OPTS=' --cycle'
fi

# termux doesnt have xclip or xsel

command -v tree > /dev/null && export FZF_ALT_C_OPTS="--preview 'tree -aF -I .git -I __pycache__ -C {} | head -200' "

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.

if [[ -n "$(command -v fd)" ]]; then
    _fzf_compgen_path() {
        fd --hidden --follow --exclude ".git" . "$1"
    }
    # Use fd to generate the list for directory completion
    _fzf_compgen_dir() {
        fd --type d --hidden --follow --exclude ".git" . "$1"
    }
fi

complete -F _fzf_path_completion -o default -o bashdefault ag
complete -F _fzf_dir_completion -o default -o bashdefault tree

# Sourced files: {{{1

# shellcheck source=/usr/share/bash-completion/bash_completion
test  -f "$_ROOT/share/bash-completion/bash_completion" && source "$_ROOT/share/bash-completion/bash_completion"

if [[ -d ~/.bashrc.d ]]; then
    for config in $HOME/.bashrc.d/*.bash; do
        # shellcheck source=/home/faris/.bashrc.d/*.bash
        source $config;
    done
    unset -v config
fi

# Here's one for the terminal
if [[ -n "$(command -v kitty)" ]]; then
    source <(kitty + complete setup bash)
fi

# add some cool colors to ls
eval "$( dircolors -b ~/.dircolors )"

# Secrets: {{{1
if [[ -f "$HOME/.bashrc.local" ]]; then
    # shellcheck source=/home/faris/.bashrc.local
    . "$HOME/.bashrc.local"
fi
