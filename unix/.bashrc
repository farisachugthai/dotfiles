#!/usr/bin/env bash
# Initialization file for non-login, interactive shell
# Maintainer: Faris Chugthai

# Don't run if not interactive: {{{1
case $- in
    *i*);;
    *) exit 0;;
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
export PYTHONDONTWRITEBYTECODE=1

# LDflags gets defined in here and as a result numpy fails to build
export NPY_DISTUTILS_APPEND_FLAGS=1

export PYTHONDOCS="$HOME/python/official-python-docs/3.7/library/build/html"

export PYTHONIOENCODING=utf-8:surrogateescape
export IPYTHONDIR="$HOME/.ipython"
export PYTHONCOERCECLOCALE=warn
if [[ -n "$(command -v ipdb)" ]];  then export PYTHONBREAKPOINT="ipdb"; fi
export PYTHONUNBUFFERED=1

# Conda: {{{2
# >>> conda initialize >>>  {{{2
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [[ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]]; then
        source "$HOME/miniconda3/etc/profile.d/conda.sh"
    elseif [[ -d "$HOME/miniconda3/bin" ]]
        pathadd "$HOME/miniconda3/bin"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


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
[[ -x lesspipe ]] && eval "$(SHELL=/bin/bash lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [[ -z "${debian_chroot:-}" ]] && [[ -r /etc/debian_chroot ]]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Vim: {{{1
if [[ -n "$(command -v nvim)" ]]; then
    export VISUAL="nvim"
else
    export VISUAL="vim"
fi
export EDITOR="$VISUAL"

# Builds: {{{1

export PKG_CONFIG_PATH='/usr/share/pkgconfig'
test "$(command -v luarocks)" && eval "$(luarocks path; luarocks path --append)"
# History: {{{1

# Don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=-1
export HISTFILESIZE=-1
# https://unix.stackexchange.com/a/174902
export HISTTIMEFORMAT="%F %T: "
# Ignore all the damn cds, ls's its a waste to have pollute the history
export HISTIGNORE='exit:ls:cd:history:ll:la:gs'
# Apparently I never named histfile?
export HISTFILE="$HOME/.bash_history"

# Append to the history file, don't overwrite it
shopt -s histappend
shopt -s histreedit
# Shopt and set: {{{1
set -o emacs
# To check what options you've set with set, check the output of: $: echo $-
# As of Aug 28, 2019 I got: bhimBCHs

# I always forget keep this below set -o vi!
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
# Be notified of asynchronous jobs completing in the background
set -o notify
# Check the window size after each command and update the values of LINES and COLUMNS.
# Now the default in Bash 5!!!
shopt -s checkwinsize

# Why the hell does termux have this listed as off?
# if a pipe fails it returns the far most right expr which could be 0. stop that shit let me know what the err code was!
shopt -s lastpipe

# ** will match all files and zero or more directories and subdirectories.
# shellcheck disable=SC2128
if [[ $BASH_VERSINFO -gt 3 ]]; then shopt -s globstar; fi

# If an attempt is made to exit bash , list currently running jobs, their status and a warning
shopt -s checkjobs

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
set -o noclobber        # Still dont want to clobber things
shopt -s xpg_echo       # Allows echo to read backslashes like \n and \t
shopt -s dirspell       # Autocorrect the spelling if it can
shopt -s cdspell

# This should be enabled by default but termux is listing it as off
shopt -s hostcomplete

# If you try to complete something that isn't a command, check if its an alias
if [[ $BASH_VERSINFO -gt 4 ]]; then shopt -s progcomp_alias; fi

# Print verbose error messages when using shift
shopt -s shift_verbose

shopt -s no_empty_cmd_completion
# If set, and the cmdhist option is enabled, multi-line commands are saved to
# the history with embedded newlines rather than using semicolon separators
shopt -s lithist cmdhist

shopt -s direxpand

# if a pipe fails it returns the far most right expr which could be 0. stop that shit let me know what the err code was!
shopt -s lastpipe

export COLORTERM="truecolor"

# Less And $PAGER --- Checkout .lesskey for more {{{1

# -J displays a status column at the left edge of the screen
# -R is what we need for ansi colors
# -K: exit less in response to Ctrl-C
# -M: Verbose prompt
# -L: Line numbers. Open a man page and hit 'G' to see what you're getting into
# -i: Ignore case. Works similarly to how modern programs handle smart case!
# --mouse: Take a guess
# -g only one  search match highlighted
# -e EOF reached twice? Close automatically.
# -N always display line nrs
export PAGER="less -JRKMLigeN" 
export LESSHISTSIZE=5000  # default is 100

# Oh shit! --mouse is a bash>5 feature!
if [[ $BASH_VERSINFO -gt 4 ]]; then export PAGER="$PAGER --mouse --no-histdups --save-marks "; fi

if [[ -x lesspipe.sh ]]; then export LESSOPEN="|lesspipe.sh %s"; fi

# JavaScript: {{{2

# Export nvm if the directory exists
if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
    # Load nvm and bash completion
    # shellcheck source=/home/faris/.nvm/nvm.sh
    [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh" # This loads nvm
    # shellcheck source=/home/faris/.nvm/bash_completion
    [[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
    pathadd "$HOME/.nvm"  # Not a ton of good reasons but good to see it in path
    npm config delete prefix
    nvm use default --delete-prefix
fi

# Testing out the language servers to see if they'll link up with neovim
pathadd "$HOME/.local/share/nvim/site/node_modules/.bin"

# Fasd: {{{2

fasd_cache="$HOME/.fasd-init-bash"
if [[ -n "$(command -v fasd)" ]]; then
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
        fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
    fi
    source "$fasd_cache"
    unset fasd_cache
fi

# Sourced files: {{{2

# shellcheck source=/usr/share/bash-completion/bash_completion
test  -f "$_ROOT/share/bash-completion/bash_completion" && source "$_ROOT/share/bash-completion/bash_completion" && echo 'sourced completion'

if [[ -d ~/.bashrc.d ]]; then
    for config in $HOME/.bashrc.d/*.bash; do
        # shellcheck source=/home/faris/.bashrc.d/*.bash
        source $config;
    done
    unset -v config
fi
firstpath() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:${PATH:+"$PATH"}"
    fi
}

firstpath "$HOME/bin"
firstpath "$HOME/.local/bin"

# Dynamic Completions: {{{1

_completion_loader()
{
    . "$_ROOT/share/bash_completion/completions/*" >/dev/null 2>&1 && return 124
}
complete -D -F _completion_loader -o bashdefault -o default

# From /usr/share/doc/bash/README.md.bash-completion
export COMP_CONFIGURE_HINTS=1

# Here's one for the terminal
if [[ -n "$(command -v kitty)" ]]; then
    source <(kitty + complete setup bash)
fi

# add some cool colors to ls
eval "$( dircolors -b $HOME/.dircolors )"

# I'm gonna try and stay conservative here.
export PS1="\\t \\u@\\h \\d \w \n $: "

if [[ -f "$HOME/.bashrc.local" ]]; then
    # shellcheck source=/home/faris/.bashrc.local
    . "$HOME/.bashrc.local"
fi
