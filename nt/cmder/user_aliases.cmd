;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below here
cat=bat $*
clear=cls
clink="C:\tools\Cmder\vendor\clink/clink_x64.exe" --cfgdir "C:\tools\Cmder\config" $*
cmderr=cd /d "%CMDER_ROOT%"
conda="C:\tools\vs\2019\Community\Common7\IDE\Extensions\Microsoft\Python\Miniconda\Miniconda3-x64\condabin\conda.bat" $*
cp=cp -v $*
df=df -ah --total $*
dus=du -d 1 -h -all $*
e.=explorer .
free=free -mt $*

g=git diff --stat --staged $*
ga=git add --renormalize . $*
gar=git add --renormalize . $*
gb=git branch --all --remote --verbose $*
gbl=git blame $*
gbr=git branch $*
gbrd=git branch -d $*
gbrD=git branch -d $*
gbru=git branch --set-upstream-to --verbose origin
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
gdt=git difftol $*
gf=git fetch --all $*
gl=git log --pretty=lo $*
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
gshp=git stash -p $*
gshs=git stash show $*
gshsp=git stash show -p $*
gst=git diff --stat $*
gsw=git switch --progress $*
gt=git tag --list $*

history=cat -n "%CMDER_ROOT%\config\.history"
la=ls -AF --color=always $*
ldir=ls -po --color=always | grep /$
lf=ls -Fo --color=always | grep ^-
ll=ls -AFhog --color=always $*
lr=ls -AlgFhr --color=always $*
ls=ls --show-control-chars --append-exe -Fh --color=always $*
lt=ls -Alght --color=always $*
lx=ls -Fo --color=always | grep ^-..x
mkdir=mkdir -pv $*
mv=mv -v $*
pro=nvim C:\tools\Cmder\config\user_profile.cmd
pwd=cd
rm=rm -Iv $*
rmdir=rmdir -v $*
tail=tail -n 30 $*
unalias=alias /d $1
vi=vim $*
