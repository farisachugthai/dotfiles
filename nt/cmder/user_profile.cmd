:: Holy cow did I need one of these
:: Just read in the old cmder profile
:: Initialized with 
:: reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun ^ /t REG_EXPAND_SZ /d "%"USERPROFILE"%\init.cmd" /f
:: Then create a file init.cmd in your profile folder


:: User Profile: {{{
:: Dec 05, 2019: Randomly decided to go ham on cmd since powershell,
:: I've recently realized, is the root of most of my windows problems.
:: cmd running /K init.bat and this startup script works beautifully
:: use this file to run your own startup commands
:: use in front of the command to prevent printing the command
@echo off

:: So this should stay at the top
chcp 65001 1>nul

:: Vim starts up so much faster that you can never change this
set LC_ALL=C

:: It literally makes me see red when apps change this
set "HOME=C:\Users\fac"

:: doskey /MACROFILE=C:\\Users\\fac\\projects\\dotfiles\\nt\\cmder\\user_aliases.cmd 
:: Now we can begin the convenience scripts.
doskey /MACROFILE=C:\Users\fac\projects\dotfiles\nt\Cmder\user_aliases.cmd
:: uncomment the next two lines to use pageant as the ssh authentication agent
:: The script explicitly requires that this var is set

SET SSH_AUTH_SOCK="%TMP%\.ssh-pageant-auth-sock"

:: It doesn't kill the process
::ssh-pageant 1>nul

:: uncomment this to have the ssh agent load when cmder starts
:: don't uncomment you'll get a password prompt
:: call "%GIT_INSTALL_ROOT%/cmd/start-ssh-agent.cmd" /k exit

:: The quotes are getting in PATH and fucking shit up
:: SET "GIT_INSTALL_ROOT=C:\git"

:: Dec 13, 2019: Found the culprint. Need to learn more details about this.
:: It just prevented the rest of the env vars from being set
:: @SETLOCAL EnableDelayedExpansion

SET RIPGREP_CONFIG_PATH=C:\Users\fac\.ripgreprc
SET IPYTHONDIR=C:\Users\fac\.ipython
:: }}}

:: PAGER: {{{
:: This is nice and all but it doesn't behave consistently IMO
:: --mouse
:: Enable mouse input.
:: --save-marks
:: Retain marks across invocations of less.
:: --wheel-lines=N
:: Each click of the mouse wheel moves N lines.
SET "PAGER=less -JRKMrLigeFW"
:: This has priority over pager so let's set the oddball options here
:: Some versions of less tare to old to support the long form options
SET "LESS=JRKMrLigeFW"
:: apparently you're really not allowed to inline comments. Wtf?
SET "LESSEDIT=nvim -q '%F %lm'"
SET "LESSCOLORIZER=pygmentize"
SET "LESSHISTSIZE=5000"
SET "BROWSER=C:\Program Files\Firefox Nightly\firefox.exe"
:: }}}

:: Python: {{{
::
:: https://docs.python.org/3/using/cmdline.html
SET "PYTHONASYNCIODEBUG=1"
SET "PYTHONCASEOK=1"
SET "PYTHONDOCS=C:\Users\fac\Dropbox\python\official-python-docs\3.7"
SET "PYTHONDONTWRITEBYTECODE=1"
SET "PYTHONIOENCODING=utf-8:strict"
SET "PYTHONMALLOC=debug"
SET "PYTHONUNBUFFERED=1"
SET "PYTHONUTF8=1"
:: Holy actual fuck does this get annoying
:: SET "PYTHONPROFILEIMPORTTIME=1"

:: I learned some DOS today! Assumes CMDEXTENSIONS enabled
:: Only active conda if we're not in a pipenv shell. todo: venv and stuff.
:: Actually don't do this. this is evaluated on not just startup but every single subshell
:: if DEFINED PIPENV_ACTIVE (
:: :: what the hell is the dos equivalent of pass or continue?
::   echo
:: ) else (
::   C:\Users\fac\scoop\shims\conda activate
:: )

:: }}}

:: FZF: {{{
:: The FZF docs state this has to be unset but a LOT of things stop working then
:: HOLY FUCKING SHIT FZF WORKS BETTER THAN EVER AHHHH
SET "TERM=cygwin"
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

 SET "FZF_CTRL_T_OPTS= --multi --cycle --reverse --prompt 'Query: ' --tiebreak begin,length,index --ansi --filepath-word --border  --header 'FZF: File Browser: Press ? to toggle preview.'"

:: --preview 'bat {}' --preview-window=right:60%:wrap --bind '?:toggle-preview' "

SET "FZF_CTRL_R_COMMAND=rg  --smart-case  --no-messages "

 SET "FZF_CTRL_R_OPTS= --cycle --reverse --prompt 'Query: ' --tiebreak begin,length,index --history-size=10000 --ansi --bind '?:toggle-preview' --header 'Press ? to toggle preview' "

 :: --preview 'bat {}' --preview-window=down:hidden:wrap

SET "FZF_ALT_C_COMMAND=fd --type d --hidden --color always "

SET "FZF_ALT_C_OPTS=--cycle --ansi --tiebreak begin,length,index --no-multi --filepath-word --bind '?:toggle-preview' --header 'Press ? to toggle preview' --border --prompt 'FZF Dir Finder' --preview 'ls -lRhF --color=always {}' --preview-window=up:40:wrap | head -n 200 "
:: }}}

:: Build: {{{
set "CFLAGS=-Wno-unused-value -Wno-empty-body -Qunused-arguments -no-integrated-as"
set "CC=clang"
set "CXX=clang++"
set "CMAKE_SH=CMAKE_SH-NOTFOUND"

:: Don't do it like this. The var below is expanded from where you execute.
:: So if you're in $HOME, it'll set CMDER_USER_CONFIG to home :/
:: SET CMDER_USER_CONFIG="%~dp0"

dircolors -c C:\Users\fac\.dircolors 1>nul

:: Aug 02, 2019: Here's a cool prompt I made today
prompt $M$P$S$V$_$D$S$G$S$$$S

:: XDG
SET XDG_DATA_HOME=C:\Users\fac\.local\share
SET XDG_CONFIG_HOME=C:\Users\fac\.config
SET LANG=en_US.UTF-8
SET LANGUAGE=en_US.UTF-8
SET LC_ALL=C

:: Might wanna setx this one
SET REGIONCODE=65001

:: @echo off
:: Vim: set ff=dos:
