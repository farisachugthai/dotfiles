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

# Feb 07, 2019
# So startkde failed on me for some reason and it didn't look like the GUI had
# initialized except for the fact that my plasma keybindings still worked
# so i was able to get kitty up. ran `startkde` to errors. ran plasmashell
# as my second try and everything started loading in less than 120 reported
# seconds. Point being. Use that as a failsafe as well.
exec sddm-greeter& || plasmashell
