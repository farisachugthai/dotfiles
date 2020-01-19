;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below here
cat=bat $*
clear=cls
cmderr=cd /d "%CMDER_ROOT%"
e.=explorer .
ga=git add --renormalize .
gci=git commit $*
gco=git checkout $*
gd=git diff $*
gds2=git diff --stat --staged $*
gl=git log --oneline --all --graph --decorate --pretty=format:lo $*
history=cat -n "%CMDER_ROOT%\config\.history"
l=ls -Fh --show-control-chars --append-exe --color $*
ls=ls --show-control-chars --append-exe -F --color $*
pro=nvim C:\tools\Cmder\config\user_profile.cmd
pwd=cd
unalias=alias /d $1
vi=vim $*
