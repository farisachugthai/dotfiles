#!/bin/bash
# xinit

setxkbmap -option 'ctrl:nocaps'

failsafe="xterm -ls -T failsafe -geometry 80x24-0-0"

trap 'exec $failsafe' EXIT SIGHUP SIGINT SIGPIPE SIGTERM SIGIO

[[ -f ~/.Xdefaults ]] && xrdb -merge ~/.Xdefaults
[[ -f ~/.Xresources ]] && xrdb -I "$HOME" ~/.Xresources
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

pgrep ssh-agent || eval "$(ssh-agent -s)" && ssh-add

# invoke global X session script
[[ -f /etc/X11/Xsession ]] && . /etc/X11/Xsession

# sddm is the display manager for plasma/kde5. So we can use this and still
# try out i3 or awesome if we're in the mood
exec sddm-greeter&
