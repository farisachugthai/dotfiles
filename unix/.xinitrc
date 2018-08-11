#!/usr/bin/env bash
# xinit

failsafe="xterm -ls -T failsafe -geometry 80x24-0-0"

trap "exec $failsafe" EXIT SIGHUP SIGINT SIGPIPE SIGTERM SIGIO

[[ -f ~/.Xdefaults ]] && xrdb ~/.Xdefaults
[[ -f ~/.Xresources ]] && xrdb ~/.Xresources
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

pgrep ssh-agent || eval $(ssh-agent -s) && ssh-add

exec awesome
