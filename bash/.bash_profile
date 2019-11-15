# .bash_profile:  for SUSE Linux
#
# bash startup files  (3 different types):
#
# login shells:  (outside of X)
#     /etc/profile  ->  ~/.profile
#
# non-login, interactive shells:  (terminals in X)
#     /etc/bash.bashrc  ->  ~/.bashrc
#
# non-login, non-interactive shells:
#     $BASH_ENV  (name of file to read & execute)
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# ~/.bashrc, since multilingual X sessions would not work properly if LANG is
# overridden in every subshell.
#
# Most applications support several languages for their output.
# To make use of this feature, simply uncomment one of the lines below or
# add your own one (see /usr/share/locale/locale.alias for more codes)
# This overwrites the system default set in /etc/sysconfig/language
# in the variable RC_LANG.
#
#export LANG=de_DE.UTF-8	# uncomment this line for German output
#export LANG=fr_FR.UTF-8	# uncomment this line for French output
#export LANG=es_ES.UTF-8	# uncomment this line for Spanish output

test -z "$PROFILEREAD" && . /etc/profile || true


#
# Resizing the Serial Console Window
#

# The serial console window often defaults to LINES=24 COLUMNS=80, which is
# usually wrong these days. The following resize functions correct this. They
# were found at
#
#   unix.stackexchange.com/questions/16578/resizable-serial-console-window/
#
# These scripts may be too slow, especially to be run after every command. If
# that turns out to be the case, then we can instead use the `resize' program
# from the xterm package.

resize() {
  # This function only uses ANSI escape codes.
  old=$(stty -g)
  stty raw -echo min 0 time 5

  printf '\0337\033[r\033[999;999H\033[6n\0338' >/dev/tty
  IFS='[;R' read -r _ rows cols _ </dev/tty

  stty "$old"
  # echo "cols:$cols"
  # echo "rows:$rows"
  stty cols "$cols" rows "$rows"
}

resize2() {
  # This function uses an xterm-specific escape code for getting the size
  # information we want. However, this escape code is also implemented in
  # many other terminal emulators.
  old=$(stty -g)
  stty raw -echo min 0 time 5

  printf '\033[18t' >/dev/tty
  IFS=';t' read -r _ rows cols _ </dev/tty

  stty "$old"
  # echo "cols:$cols"
  # echo "rows:$rows"
  stty cols "$cols" rows "$rows"
}

# Detect whether we are logged in over the serial console, and if so, resize the
# console window to match the actual screen size we have.
[ $(tty) = /dev/ttyS0 ] && resize


# Environment variables

export SSH_ASKPASS=/usr/lib/ssh/ssh-askpass
export SUDO_ASKPASS=/usr/lib/ssh/ssh-askpass


if [ -x /usr/bin/fortune ] ; then
    echo
    /usr/bin/fortune
    echo
fi
