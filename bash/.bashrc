# .bashrc:  for SUSE Linux

## bash startup files  (3 different types):

#   login shells:  (outside of X)
#       /etc/profile  ->  ~/.profile
#   non-login, interactive shells:  (terminals in X)
#       /etc/bash.bashrc  ->  ~/.bashrc
#   non-login, non-interactive shells:
#       $BASH_ENV  (name of file to read & execute)

# In SuSE, /etc/profile sources ~/.bashrc, so all settings made here will also
# take effect in a login shell.

# NOTE: It is recommended to make language settings in ~/.profile rather rather
# than here, since multilingual X sessions would not work properly if LANG is
# over-ridden in every subshell.

# Turn off XON/XOFF flow control for the terminal, so that C-s works for bash's
# forward incr-history-search.
# NOTE: 'stty' applies to ttys, which you have for interactive sessions.  In
# some cases (such as when ssh is given a specific command to run), this file
# will be executed in sessions where stdin is not a tty.  This will result in
# the error: stty: 'standard input': Inappropriate ioctl for device The
# solution, other than moving commands like this to .profile, is to make
# execution conditional on our being in an interactive shell.

[[ $- == *i* ]] && stty -ixon

## checkwinsize
# This is set in a clever way in /etc/bash.bashrc in SuSE.

# Enable extended pattern matching: !(pat-list), ?(pat-list), *(pat-list), etc.
shopt -s extglob

# Enable  patterns containing **, eg ./**/src/COPYING
shopt -s globstar


## Shell History

# Append to the history file, don't overwrite it
shopt -s histappend
# Don't put dup lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth
export HISTIGNORE='#*:ls:ll:la:[bf]g:exit'
export HISTSIZE=10000
export HISTFILESIZE=10000


## Shell Prompt

# shell prompt is already set the way I like in SuSE /etc/bash.bashrc.
#
#if [[ ${EUID} == 0 ]]; then
#    PS1="\[\e[1;31m\]\h\[\e[0m\]:\w \\$"
#else
#    PS1="\u@\h:\w \\$"
#fi


## ls Colors

if [[ -x /usr/bin/dircolors ]]; then
    [[ -r ~/.dircolors ]] && eval "$(dircolors ~/.dircolors)" || eval "$(dircolors)"
fi

## less

# Options to pass to less automatically
export LESS="MiR"

# less input preprocessor
#
# SuSE uses input preprocessor lessopen.sh and postprocessor lessclose.sh
# which use a temporary file, rather than an input pipe, such as lesspipe
# in ubuntu. See $LESSOPEN, $LESSCLOSE, man less. 
# grep
#
# Options to pass automatically
#export GREP_OPTIONS=...
#export GREP_COLORS=...


## GnuPG

# It is important that GPG_TTY always reflects the output of the 'tty' command.
# Previously, I set this in .bashrc, but in openSUSE GPG_TTY is set in
# /etc/bash.bashrc.


## SSH

# Environment variables are now set in .bash_profile.


## keychain

# If we are logging in on the console, start keychain here
#[[ -z "$DISPLAY" ]] && keychain id_rsa EB08E34C
#keychain id_rsa 425040BF
#keychain id_rsa
# keychain
# Source the keychain files to bring ssh-agent & gpg-agent variables
# into the environment.
[[ -z "$HOSTNAME" ]] && HOSTNAME=$(uname -n)
[[ -f ~/.keychain/$HOSTNAME-sh ]] && . ~/.keychain/$HOSTNAME-sh
[[ -f ~/.keychain/$HOSTNAME-sh-gpg ]] && . ~/.keychain/$HOSTNAME-sh-gpg


## Set the PATH

# Wrote /etc/profile.local, so it's done the way I want it there.
# The following dirs were in the PATH on a previous installation:
#export PATH="$PATH:/opt/VirtualGL/bin:$HOME/android/android-studio/bin"


## EDITOR

export EDITOR=emacs
export VISUAL=emacs


## Input Methods

# TODO: Uncomment the following after setting up fcitx:
# export GTK_IM_MODULE=fcitx
# export XMODIFIERS="@im=fcitx"
# export QT_IM_MODULE=fcitx


## XDG desktop config

# See: /etc/xdg/ and programs xdg-user-dirs-*

export XDG_DATA_HOME=$HOME/.local/share
# XDG_DATA_DIRS
export XDG_CONFIG_HOME=$HOME/.config
# XDG_CONFIG_DIRS
export XDG_CACHE_HOME=$HOME/.cache
# xdg well-known user directories
[[ -r ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs ]] && . ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs


## Haskell Stack auto-completion

eval "$(stack --bash-completion-script stack)"


## MATLAB

# Use userpath() as the MATLAB startup folder.
# Right now (the default) userpath() is set to: ~/Documents/MATLAB
export MATLAB_USE_USERWORK=1
 
#export CHESSDIR="$HOME/.xboard"
# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server


## Bash aliases

# ~/.alias is sourced (for all shells except ash) in /etc/bash.bashrc.
#test -s ~/.alias && . ~/.alias || true


PATH=$PATH:/home/harry/apps/010editor;export PATH; # ADDED BY INSTALLER - DO NOT EDIT OR DELETE THIS COMMENT - 87FF8EFC-483D-BCAA-D67D-735CF60410D1 12794B61-4123-E38C-C5AD-84BC521E49FE
