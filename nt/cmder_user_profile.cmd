:: User Profile
:: Dec 05, 2019: Randomly decided to go ham on cmd since powershell,
:: I've recently realized, is the root of most of my windows problems.
:: cmd running /K init.bat and this startup script works beautifully
:: Vim: set ff=dos:
:: use this file to run your own startup commands
:: use in front of the command to prevent printing the command
:: Because i need to debug
@echo on

:: How do you correctly write this command?
:: enabledelayedexpansion
@SETLOCAL EnableDelayedExpansion


:: Add *nix tools to end of path. 0 turns off *nix tools.
:: So they're right 1 adsd it to the end, 0 turns it off. So if we set it to 2 can it prepend?
set nix_tools=2

:: uncomment this to have the ssh agent load when cmder starts
:: don't uncomment you'll get a password prompt
:: call "%GIT_INSTALL_ROOT%/cmd/start-ssh-agent.cmd" /k exit

:: The quotes are getting in PATH and fucking shit up
:: SET "GIT_INSTALL_ROOT=C:\git"
SET time_init=1
set CMDER_USER_FLAGS="/time_init"

:: Don't do it like this. The var below is expanded from where you execute.
:: So if you're in $HOME, it'll set CMDER_USER_CONFIG to home :/
:: SET CMDER_USER_CONFIG="%~dp0"
::
:: uncomment the next two lines to use pageant as the ssh authentication agent
:: The script explicitly requires that this var is set
SET SSH_AUTH_SOCK="%TMP%\ssh-pageant-auth-sock"

:: Wait i don't remember why i do one and not the other
call "%GIT_INSTALL_ROOT%\cmd\start-ssh-pageant.cmd"

:: Don't really need any but
dircolors -c ~/.dircolors

:: you can add your plugins to the cmder path like so
:: set "PATH=%CMDER_ROOT%\vendor\whatever;%PATH%"

:: arguments in this batch are passed from init.bat, you can quickly parse them like so:
:: more useage can be seen by typing "cexec /?"

:: %ccall% "/customOption" "command/program"

:: Aug 02, 2019: Here's a cool prompt I made today
::
prompt $M$P$S$V$_$D$S$G$S$$$S

@echo off
