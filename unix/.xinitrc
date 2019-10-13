#!/bin/sh
# xinit

setxkbmap -option 'ctrl:nocaps'

failsafe="xterm -ls -T failsafe -geometry 80x24-0-0"

trap 'exec $failsafe' EXIT SIGHUP SIGINT SIGPIPE SIGTERM SIGIO

# DON'T USE FUCKING [[]] SYNTAX IT's A SH SHELL
[ -f ~/.Xdefaults ] && xrdb -merge ~/.Xdefaults
[ -f ~/.Xresources ] && xrdb -I "$HOME" ~/.Xresources
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# obviously this causes an error on startup
#pgrep ssh-agent || eval "$(ssh-agent -s)" && ssh-add

# invoke global X session script
[ -f /etc/X11/Xsession ] && . /etc/X11/Xsession

# sddm is the display manager for plasma/kde5. So we can use this and still
# try out i3 or awesome if we're in the mood

# Feb 07, 2019
# So startkde failed on me for some reason and it didn't look like the GUI had
# initialized except for the fact that my plasma keybindings still worked
# so i was able to get kitty up. ran `startkde` to errors. ran plasmashell
# as my second try and everything started loading in less than 120 reported
# seconds. Point being. Use that as a failsafe as well.
# exec sddm-greeter& || plasmashell

# From man xinit. I just need something functional
xsetroot -solid gray &
xclock -g 50x50-0+0 -bw 0 &
xload -g 50x50-50+0 -bw 0 &
xterm -g 80x24+0+0 &
xterm -g 80x24+0-0 &

# Let's default to something reasonable I guess
# kwin
# nvm. This probably exists for a reason
# [ -f /etc/X11/default-display-manager ] && sddm
# Whoa fuck all that noise. Dude the file at /etc/X11/Xsession looks real solid
. /etc/X11/Xsession

plasmashell
