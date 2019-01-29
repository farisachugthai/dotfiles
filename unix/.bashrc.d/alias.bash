# Aliases for a more functional bash environment
# Maintainer: Faris Chugthai

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
# -o is similar to -l but don't print group
# -p means append / indicator to directoreis
# ngl the greps still don't make sense to me. dir file, link, executable but how?
alias l='ls -F'
alias la='ls -AF'
alias ldir='ls -po | grep /$'
alias lf='ls -Fo | grep ^-'
alias lk='ls -Fo | grep ^l'
alias ll='ls -AlF'
alias ls='ls -F'
alias lt='ls -Altcr'
alias lx='ls -Fo | grep ^-..x'

# alert alias: {{{1
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# coreutil aliases: {{{1
# Let's not clobber other files as we go. Bash's namespace? Clobber everything
# Please don't turn the p flag for rmdir again.
# You're lucky parent dirs weren't empty
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias rmdir='rmdir -v'
# only prompts with more than 3 files or recursed dirs.
# Less annoying than i but more safe
# alias rm='rm -I'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Options i use every time i run these commands
# probably shouldn't clobber the namespace though, there are conflicting options
# for du so i'll change to du shallow
alias dus='du -d 1 -h --all'
alias dU='du -d 1 -h --apparent-size --all | sort -rh'
alias df='df -ah --total'
alias free='free -mt'
alias echo='echo -e'
alias head='head -n 30'
alias tail='tail -n 30'

# termux aliases: {{{1
# Termux command with odd default of view not send
alias termux-share="termux-share -a send"
# termux-open gets an option for a default file handler! Dropbox integration
alias termux-open="termux-open --send"

# Git aliases. {{{1
# for complicated git log calls funcs are better
alias g='git status -sb'
alias ga='git add'
alias gb='git branch'
alias gba='git branch -a'
alias gci='git commit'
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
alias glo='git log --graph --all'
alias gls='git ls-tree'
alias gm='git merge'
alias gmt='git mergetool'
alias gp='git pull'
alias gpo='git pull origin'
alias gpom='git pull origin master'
alias gpu='git push'
alias gr='git remote'
alias grv='git remote -v'
alias gs='git status'
alias gst='git diff --stat'

# enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
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

alias spacemacs='emacs -F ~/.spacemacs'
