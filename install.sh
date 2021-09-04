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
          df_osID=$ID
      fi
      export df_osName="linux-$df_osID"
      ;;
  solaris*)
      export df_osName=solaris
      ;;
  darwin*)
      export df_osName=osx
      ;;
  msys*)
      export df_osName=windows
      ;;
  cygwin*)
      export df_osName=cygwin
      ;;
  mingw*)
      export df_osName=mingw
      ;;
  *)
      export df_osName=unknown
      ;;
esac

# df_install() takes one argument, a string containing a list of package names, and
# installs the packages named, using the distribution's package manager.

df_install()
{
    # $1: string containing list of package names separated by white space
    local pkgs="$1"
    local installCmd

    case $df_osName in
      linux-manjaro) installCmd='pamac install --no-confirm' ;;
      linux-*suse*)  installCmd='sudo zypper install' ;;
      *) echo "No install command defined for OS: $df_osName"
         return 1
         ;;
    esac

    echo $pkgs | xargs $installCmd
}

# The list of packages we need to install.
# Possibly add other packages here, which we would like to have installed
# on this system.
df_pkgsToInstall='
  stow
'

# Install the needed software packages.
df_install "$df_pkgsToInstall"


#
# Now, stow the config files in the user's home directory.
#

stow bash
stow dircolors
stow tmux
stow vim

# Zsh
#
# Create the zsh functions directory so that it does not become a link to the
# dotfiles repo. We just want the individual zsh function files to be links.
mkdir -p ~/.zsh_fns
stow zsh

# Emacs, Spacemacs, etc.
#
# Our multiple Emacs configs live in subdirectories of ~/.emacs-configs, and
# ~/.emacs.d is a symlink to the config we are currently using.

# Ensure the following are directories and not links into the dotfiles repo.
mkdir -p ~/.emacs-configs/hht
mkdir -p ~/.emacs-configs/spacemacs
# Clone the develop branch of Spacemacs repo into its config subdirectory:
git clone -b develop https://github.com/syl20bnr/spacemacs.git ~/.emacs-configs/spacemacs
# Stow the vanilla Emacs config
stow emacs
# IMPORTANT: Before doing the 'stow spacemacs' command below, you should run
# Spacemacs so that it creates a fresh .spacemacs file with the latest updates.
# Then compare this new .spacemacs file with the old one in the dotfiles repo
# and merge changes.
stow spacemacs
# Modify the link target to the config you want to use:
ln -s .emacs-configs/spacemacs ~/.emacs.d


#
# Cleanup the environment
#

unset df_osName df_osID df_pkgsToInstall
unset -f df_install

# install.sh ends here
