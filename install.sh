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

# Function definitions

# df_install() takes one argument, a string containing a list of package names, and
# installs the packages named, using the distribution's package manager.

df_install()
{
    # $1: string containing list of package names separated by white space
    local pkgs="$1"
    local installCmd

    case $df_osName in
      linux-arch)    installCmd='sudo pacman -S --needed' ;;
      linux-manjaro) installCmd='pamac install --no-confirm' ;;
      linux-*suse*)  installCmd='sudo zypper install' ;;
      *) echo "No install command defined for OS: $df_osName"
         return 1
         ;;
    esac

    echo $pkgs | xargs $installCmd
}

# df_install_spacemacs() takes no arguments. It initiates and guides the
# Spacemacs installation process but requires manual interaction to answer
# questions and exit the first run of Spacemacs, then to handle the ediff-files
# of the old and new .spacemacs files.

df_install_spacemacs()
{
    echo "Creating ~/.emacs-configs/spacemacs..."
    mkdir -p ~/.emacs-configs/spacemacs
    echo "Cloning the Spacemacs repo into its config subdirectory..."
    # Clone the develop branch of Spacemacs repo into its config subdirectory:
    git clone -b develop https://github.com/syl20bnr/spacemacs.git \
        ~/.emacs-configs/spacemacs

    # IMPORTANT: Before stowing spacemacs, we should run Spacemacs once so that
    # it creates a fresh .spacemacs file with the latest updates. Then compare
    # this new .spacemacs file with the old one in the dotfiles repo and merge
    # changes into the dotfile repo version of the file.

    # Run Spacemacs - Must answer questions & installs 120+ packages.
    echo "Running Spacemacs once to create fresh .spacemacs file..."
    echo "Answer the questions and then after it installs all packages, close it."
    echo "It will then launch an ediff of the old and new .spacemacs files."
    ln -s .emacs-configs/spacemacs ~/.emacs.d
    emacs
    # Now compare the newly created .spacemacs file with the one in dotfiles.
    # Merge wanted new stuff into the dotfiles .spacemacs file and save.
    emacs -nw --eval '(ediff-files "~/dotfiles/spacemacs/.spacemacs" "~/.spacemacs")'

    # Now we are ready to stow spacemacs.
    echo "Stowing spacemacs..."
    stow spacemacs
}

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
# Create the zsh functions and completion directories so that they do not become
# links into the dotfiles repo. We just want the individual zsh function files
# or completion files within them to be links.
mkdir -p ~/.config/zsh/functions
mkdir -p ~/.config/zsh/completion
stow zsh

# Emacs
#
# Our multiple Emacs configs live in subdirectories of ~/.emacs-configs, and
# ~/.emacs.d is a symlink to the config we are currently using.

# Ensure the following are directories and not links into the dotfiles repo.
mkdir -p ~/.emacs-configs/hht
mkdir -p ~/.emacs-configs/hht-new

# Stow the vanilla Emacs config
stow emacs

# Spacemacs (optional)

# Ask if we want to install Spacemacs on this machine.
# Note: we want this to work in both bash and zsh.

printf "Install Spacemacs? [y/n] "; read -r ans
case $ans in
  [Yy]|Yes|yes) echo "Installing Spacemacs..."
                df_install_spacemacs  ;;
  [Nn]|No|no)   echo "Skipping Spacemacs installation." ;;
  *)            echo "Unknown choice. Spacemacs not installed." ;;
esac

# Specify the Emacs config we want to use:
ln -s .emacs-configs/hht-new ~/.emacs.d


#
# Cleanup the environment
#

unset df_osName df_osID df_pkgsToInstall
unset -f df_install

# install.sh ends here
