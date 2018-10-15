#!/usr/bin/env bash
# xinit

failsafe="aterm -ls -T failsafe -geometry 80x24-0-0"

trap "exec $failsafe" EXIT SIGHUP SIGINT SIGPIPE SIGTERM SIGIO

[[ -f ~/.Xdefaults ]] && xrdb ~/.Xdefaults
[[ -f ~/.Xresources ]] && xrdb ~/.Xresources

if [[ -f ~/.Xmodmap ]]; then
    if [[ "$(command -v xmodmap)" ]]; then
        xmodmap ~/.Xmodmap
    fi
fi

pgrep ssh-agent || eval $(ssh-agent -s) && ssh-add

# invoke global X session script
if [[ -f /etc/X11/Xsession ]]; then
    . /etc/X11/Xsession
fi

exec i3-with-shmlog&
