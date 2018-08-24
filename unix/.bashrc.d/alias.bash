# Aliases for a more functional bash environment
# Maintainer: Faris Chugthai

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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lx='ls -AlX'
alias lt='ls -Alt'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#lets not clobber as we go
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias rmdir='rmdir -pv'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

#options i use every time i run these commands
alias du='du -d 1 -h'
alias df='df -aht --total'
alias free='free -mt'
alias echo='echo -e'

# termux command with odd default of view not send
alias termux-share="termux-share -a send"
# termux-open gets an option for a default file handler! Dropbox integration
alias termux-open="termux-open --send"

alias info="info --vi-keys"

# git aliases. for complicated git log calls funcs are better
# TODO: what do we do about name clobbers like status and stat. summary. short.
# ....checkout, config, commit, clone. credentials...
# TODO: my shell and nvim do different things for gc btw
alias ga='git add'
alias gb='git blame'
alias gcl='git clone'
alias gcls='git clone --depth 1'
alias gch='git checkout'
alias gco='git commit'
alias gd='git diff'
alias gds='git diff --staged'
alias gdt='git difftool'
alias glo='git log'
alias gls='git ls-tree'
alias gs='git status'
alias gst='git diff --stat'

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

# alias for easier profiling of nvim. probs wanna change backticks and date format
# alias prof="--startuptime $DOT/.config/nvim/profiling/`date`"
# Usage: nvim prof [filename to edit]
# this needs to be a function nvim thinks its a filename

# someone should let facebook know this is how typical CLI commands work
if [[ "$#" -eq 1 ]]; then
    alias yarn='yarn --help'
else
    continue
fi
# sigh so is this gonna need to evaluate for every command i run?
# you need it to look something like this otherwise yarn does nothing but print
# help pages and why have it installed?
