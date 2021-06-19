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


# Disable XON/XOFF flow control.
# We want to use C-s for history-incremental-search-forward.
stty -ixon


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


# Spacemacs

# A special function to start Spacemacs with its own HOME directory so it
# doesn't mix up its files with our regular Emacs config in ~/.emacs.d/.
autoload -U spacemacs


# Autoload other custom functions
autoload -U dos2unix fndups fngrps glp mkcd mkqr sens srch unix2dos


# Use autosuggestions, à la fish shell.
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'


# Theming

autoload -Uz compinit colors zcalc
compinit -d
colors


# Prompt

autoload -Uz promptinit
promptinit
prompt harry


# less

# Options to pass to less automatically.
export LESS=iMR
# Set up an input pipe for less
export LESSOPEN="||lesspipe.zsh %s"


# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'


# Plugins

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

# pkgfile
if [[ -r /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
    source /usr/share/doc/pkgfile/command-not-found.zsh
    export PKGFILE_PROMPT_INSTALL_MISSING=1
fi


# nvm - Node.js version manager

. /usr/share/nvm/init-nvm.sh


# Aliases

if [[ -r ~/.zsh_alias ]]; then
    source ~/.zsh_alias
fi


# Show the user some system information when an interactive shell is started.

print $USER@$HOST  $(uname -srm) $(lsb_release -rcs)
