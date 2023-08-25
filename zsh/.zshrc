# .zshrc --- ZSH configuration for interactive shells.

# Any settings that will not confuse dumb terminals go here.

# ...

# Dumb terminal bailout:
#
# If a dumb terminal is connecting, disable ZLE, set a very simple prompt and
# abort before we do any fancy setup which activates things like escape
# sequences for clorized output, right-hand side prompt, etc.
#
# This includes Emacs Tramp, which sets $TERM to 'dumb'. Emacs Tramp needs to
# recognize the shell prompt (via regex search) for accurate parsing of shell
# responses. Escape sequences for coloring and other fancy stuff such as zsh
# line editor's (ZLE) right-hand side prompts (gasp!) seriously confuse Tramp
# and can prevent it from connecting.

[[ $TERM = "dumb" ]] && unsetopt zle && PROMPT='> ' && return


# Source manjaro-zsh-configuration
# if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
#   source /usr/share/zsh/manjaro-zsh-config
# fi


# Zsh Options

setopt no_beep

setopt extended_glob
setopt no_case_glob
setopt numeric_glob_sort

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

setopt rc_expand_param

# Don't send the HUP signal to running jobs when this interactive shell exits.
setopt no_hup

setopt correct

# Shell History

HISTFILE=~/.zhistory
HISTSIZE=21000
SAVEHIST=20000

# Save commands to the history file as soon as they are entered, rather than
# waiting until the shell exits.
unsetopt append_history
setopt inc_append_history

# Keep dups in history list until it is full, then purge oldest duplicates first.
# This option requires that HISTSIZE is larger then SAVEHIST to give some room
# for duplicated events; otherwise this option behaves just like HIST_IGNORE_ALL_DUPS
# once the history has filled up with unique events.
setopt hist_expire_dups_first

# Don't save =history (fc -l)= commands in the history list.
setopt hist_no_store
# Don't add lines starting with a space to the history.
setopt hist_ignore_space

export HISTORY_IGNORE='(# *|ls *|ll *|la *|exit|[bf]g)'

# Let us see history expansions before executing them.
setopt hist_verify


# Zsh Plugins

# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Use autosuggestions, à la fish shell.
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# pkgfile
if [[ -r /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
  export PKGFILE_PROMPT_INSTALL_MISSING=1
fi


# Zsh function path

# User-specific zsh auto-completion
mkdir -p "$HOME/.config/zsh/completion"
fpath=("$HOME/.config/zsh/completion" $fpath)

# User-specific zsh functions directory
mkdir -p "$HOME/.config/zsh/functions"
fpath=("$HOME/.config/zsh/functions" $fpath)


# Theming

autoload -Uz compinit colors zcalc
compinit -d
colors

# Prompt
autoload -Uz promptinit
promptinit
prompt harry


# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'


# Autoload other custom functions

autoload -U dos2unix fndups fngrps glp mkcd mkqr rasterizePdf sens srch unix2dos


# Disable XON/XOFF flow control.
# We want to use C-s for history-incremental-search-forward.
stty -ixon


# less

# Options to pass to less automatically.
export LESS=iMR

# Set up an input pipe for less
export LESSOPEN="||lesspipe.zsh %s"


# GnuPG

# It is important that GPG_TTY always reflects the output of the 'tty' command.
export GPG_TTY="$(tty)"


# Preferred editor.

export EDITOR="emacsclient -c"


# The PATH

# $HOME/.local/bin must be before /usr/local/bin because of how stack works.
# We add it to the PATH conditionally, as on Manjaro at least,
# /etc/profile.d/home-local-bin.sh (sourced by /etc/profile, which is sourced
# by /etc/zsh/zprofile) does this already.
if [[ -d "$HOME/.local/bin" && ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# Haskell

# Ensure ~/.ghcup/bin and ~/.cabal/bin are in the PATH. We want ghcup's bin dir
# to be before cabal's so that ghcup's programs are preferred. NB: GHCup sources
# a ~/.ghcup/env file to do this, but that puts .cabal/bin before .ghcup/bin.

if [[ -d "$HOME/.ghcup/bin" && ":$PATH:" != *":$HOME/.ghcup/bin:"* ]]; then
  export PATH="$PATH:$HOME/.ghcup/bin"
fi
if [[ -d "$HOME/.cabal/bin" && ":$PATH:" != *":$HOME/.cabal/bin:"* ]]; then
  export PATH="$PATH:$HOME/.cabal/bin"
fi

# Ruby and Ruby Gems

# Rubygems has a system installation directory and a user installation directory.
# The environment variable GEM_HOME specifies the location of the system
# installation directory. The user installation directory is usually under
# ~/.gem or $XDG_DATA_HOME/gem (by default ~/.local/share/gem), and this location
# can be found in the Ruby variable Gem.user_dir.

# We want to install all Ruby Gems into our user installation directory, so we
# set GEM_HOME to that.

if command -v ruby >/dev/null; then
  export GEM_HOME="$(ruby -r rubygems -e 'puts Gem.user_dir')"

  if [[ -d "$GEM_HOME/bin" && ":${PATH}:" != *":$GEM_HOME/bin:"* ]]; then
    export PATH="$PATH:$GEM_HOME/bin"
  fi
fi

# Rust

# Setup environment vars for cargo. One thing this does is add Cargo's bin
# directory to the $PATH.
if [[ -r "$HOME/.cargo/env" ]]; then
  . "$HOME/.cargo/env"
fi

# nvm - Node.js version manager

if [[ -n "$XDG_CONFIG_HOME" && -d "$XDG_CONFIG_HOME/nvm" ]]; then
  export NVM_DIR="$XDG_CONFIG_HOME/nvm"
elif [[ -d "$HOME/.nvm" ]]; then
  export NVM_DIR="$HOME/.nvm"
fi
if [[ -n "$NVM_DIR" ]]; then
  [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"                    # This loads nvm
  [[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Python

# We are using pyenv to manage Python versions and virtual environments. Keep
# Python virtual environments in the directories of their projects.

# Pyenv

if command -v pyenv >/dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  eval "$(pyenv init -)"
fi


# Nix package manager

# Set up nix environment variables.
if [ -e /home/harry/.nix-profile/etc/profile.d/nix.sh ]; then
  . /home/harry/.nix-profile/etc/profile.d/nix.sh
fi


# CDDB server

# Configure cddbp server env vars for cdda2wav
if [[ -r "$HOME/.cddb.conf" ]]; then
  . "$HOME/.cddb.conf"
fi


# Aliases

if [[ -r ~/.zsh_alias ]]; then
    source ~/.zsh_alias
fi


# Show the user some system information when an interactive shell is started.
print $USER@$HOST  $(uname -srm) $(lsb_release -rcs)
