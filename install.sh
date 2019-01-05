#!/bin/sh

# Install script for dotfiles repository.

# After cloning the dotfiles repository to your machine, run this script from
# within the newly created dotfiles repo directory.

# This will `install' all of the managed configuration files, using GNU stow to
# set up your config files using links. Config files become symlinks from their
# usual locations to their locations within the dotfiles repo directory tree.

# This depends on GNU stow being installed. This script will install it, if it
# is not already on your machine.

# This script is modeled on Harry Schwartz's dotfiles repo, which is at
# github.com/hrs.


# install() takes one argument, a string containing a list of package names, and
# installs the packages named, using zypper.

install()
{
    # $1: string containing list of package names separated by white space
    local pkgs=$1

    echo $pkgs | xargs sudo zypper install
}


# The list of packages we need to install.
# Possibly add other packages here, which we would like to have installed
# on this system.
pkgs='
  stow
'

# Install the needed openSUSE packages.
install "$pkgs"


# Now, stow the config files in the user's home directory.
stow bash
stow emacs
stow tmux
stow vim

# install.sh ends here