#!/bin/bash
# vim:set ai et sts=2 sw=2 tw=80:
#
# /etc/X11/Xsession
#
# global Xsession file -- used by display managers and xinit (startx)

# $Id: Xsession 967 2005-12-27 07:20:55Z dnusinow $

set -e

PROGNAME=Xsession

message () {
  # pretty-print messages of arbitrary length; use xmessage if it
  # is available and $DISPLAY is set
  local MESSAGE="$PROGNAME: $*"
  echo "$MESSAGE" | fold -s -w ${COLUMNS:-80} >&2
  if [ -n "$DISPLAY" ] && command -v xmessage > /dev/null 2>&1; then
    echo "$MESSAGE" | fold -s -w ${COLUMNS:-80} | xmessage -center -file -
  fi
}

message_nonl () {
  # pretty-print messages of arbitrary length (no trailing newline); use
  # xmessage if it is available and $DISPLAY is set
  MESSAGE="$PROGNAME: $*"
  echo -n "$MESSAGE" | fold -s -w ${COLUMNS:-80} >&2;
  if [ -n "$DISPLAY" ] && command -v xmessage > /dev/null 2>&1; then
    echo -n "$MESSAGE" | fold -s -w ${COLUMNS:-80} | xmessage -center -file -
  fi
}

errormsg () {
  # exit script with error
  message "$*"
  exit 1
}

internal_errormsg () {
  # exit script with error; essentially a "THIS SHOULD NEVER HAPPEN" message
  # One big call to message() for the sake of xmessage; if we had two then
  # the user would have dismissed the error we want reported before seeing the
  # request to report it.
  errormsg "$*" \
           "Please report the installed version of the \"x11-common\"" \
           "package and the complete text of this error message to" \
           "<debian-x@lists.debian.org>."
}

# initialize variables for use by all session scripts

export OPTIONFILE=/etc/X11/Xsession.options
export SYSRESOURCES=/etc/X11/Xresources
export USRRESOURCES=$HOME/.Xresources
export SYSSESSIONDIR=/etc/X11/Xsession.d
export USERXSESSION=$HOME/.xsession
export USERXSESSIONRC=$HOME/.xsessionrc
export ALTUSERXSESSION=$HOME/.Xsession
export ERRFILE=$HOME/.xsession-errors

# attempt to create an error file; abort if we cannot. ...wait can i unset this
# because i hate the xsession errors file? hm nah i guess leave it for now.
if (umask 077 && touch "$ERRFILE") 2> /dev/null && [ -w "$ERRFILE" ] &&
  [ ! -L "$ERRFILE" ]; then
  chmod 600 "$ERRFILE"
elif ERRFILE=$(tempfile 2> /dev/null); then
  if ! ln -sf "$ERRFILE" "${TMPDIR:=/tmp}/xsession-$USER"; then
    message "warning: unable to symlink \"$TMPDIR/xsession-$USER\" to" \
             "\"$ERRFILE\"; look for session log/errors in" \
             "\"$TMPDIR/xsession-$USER\"."
  fi
else
  errormsg "unable to create X session log/error file; aborting."
fi

exec >>"$ERRFILE" 2>&1

echo "$PROGNAME: X session started for $LOGNAME at $(date)"

# sanity check; is our session script directory present?
if [ ! -d "$SYSSESSIONDIR" ]; then
  errormsg "no \"$SYSSESSIONDIR\" directory found; aborting."
fi

# Attempt to create a file of non-zero length in /tmp; a full filesystem can
# cause mysterious X session failures.  We do not use touch, :, or test -w
# because they won't actually create a file with contents.  We also let standard
# error from tempfile and echo go to the error file to aid the user in
# determining what went wrong.
WRITE_TEST=$(tempfile)
if ! echo "*" >>"$WRITE_TEST"; then
  message "warning: unable to write to ${WRITE_TEST%/*}; X session may exit" \
          "with an error"
fi
rm -f "$WRITE_TEST"

# use run-parts to source every file in the session directory; we source
# instead of executing so that the variables and functions defined above
# are available to the scripts, and so that they can pass variables to each
# other
SESSIONFILES=$(run-parts --list $SYSSESSIONDIR)
if [ -n "$SESSIONFILES" ]; then
  set +e
  for SESSIONFILE in $SESSIONFILES; do
    . $SESSIONFILE
  done
  set -e
fi

# From man i3
# ~/.xsession
# This file is where you should configure your locales and
# start i3. It is run by your login manager (xdm, slim, gdm,
#         ...) as soon as you login.

# To interject sddm is the DM for kde.

# Sample xsession.

# Disable DPMS turning off the screen. Honestly still don't know what it does.
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

# could we not do that?
# export LC_TIME=en_US.UTF-8

# Use XToolkit in java applications
# export AWT_TOOLKIT=XToolkit

# Set background color
# uh what is this command and can we not set a wallpaper like a good 21st
# century DE?
# xsetroot -solid "#333333"

# Enable core dumps in case something goes wrong
ulimit -c unlimited

# the below line might be supposed to put it in .xinitrc
# dude it's not a default package why would you leave it naked
if [[ -n $(command -v Xvfb) ]]; then
  exec Xvfb&
fi

# Start i3 and log to ~/.i3/logfile
# wait hold on now this is very specific to i3 and maybe i don't want i3
# echo "Starting at $(date)" >> ~/.local/share/i3/logfile

# exec i3 -V -d all >> ~/.local/share/i3/logfile

# How in the world did I just let that global var sit for so long?
unset PROGNAME

exit 0
