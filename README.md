# Dotfiles

A repository that hosts the dotfiles for my Ubuntu workstations and a Termux
development environment.

## Overview

Code for a Windows 10 laptop is slowly working it's way in, though the
transition to a typical Windows workflow has been different than Linux.

Most of the code here is helper code that aides my productivity while I'm
working on various personal projects.

Enjoy reading through the code, feel free to take anything that interests you,
and leave a comment or open an issue if you notice anything that you'd
personally improve!

## Features

Currently this houses code for dozens of applications with a focus on python
programming and conventional Unix terminal workflows.

Configurations exist for:

* Emacs {in multiple locations}
 
* [ansible](unix/.ansible.cfg)

* A 1000+ line [dircolors](unix/.dircolors)

* [Modifications](unix/.profile) [for](unix/.bashrc) [bash](unix/.bash_logout)
  [are](unix/.bashrc.d/alias.bash) [abundant](unix/.bashrc.d/functions.bash).

In addition, global configurations for [git](./unix/.config/git)
and [Anaconda](./unix/.condarc) exist.

A configuration for [Tmux](./unix/.tmux.conf) exists as well.

These configurations exist primarily for Linux only platforms as there
are extensively commented files for [Xmodmap](./unix/.Xmodmap),
[.xbindkeys](./unix/.xbindkeys), [.Xresources](./unix/.Xresources),
[.xsession](./unix/.xsession); however, to the maximum extent possible, the code
has been made portable to Windows.

In situations where this proved excessively difficult, separate files have been
included in [nt](nt).

## Bash Configuration

The $PAGER is highly customized. From my bashrc.

```bash

# -J: displays a status column at the left edge of the screen
# -R: is what we need for ansi colors
# -K: exit less in response to Ctrl-C
# -M: Verbose prompt
# -L: Line numbers. Open a man page and hit 'G' to see what you're getting into
# -i: Ignore case. Works similarly to how modern programs handle smart case!
# --mouse: Take a guess
# -g: only one  search match highlighted
# -e EOF reached twice? Close automatically.
# -S set wrap or "squeeze" long lines
# -F: Quit automatically if one screen

export PAGER="less -JRKMLigeF"
export LESSHISTSIZE=5000  # default is 100

# Oh shit! --mouse is a bash>5 feature!
if [[ $BASH_VERSINFO -gt 4 ]]; then export PAGER="$PAGER --mouse --no-histdups --save-marks "; fi

# Thank byobu for these ones. Man pages now look pretty awesome
export GREP_COLORS="ms=01;38;5;202:mc=01;31:sl=:cx=:fn=01;38;5;132:ln=32:bn=32:se=00;38;5;242"
export LESS_TERMCAP_mb=$(printf '\e[01;31m')       # enter blinking mode – red
export LESS_TERMCAP_md=$(printf '\e[01;38;5;180m') # enter double-bright mode – bold light orange
export LESS_TERMCAP_me=$(printf '\e[0m')           # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m')           # leave standout mode
export LESS_TERMCAP_so=$(printf '\e[03;38;5;202m') # enter standout mode – orange background highlight (or italics)
export LESS_TERMCAP_ue=$(printf '\e[0m')           # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;38;5;139m') # enter underline mode – underline aubergine

if [[ -n "$(command -v bat)" ]]; then
    export BAT_PAGER="less -JRKMLige"
    export BAT_THEME="base16"
    export BAT_STYLE="full"
  # TODO: This doesn't work for me
  # export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT="-c"
  if [[ -d "$HOME/faris/AppData/Roaming" ]]; then
    export BATCONFIGFILE="$HOME/faris/AppData/Roaming/bat/config"
  fi
fi

```

This is just a simple example of how extensive some frequently used options
have gotten.


## Contributing

While most people consider dotfiles very personal, I've posted as many as I
found reasonable with the intention of encouraging some discussion on how
to solve common problems more seemlessly.


## License

MIT
