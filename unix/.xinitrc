#!/usr/bin/env bash
# xinit

setxkbmap -option 'ctrl:nocaps'

failsafe="xterm -ls -T failsafe -geometry 80x24-0-0"

trap 'exec $failsafe' EXIT SIGHUP SIGINT SIGPIPE SIGTERM SIGIO

[[ -f ~/.Xdefaults ]] && xrdb -merge ~/.Xdefaults
[[ -f ~/.Xresources ]] && xrdb -I$HOME ~/.Xresources
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

pgrep ssh-agent || eval "$(ssh-agent -s)" && ssh-add

# invoke global X session script
. /etc/X11/Xsession

exec i3&
