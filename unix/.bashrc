#!/bin/bash
#Bashrc. Assumes that the proper installation scripts have been run.
# Maintained by Faris Chugthai

for file in ~/.bashrc.d/.{alias,functions}; do
    if [ -r "$file" ]; then
        . "$file"
    fi
done

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

###Shopt

#Be notified of asynchronous jobs completing in the background
set -o notify

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

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

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

#still don't want to clobber things
set -o noclobber


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

### Vim

set -o vi

if [ "$DISPLAY" ]; then
    export VISUAL=gvim
else
    export VISUAL=vim
export EDITOR="$VISUAL"
fi

# Paths for a few languages
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# TODO: create a list with anaconda2 anaconda3 miniconda2 and miniconda3.
# iterate over the list and source conda
if [ -f "$HOME/miniconda2/etc/profile.d/conda.sh" ]; then
    . "$HOME/miniconda2/etc/profile.d/conda.sh"
fi

# Let's get bash completion for pip
eval "`pip completion --bash`"

#cheatsheets and tldr's
# for tldr.py
export TLDR_COLOR_BLANK="white" 
export TLDR_COLOR_NAME="white" 
export TLDR_COLOR_DESCRIPTION="white"
export TLDR_COLOR_EXAMPLE="white" 
export TLDR_COLOR_COMMAND="white" 
export TLDR_COLOR_PARAMETER="white" 
export TLDR_CACHE_ENABLED=1
export TLDR_CACHE_MAX_AGE=24

# for cheat.py
export CHEATCOLORS=true
