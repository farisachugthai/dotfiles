#!/bin/bash
# Bashrc. Assumes that the proper installation scripts have been run.
# Maintainer: Faris Chugthai

# Don't run if not interactive
case $- in
    *i*);;
    *) return 0;;
esac

# Source in .bashrc.d
for config in ~/.bashrc.d/*.bash; do
    source "$config"
done
unset -v config

# For the secrets
if [[ -f "$HOME/.bashrc.local" ]]; then
    . "$HOME/.bashrc.local"
fi

# This shows the git state. This also prevents us from seeing what venv or conda env we're in.
# This occurs because PS1 gets locked and won't display. On Termux that's challenging.
if [[ -z "$DISPLAY" ]]; then
    if [[ -f "$HOME/.bashrc.d/git-prompt.sh" ]]; then
        . "$HOME/.bashrc.d/git-prompt.sh";
        export GIT_PS1_SHOWDIRTYSTATE=1
        PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
    fi
fi

if [ -z "$PS1" ]; then export 'PS1'='\u@\h:\w$ '; fi

# History
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
# TODO: What are the units on either of these?
HISTFILESIZE=50000
#https://unix.stackexchange.com/a/174902
HISTTIMEFORMAT="%F %T: "
# Ignore all the damn cds, ls's its a waste to have pollute the history
HISTIGNORE='exit:ls:cd:history:ll:la:gs'

# Shopt
# Be notified of asynchronous jobs completing in the background
set -o notify
# Append to the history file, don't overwrite it
shopt -s histappend
# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
if [[ $BASH_VERSINFO -gt 3 ]]; then
    shopt -s globstar
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
set -o noclobber        # Still dont want to clobber things
shopt -s xpg_echo       # Allows echo to read backslashes like \n and \t
shopt -s dirspell       # Autocorrect the spelling if it can
shopt -s cdspell

# Defaults in Ubuntu bashrcs
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# Vim
set -o vi
export VISUAL="nvim"
export EDITOR="$VISUAL"

# JavaScript
# Source npm completion if its installed
if [[ $(which npm) ]]; then
    source ~/.bashrc.d/npm-completion.bash
fi

# Export nvm if the directory exists
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    # Load nvm and bash completion
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
fi

# FZF
# Remember to keep this below set -o vi or else FZF won't inherit vim keybindings!
if [[ -f ~/.fzf.bash ]]; then
    . "$HOME/.fzf.bash"
fi
export FZF_DEFAULT_OPTS='--preview="cat {}" --preview-window=right:50%:wrap --cycle'

# Python
if [[ -d "$HOME/miniconda3/bin/" ]]; then
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/faris/miniconda3/bin/conda' shell.bash hook 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/faris/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/home/faris/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/faris/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
fi


# The next line updates PATH for the Google Cloud SDK.
if [ -f ~/bin/google-cloud-sdk/path.bash.inc ]; then 
    source ~/bin/google-cloud-sdk/path.bash.inc; 
fi

# The next line enables shell command completion for gcloud.
if [[ -f ~/bin/google-cloud-sdk/completion.bash.inc ]]; then 
    source ~/bin/google-cloud-sdk/completion.bash.inc; 
fi


# The next line updates PATH for the Google Cloud SDK.
if [[ -f "$PREFIX/google-cloud-sdk/path.bash.inc" ]]; then source "$PREFIX/google-cloud-sdk/path.bash.inc"; fi

if [ -f "$PREFIX/google-cloud-sdk/completion.bash.inc" ]; then 
    source "$PREFIX/google-cloud-sdk/completion.bash.inc"; 
fi
