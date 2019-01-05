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


# When logging in over the serial console, run the resize function, since the
# serial console window usually defaults to 24 rows x 80 cols, which is often
# wrong nowadays.
[ $(tty) = /dev/ttyS0 ] && resize


if [ -x /usr/bin/fortune ] ; then
    echo
    /usr/bin/fortune
    echo
fi
