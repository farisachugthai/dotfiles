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

- Customized Completions

- [Modifications](unix/.profile) [for](unix/.bashrc) [bash](unix/.bash_logout)
  [are](unix/.bashrc.d/alias.bash) [abundant](unix/.bashrc.d/functions.bash).

- [Tmux settings](./unix/.tmux.conf) and [tmux scripts](./unix/.tmux) as well.

## Completions

The way that auto-completions are set up can fundamentally change the user
experience when working with a shell. This is especially true for when the
user is unfamiliar with the ins and outs of the shell.

However, the way that bash handles auto-completion can be largely 
inconsistent. It seems that this is largely a product of how differing 
flavors of Unix set up their shells by default, in addition to a large 
amounts of configurability and customization that users are afforded but 
potentially may not be aware of.

It's unfortunate bash doesn't have a simpler "drop down menu interface" for 
it's users. However, I'm hoping that all of my digging through man
pages will save you from the same fate.

Following are my notes on this to attempt setting things up consistently.

### General set up

```bash

u0_a144 @ localhost ~ 11:59 0
*@In [11] $ complete -p | sort | uniq | wc -l
475

u0_a144 @ localhost ~ 11:59 0
*@In [11] $ complete -p | sort | uniq | rg --max-count=999999 '.*fzf*' | wc -l
145

```

The above shows how many commands have tab completion set up, which as of May 09, 2020, is 475 commands.

Being able to mindlessly jam the <kbd>Tab</kbd> key is outstandingly
helpful to working in a shell frequently.

In addition, 145 of those commands utilize FZF's shell completion, as it noticeably speeds up completion generation.


### WSL

On the Arch flavor of WSL, /etc/profile and /etc/profile.d exist but don't do
anything to setup completions.

The /etc/bash.bashrc does the fairly standard idiom.:

`[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion`

Otherwise little is set up.

I just created a directory /etc/bash_completion.d as one was needed by `activate-global-python-argcomplete`.

### /usr/share/bash-completion/bash_completion

It appears that the following dirs are sourced by the frequently present file at
/usr/share/bash-completion/bash_completion.

The following is defined in a function `__load_completion()`, IE check that
it's defined in the shell before placing files here!

    local -a dirs=( ${BASH_COMPLETION_USER_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion}/completions )

This is defined globally.:

    # source compat completion directory definitions
    compat_dir=${BASH_COMPLETION_COMPAT_DIR:-/etc/bash_completion.d}

As is this.:

    # source user completion file
    user_completion=${BASH_COMPLETION_USER_FILE:-~/.bash_completion}

On Termux,


### Readline

**TODO**

[.inputrc](./unix/.inputrc)


### `complete` and `compgen`


## Handling Git on Windows

Git may try to treat files with extensions it doesn't recognize as binary.
As Windows occasionally encodes things with `CP-437`, `UTF-16`, `ASCII` or
`locale=C` depending on what mood it's in, this can be difficult to fix
by means of decoding.

A simple fix is to set the following in the
[.gitattributes](./unix/.config/git/aattributes) file.

`*.ps1 text eol=input diff`

`eol=input` is only set because powershell needs `DOS` style lines, but I don't
want the entire repository filled with differing line endings on Unix computers.

`text` is to ensure it's not recognized as binary but if it already was, `diff`
will reset it back to text.

## Bash Configuration

The `$PAGER` is highly customized. From my bashrc.

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

### Useful ANSI escape sequences

```bash

# CUSTOM BASH COLOR PROMPT
# 30m - Black
# 31m - Red
# 32m - Green
# 33m - Yellow
# 34m - Blue
# 35m - Purple
# 36m - Cyan
# 37m - White
# 0 - Normal
# 1 - Bold
export BLACK="\[\033[0;30m\]"
export BLACKBOLD="\[\033[1;30m\]"
export RED="\[\033[0;31m\]"
export REDBOLD="\[\033[1;31m\]"
export GREEN="\[\033[0;32m\]"
export GREENBOLD="\[\033[1;32m\]"
export YELLOW="\[\033[0;33m\]"
export YELLOWBOLD="\[\033[1;33m\]"
export BLUE="\[\033[0;34m\]"
export BLUEBOLD="\[\033[1;34m\]"
export PURPLE="\[\033[0;35m\]"
export PURPLEBOLD="\[\033[1;35m\]"
export CYAN="\[\033[0;36m\]"
export CYANBOLD="\[\033[1;36m\]"
export WHITE="\[\033[0;37m\]"
export WHITEBOLD="\[\033[1;37m\]"

export RESET="\033[0m"
export PS2="\001\033[32m\002  ...:\001$RESET\002 "
export LIGHT_RED="\[\e[91m\]"
export ORANGE="\[\e[38;5;208m\]"
# Different shade
export yellow="\[\e[38;5;214m\]"
export GREEN="\[\e[38;5;71m\]"
export UGREEN="\[\e[38;5;71;1;4m\]"
export SALMON="\[\e[38;5;167m\]"
export BROWN="\[\e[38;5;166m\]"

```

### Porting to Windows

Has been nothing short of a massive pain in the ass.

Hopefully these tips will help someone else one day.

1. Break down every part of your previous setup from the ground up.
   I've had powershell and conda inconsistently set the python environment.
   I didn't imagine at any point that the shell itself was at fault, and
   wasted a ton of time as a result. Then move forward.

2. View your setup as it's individual components. This will be akin to unit
   testing, and when you're in the middle of doing something will,
   _unfortunately_, be the integration test.

   - However doing this correctly can save you a lot of headache. Take
     concatenating a file as a simple example. To page a file, requires cmd
     to read it, pass it to less. If the pager was invoked automatically by
     git, ensure that env var is consistent with the rest of your setup.
     Not setting the `$TERM` envvar may cause issues here.

     - Sticking with the pager example. `Git` called `bat`, a new version of `cat`
       rewritten in rust. This called `less` to open the file. If `cmder`,
       `powershell`, or `cmd` hadn't decoded/encoded the file incorrectly,
       the colorscheme of the file would render the file practically illegible.
       If this occurred while using `ipython` to run system commands, I would,
       on occasion, have 5 different levels of the command to debug.

3. A user can set parameters in the GUI using Control Panel as well as in the
   registry. Registry problems are functionally impossible to debug, _at least
   so far I've found_, and as a result, it will frequently be more easy to
   recover from mistakes in classic ini-style config files.

4. Use `*nix` line endings. Trust me.

5. Use WSL when there aren't other options; however, make every attempt you can
   to use native tools as possible.

   - When in Rome!


### Cmder

Something in these configuration files has to be set wrong.
Interactively defining an alias on the cmdline destroys the alias file.
It looks like an encoding problem which is definitely possible
as nvim is set to automatically assume utf-8, as is the windows terminal and cmder.

`chcp` is included as one of the first commands of my
[user_profile.cmd](./nt/cmder/user_profile.cmd).

However, if the alias command provided by ConEmu isn't aware of that, then
any input from the terminal to the file will corrupt it.

So be careful and simply define them non-interactively!

## Contributing

While most people consider dotfiles very personal, I've posted as many as I
found reasonable with the intention of encouraging some discussion on how
to solve common problems more seamlessly.

## License

MIT
