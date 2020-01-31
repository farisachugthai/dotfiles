;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below here
alias=nvim C:\tools\Cmder\config\user_profile.cmd
clear=cls
clink="C:\tools\Cmder\vendor\clink/clink_x64.exe" --cfgdir "C:\tools\Cmder\config" $*
cmderr=cd /d "%CMDER_ROOT%"
conda="C:\tools\vs\2019\Community\Common7\IDE\Extensions\Microsoft\Python\Miniconda\Miniconda3-x64\condabin\conda.bat" $*
condad=cd "C:\tools\vs\2019\Community\Common7\IDE\Extensions\Microsoft\Python\Miniconda\Miniconda3-x64" $*
df=df -ah --total $*
dir=dir /ON $*
ddir=dir /Q /ON $*
dus=du -d 1 -h -all $*
ex=explorer .
free=free -mt $*

git_alias="git config --get-regexp alias.*"
g=git diff --stat --staged $*
ga=git add --renormalize . $*
gar=git add --renormalize . $*
gb=git branch --all --verbose $*
gbl=git blame $*
gbr=git branch $*
gbrd=git branch -d $*
gbrD=git branch -d $*
gbru=git branch --verbose --set-upstream-to origin $1
gci=git commit $*
gcia=git commit --amend $*
gciad=git commit --amend --date=$*
gcid=git commit --date=$*
gcl=git clone --progress $*
gcls=git clone --progress --depth 1 $*
gco=git checkout $*
gcob=git checkout -b $*
gd=git diff $*
gds=git diff --staged $*
gds2=git diff --stat --staged $*
gdt=git difftool $*
gf=git fetch --all $*
gl=git log --graph --decorate --all --abbrev --abbrev-commit --pretty=lo $*
glo=git log $*
gls=git ls-tree
gm=git merge --no-ff $*
gma=git merge --abort $*
gmc=git merge --continue $*
gmm=git merge master $*
gmt=git mergetool $*
gp=git pull $*
gpo=git pull origin
gpom=git pull origin master
gpu=git push $*
gr=git remote -arv $*
grb=git rebase $*
grba=git rebase --abort $*
grbc=git rebase --continue $*
grbi=git rebase --interactive $*
gre=git remote $*
gs=git status $*
gsh=git stash $*
gshd=git stash -d $*
gshl=git stash -l $*
gshp=git stash pop $*
gshs=git stash show $*
gshsp=git stash show --patch $*
gst=git diff --stat $*
gsw=git switch --progress $*
gt=git tag --list $*

history=cat -n "%CMDER_ROOT%\config\.history"
l=ls -Fh --show-control-chars --append-exe --color=always $*
la=ls -AF --color=always $*
ldir=ls -po --color=always | grep /$ $*
lf=ls -Fo --color=always | grep ^- $*
ll=ls -AFhog --color=always $*
lr=ls -AlgFhtr --color=always $*
ls=ls --show-control-chars --append-exe -Fh --color=always $*
lt=ls -Alght --color=always $*
lx=ls -Fo --color=always | grep ^-..x $*
pro=nvim C:\tools\Cmder\config\user_profile.cmd
pwd=cd
sort=sort /L C $*
tree=tree /F /A $*
unalias=alias /d $1
vi=vim $*
