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

trap 'source /root/.bashrc' USR1
