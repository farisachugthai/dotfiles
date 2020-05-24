;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= rem fix this:: sort="sort /L C $*"
;= goto:eof
;= Add aliases below here
alias="nvim C:\Users\fac\projects\dotfile\nt\Cmder\user_aliases.cmd"
cat=bat $*
clear=cls
df=df -ah --total $*
dir=dir /ON $*
ddir=dir /Q /ON $*
dus=du -d 1 -h -all $*
ex=explorer .
free=free -mt $*
git_alias="git config --get-regexp alias.*"
g=git diff --stat --staged $*
ga=git add . $*
gar=git add --renormalize -v $*
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
gds2=git diff --stat --staged
gdt=git difftool $*
gf=git fetch --all $*
gl=git log --graph --decorate --all --abbrev --abbrev-commit --pretty=lo $*
glo=git log $*
gls=git ls-tree
gm=git merge --proress --stat $*
gma=git merge --abort $*
gmc=git merge --continue $*
gmm=git merge --progress --stat master $*
gmt=git mergetool $*
gp=git pull $*
gpo=git pull origin
gpom=git pull origin master
gpu=git push $*
gr=git remote -v $*
grb=git rebase $*
grba=git rebase --abort $*
grbc=git rebase --continue $*
grbi=git rebase --interactive $*
gre=git remote $*
gs=git status $*
gsh=git stash $*
gshd=git stash drop $*
gshl=git stash list $*
gshp=git stash pop $*
gshs=git stash show $*
gshsp=git stash show --patch $*
gst=git diff --stat $*
gsw=git switch --progress $*
gt=git tag --list $*
l=ls -Fh --show-control-chars --color=always --hide=NTUSER* $*
la=ls -AFh --show-control-chars --color=always --hide=ntuser* $*
ldir=ls -po --color=always --hide=ntuser* | grep /$ $*
lf=ls -Fo --color=always --hide=ntuser* | grep ^- $*
ll=ls -AFhog --show-control-chars --color=always --hide=ntuser* $*
lr=ls -lgFhtr --color=always --hide=ntuser* $*
ls=ls -Fh --show-control-chars --color=always --hide=NTUSER* $*
lt=ls -lght --color=always --hide=ntuser* $*
lx=ls -Fo --color=always --hide=ntuser* | grep ^-..x $*
pwd=cd
tree=tree /F /A
vi=vim $*
