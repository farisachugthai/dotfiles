/* ~/.xsession                                                                       */
/* This file is where you should configure your locales and                  */
/* start i3. It is run by your login manager (xdm, slim, gdm,            */
/*         ...) as soon as you login.                                        */

/* Sample xsession.                                          */

# Disable DPMS turning off the screen
xset -dpms
xset s off

# Disable bell
xset -b

# Enable zapping (C-A-<Bksp> kills X)
# setxkbmap -option terminate:ctrl_alt_bksp
# Enforce correct locales from the beginning:
# LC_ALL is unset since it overwrites everything

# LANG=de_DE.UTF-8 is used, except for:

# LC_MESSAGES=C never translates program output

# LC_TIME=en_DK leads to yyyy-mm-dd hh:mm date/time output

unset LC_ALL

#export LANG=de_DE.UTF-8
export LANG=en_US.UTF-8
export LC_MESSAGES=C

#export LC_TIME=en_DK.UTF-8

# Use XToolkit in java applications
# export AWT_TOOLKIT=XToolkit

# Set background color

xsetroot -solid "#333333"

# i doubt its correct but I'm gonna start xvfb, i3 and vnc in here.

# Enable core dumps in case something goes wrong
ulimit -c unlimited

# the below line might be supposed to put it in .xinitrc
exec Xvfb&

# Start i3 and log to ~/.i3/logfile
echo "Starting at $(date)" >> ~/.local/share/i3/logfile

exec i3 -V -d all >> ~/.local/share/i3/logfile
