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

case $(uname | tr '[:upper:]' '[:lower:]') in
  linux*)
      if [ -f /etc/os-release ]; then
          . /etc/os-release
          os_id=$ID
      fi
      export os_name="linux-$os_id"
      ;;
  solaris*)
      export os_name=solaris
      ;;
  darwin*)
      export os_name=osx
      ;;
  msys*)
      export os_name=windows
      ;;
  cygwin*)
      export os_name=cygwin
      ;;
  mingw*)
      export os_name=mingw
      ;;
  *)
      export os_name=unknown
      ;;
esac


# install() takes one argument, a string containing a list of package names, and
# installs the packages named, using zypper.

install()
{
    # $1: string containing list of package names separated by white space
    local pkgs="$1"

    case $os_name in
      linux-manjaro) install_cmd='pamac install --no-confirm' ;;
      linux-*suse*)  install_cmd='sudo zypper install' ;;
      *) echo "No install command defined for OS: $os_name"
         return 1
         ;;
    esac

    echo $pkgs | xargs $install_cmd
}


# The list of packages we need to install.
# Possibly add other packages here, which we would like to have installed
# on this system.
pkgs='
  stow
'

# Install the needed openSUSE packages.
install "$pkgs"

# Now, install the config files in the user's home directory.

stow bash
stow dircolors
stow emacs
stow tmux
stow vim

# Create the zsh functions directory so that it does not become a link to the
# dotfiles repo. We just want the individual zsh function files to be links.
mkdir -p ~/.zsh_fns
stow zsh

# Spacemacs
#
# Prepare a directory for Spacemacs before installing. We do this so that the
# Spacemacs directory does not end up being a symlink to the dotfiles repo,
# since we run Spacemacs with HOME=~/apps/spacemacs. That would result in
# Spacemacs cluttering up the dotfiles repo with files it wants to save in HOME.
mkdir -p ~/apps/spacemacs/.emacs.d
git clone https://github.com/syl20bnr/spacemacs.git ~/apps/spacemacs/.emacs.d
stow spacemacs

# install.sh ends here
