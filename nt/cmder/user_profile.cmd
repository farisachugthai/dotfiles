:: User Profile
:: Dec 05, 2019: Randomly decided to go ham on cmd since powershell,
:: I've recently realized, is the root of most of my windows problems.
:: cmd running /K init.bat and this startup script works beautifully
:: use this file to run your own startup commands
:: use in front of the command to prevent printing the command
:: @echo on

echo "Entering user_config."

:: uncomment the next two lines to use pageant as the ssh authentication agent
:: The script explicitly requires that this var is set
SET SSH_AUTH_SOCK="%TMP%\.ssh-pageant-auth-sock"

:: uncomment this to have the ssh agent load when cmder starts
:: don't uncomment you'll get a password prompt
:: call "%GIT_INSTALL_ROOT%/cmd/start-ssh-agent.cmd" /k exit

:: The quotes are getting in PATH and fucking shit up
:: SET "GIT_INSTALL_ROOT=C:\git"

:: Obviously have to stay at the top
SET time_init=1
SET debug_output=1
SET CMDER_USER_FLAGS="/time_init"

:: How do you correctly write this command?
:: enabledelayedexpansion
:: Dec 13, 2019: Found the culprint. Need to learn more details about this.
:: It just prevented the rest of the env vars from being set
:: @SETLOCAL EnableDelayedExpansion

:: So this should stay at the top
chcp 65001
SET "LC_ALL=en_US.UTF-8"

:: Let's make sure that the rest of this runs by using an env at the end

:: Add *nix tools to end of path. 0 turns off *nix tools.
:: So they're right 1 adsd it to the end, 0 turns it off. So if we set it to 2 can it prepend?

::SET nix_tools=2
SET RIPGREP_CONFIG_PATH=C:\Users\faris\.ripgreprc
SET IPYTHONDIR=C:\Users\faris\.ipython

:: PAGER:
:: set PAGER=less
:: set BAT_PAGER=less

:: This is nice and all but it doesn't behave consistently IMO
:: --mouse
:: Enable mouse input.
:: --save-marks
:: Retain marks across invocations of less.
:: --wheel-lines=N
:: Each click of the mouse wheel moves N lines.
:: SET "PAGER=less -JRKMLiegF"
:: --mouse --save-marks --wheel-lines=5 "
:: Idk if this work so comment out after the space
:: SET "LESS=JRKMLiegF"
:: apparently you're really not allowed to inline comments. Wtf?
:: SET "LESSEDIT=nvim -q '%F %lm'"

SET "BROWSER=C:\Program Files\Firefox Nightly\firefox.exe"

:: https://docs.python.org/3/using/cmdline.html
SET "PYTHONIOENCODING=utf-8:strict"
SET "PYTHONDONTWRITEBYTECODE=1"
SET "PYTHONUNBUFFERED=1"
SET "PYTHONDOCS=C:\Users\faris\Dropbox\python\official-python-docs\3.7"
SET "PYTHONASYNCIODEBUG=1"
SET "PYTHONCASEOK=1"
:: Holy actual fuck does this get annoying
:: SET "PYTHONPROFILEIMPORTTIME=1"
SET "PYTHONMALLOC=debug"

:: The FZF docs state this has to be unset but a LOT of things stop working then
:: HOLY FUCKING SHIT FZF WORKS BETTER THAN EVER AHHHH
SET "TERM=cygwin"
SET "CONEMU_ANSI=ON"

SET "LESSHISTSIZE=5000"

:: Let's see if giving this shit 2 parameters make its work
:: nope
:: dude fzf is NOT having it
:: oh sweet cmder simply isn't executing these statements. wth?
SET "FZF_DEFAULT_COMMAND=fd -H -t f "

:: This just worked interactively on the cmdline
:: whew. don't set window down it might start redrawing results over your window
SET "FZF_DEFAULT_OPTS=--ansi --border --multi --cycle --filepath-word --reverse --tiebreak begin,length,index --bind alt-n:execute:'nvim {}' --header 'FZF: File Browser. Press Alt-n to launch nvim. ' --prompt 'FZF: > ' "

:: --preview 'bat --theme OneHalfDark --color always {}' --preview-window=right:50%:wrap
:: SET FZF_DEFAULT_COMMAND="rg --hidden  --smart-case --passthru ^ "
:: SET FZF_DEFAULT_OPTS=" --multi --cycle --reverse --prompt 'Query: ' --tiebreak begin,length,index --ansi --filepath-word --border --header 'FZF: File Browser' "
::
SET "FZF_CTRL_T_COMMAND=rg --hidden  --follow --no-messages --no-heading --smart-case --files --passthru --max-depth 10 --max-count 20 --max-columns 200 -C 0 "

 SET "FZF_CTRL_T_OPTS= --multi --cycle --reverse --prompt 'Query: ' --tiebreak begin,length,index --ansi --filepath-word --border  --header 'FZF: File Browser: Press ? to toggle preview.' --preview 'bat {}' --preview-window=right:60%:wrap --bind '?:toggle-preview' "

SET "FZF_CTRL_R_COMMAND=rg  --smart-case  --no-messages "

 SET "FZF_CTRL_R_OPTS= --cycle --reverse --prompt 'Query: ' --tiebreak begin,length,index --history-size=10000 --ansi --preview 'bat {}' --preview-window=down:hidden:wrap --bind '?:toggle-preview' --header 'Press ? to toggle preview' "

SET "FZF_ALT_C_COMMAND=fd --type d --hidden --color always "

SET "FZF_ALT_C_OPTS=--cycle --ansi --tiebreak begin,length,index --no-multi --filepath-word --bind '?:toggle-preview' --header 'Press ? to toggle preview' --border --prompt 'FZF Dir Finder' --preview 'ls -lRhF --color=always {}' --preview-window=up:40:wrap | head -n 200 "

:: Don't do it like this. The var below is expanded from where you execute.
:: So if you're in $HOME, it'll set CMDER_USER_CONFIG to home :/
:: SET CMDER_USER_CONFIG="%~dp0"

:: you can add your plugins to the cmder path like so
:: set "PATH=%CMDER_ROOT%\vendor\whatever;%PATH%"

set "PATH=%PATH%;C:\tools\vs\2019\Community\Common7\IDE\Extensions\Microsoft\Python\Miniconda\Miniconda3-x64\Scripts"
:: arguments in this batch are passed from init.bat, you can quickly parse them like so:
:: more useage can be seen by typing "cexec /?"

:: Add the path to the Windows terminal
set "PATH=%PATH%;C:\Users\faris\AppData\Local\Microsoft\WindowsApps\Microsoft.WindowsTerminal_8wekyb3d8bbwe"

:: TODO: add it the normal way
set "PATH=%PATH%;C:\tools\nvm\v12.14.1"

dircolors -c ~/.dircolors 1>nul

:: %ccall% "/customOption" "command/program"

:: Aug 02, 2019: Here's a cool prompt I made today
prompt $M$P$S$V$_$D$S$G$S$$$S

:: @echo off
:: Vim: set ff=dos:
