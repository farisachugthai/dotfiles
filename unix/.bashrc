#!/bin/bash
# Bashrc. Assumes that the proper installation scripts have been run.
# Maintainer: Faris Chugthai

### Source in .bashrc.d
for file in ~/.bashrc.d/{alias,functions}; do
    if [ -r "$file" ]; then
        . "$file"
    fi
done;
unset file

if [ -f ~/.bashrc.d/git-completion.bash ]; then
    . ~/.bashrc.d/git-completion.bash
fi

# The following was sourced from this linknwith minor modification
# There are still many more export GIT commands to explore!
if [ -f "$HOME/.bashrc.d/git-prompt.sh" ]; then
    . "$HOME/.bashrc.d/git-prompt.sh";
    export GIT_PS1_SHOWDIRTYSTATE=1
    PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
fi

### History

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000

HISTFILESIZE=20000

#https://unix.stackexchange.com/a/174902
HISTTIMEFORMAT="%F %T: "


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
# I want vim set to be everything

set -o vi

if [ "$DISPLAY" ]; then
    export VISUAL=gvim
else
    export VISUAL=vim
export EDITOR="$VISUAL"
fi

### JavaScript
# Source npm completion if its installed
if [ $(which npm) ]; then
    source ~/.bashrc.d/npm-completion.bash
fi

# Export nvm if the directory exists
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    # Load nvm and bash completion
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

### FZF
# for quick, fuzzy searching in the shell
if [ -f ~/.fzf.bash ]; then
    . ~/.fzf.bash
fi

if [[ $PREFIX ]]; then
    . "$PREFIX/share/fzf/completion.bash"
    . "$PREFIX/share/fzf/key-bindings.bash"
fi

### Python

# Add Conda to the path
if [ -d "$HOME/miniconda3" ]; then
   . "$HOME/miniconda3/etc/profile.d/conda.sh";
   conda activate base
fi

# tldr
export TLDR_COLOR_BLANK="white"
export TLDR_COLOR_NAME="white"
export TLDR_COLOR_DESCRIPTION="white"
export TLDR_COLOR_EXAMPLE="white"
export TLDR_COLOR_COMMAND="white"
export TLDR_COLOR_PARAMETER="white"
export TLDR_CACHE_ENABLED=1
export TLDR_CACHE_MAX_AGE=168

# cheat.py
export CHEATCOLORS=true

# The next line updates PATH for the Google Cloud SDK.
if [ -f ~/bin/google-cloud-sdk/path.bash.inc ]; then 
    source ~/bin/google-cloud-sdk/path.bash.inc; 
fi

# The next line enables shell command completion for gcloud.
if [ -f ~/bin/google-cloud-sdk/completion.bash.inc ]; then 
    source ~/bin/google-cloud-sdk/completion.bash.inc; 
fi
