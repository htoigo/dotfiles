# .zshenv --- ZSH environment file

# Add my personal zsh functions directory to fpath.
fpath=(~/.zsh_fns $fpath)

# For now, we need ~/.local/bin to be before /usr/local/bin because of how
# =stack= works. ~/.local/bin is added to the PATH by
# /etc/profile.d/home-local-bin.sh, which is sourced by /etc/profile, which is
# sourced by /etc/zsh/zprofile. So, we don't need to add this directory here, at
# this time. If we change our Zsh config so that /etc/profile is not sourced,
# then we should uncomment this.
#
# PATH="$HOME/.local/bin:$PATH"

# Set our preferred editor.
export EDITOR="emacsclient -c"

# Asian language input method support.
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# GnuPG

# It is important that GPG_TTY always reflects the output of the 'tty' command.
export GPG_TTY="$(tty)"

# Haskell

# We installed Haskell Platform via =ghcup=, so adjust the PATH to include the
# directories where =ghcup= puts the =ghc= and =cabal= binaries. We do this
# manually rather than sourcing ~/.ghcup/env as that file adds these directories
# to the beginning of PATH, and we want them added to the end for better
# security.
PATH="$PATH:$HOME/.cabal/bin:$HOME/.ghcup/bin"

# Python

# We are using =pipenv= to manage Python virtual environments. Keep Python
# virtual environments in the directories of their projects.
export PIPENV_VENV_IN_PROJECT=1

# Ruby and Ruby Gems

# We want to install all Ruby Gems to our user installation directory,
# ~/.gem/ruby/2.7.0/. So we set the environment variable GEM_HOME, which
# specifies the location of the system installation directory, to point to our
# user installation directory.
export GEM_HOME="$(ruby -r rubygems -e 'puts Gem.user_dir')"

# Consequently, the commands provided by Gems end up in ~/.gem/ruby/2.7.0/bin.
# Add this directory to the PATH.
PATH="$PATH:$(ruby -r rubygems -e 'puts Gem.user_dir')/bin"