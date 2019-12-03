#!/bin/bash
# Maintainer: Faris Chugthai

# set -euo pipefail
# Aliases for a more functional bash environment

# cd aliases: {{{1
# Make navigation easier
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cd..='cd ..'

# maybe this is obnoxious. idk.
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias cd.....="cd ../../../.."
alias cd......="cd ../../../../.."

# ls aliases: {{{1

# some more ls aliases. pulled a few from ipython so not all were
# written by me. as a result let me quick go over the flags

# -A all except implied . and ..
# -c sort by ctime.
# -F classifies. indicators for symlinks and dirs are provided
# -o is similar to -l but don't print group. So wait that's the same thing
# as -lg...? Why.
# -p means append / indicator to directoreis
alias l='ls -F --color=always'
alias la='ls -AF --color=always'
alias ldir='ls -po --color=always | grep /$'
alias lf='ls -Fo --color=always | grep ^-'
alias ll='ls -AFhog --color=always'
alias lr='ls -AlgFhr --color=always'
alias ls='ls -F --color=always'
alias lt='ls -Alght --color=always'
alias lx='ls -Fo --color=always | grep ^-..x'

# Alert: {{{1

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Safer coreutils: {{{1

# Let's not clobber other files as we go. Bash's namespace? Clobber everything
# Please don't turn the p flag for rmdir again.
# You're lucky parent dirs weren't empty
alias cp='cp -v'
alias mv='mv -v'
alias mkdir='mkdir -pv'
alias rmdir='rmdir -v'
# Less annoying than i but more safe
# only prompts with more than 3 files or recursed dirs.
alias rm='rm -Iv'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Options i use every time i run these commands
# probably shouldn't clobber the namespace though, there are conflicting options
# for du so i'll change to du shallow
alias dus='du -d 1 -h --all'
alias dU='du -d 1 -h --apparent-size --all | sort -h | tail -n 10'
alias df='df -ah --total'
alias free='free -mt'
alias echo='echo -e'
alias head="head -n 30 $*"
alias tail="tail -n 30 $*"

# Termux alias: {{{1

if [[ -n "$ANDROID_ROOT" ]]; then

    # Termux command with odd default of view not send
    alias termux-share="termux-share -a send"

    # But let's make it easier to use
    alias share="termux-share -a send"

    # termux-open gets an option for a default file handler! Dropbox integration
    alias termux-open="termux-open --send"

    # I still want to type less
    alias opn="termux-open --send"

    # Copy and paste for when I don't feel like firing up tmux
    alias copy="termux-clipboard-get"
    # Paste is a coreutil though
    alias pste="termux-clipboard-set $*"

fi

# Git aliases. {{{1

# for complicated git log calls funcs are better
alias g="git diff --stat --staged $* "
alias ga='git add'
alias ga.='git add .'
alias gar="git add --renormalize -A $* "
alias gb='git branch -a'
alias gbl="git blame $* "
alias gbr="git branch $* "
alias gci='git commit'
alias gcia='git commit --amend'
alias gcid="git commit --date=$* "
alias gciad="git commit --amend --date=$* "
alias gcl='git clone'
alias gcls='git clone --depth 1'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gd='git diff'
alias gds='git diff --staged'
alias gds2='git diff --staged --stat'
alias gdt='git difftool'
alias gf='git fetch --all'
alias gl='git log'
alias glo="git log --graph --decorate --abbrev-commit --branches --all --date=short --oneline $*"
alias gls='git ls-tree'
alias gm='git merge --no-ff'
alias gma="git merge --abort $* "
alias gmc="git merge --continue $* "
alias gmm='git merge master'
alias gmt='git mergetool'
alias gp='git pull --all'
alias gpo='git pull origin'
alias gpom='git pull origin master'
alias gpu='git push'
alias gr='git remote -v'
alias gs='git status'
alias gsh="git stash $*"
alias gsha='git stash apply'
alias gshc='git stash clear'
alias gshd='git stash drop'
alias gshl='git stash list'
alias gshp='git stash pop'
alias gshs='git stash show'
alias gshsp='git stash show -p'
alias gst='git diff --stat'
alias gt='git tag --list'

# Other: {{{1

# enable color support of ls and also add handy aliases
if [[ -x "$PREFIX/dircolors" ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -F --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias redo='fc -s'
alias r='fc -s'

if [[ -n "$(command -v emacs)" ]]; then
    alias spacemacs='emacs -l ~/.spacemacs'
fi

if [[ -n "$(command -v bat)" ]]; then
    alias cat=bat
fi

alias tre="tree -FCa -I .git $*"
