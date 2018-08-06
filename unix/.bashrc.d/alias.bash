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
alias lx='ls -alX'
alias lt='ls -alt'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#lets not clobber as we go
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias rmdir='rmdir -pv'
alias rm='rm -i'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

#options i use every time i run these commands
alias du='du -d 1 -h'
alias df='df -aht --total'
alias free='free -mt'

#termux command with odd default of view not send
alias termux-share="termux-share -a send"

alias info="info --vi-keys"

#git aliases. for complicated git log calls funcs are better
alias ga='git add'
alias gc='git clone'
alias gcs='git clone --depth 1'
alias gco='git commit'
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'

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
