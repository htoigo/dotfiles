# .zshenv --- ZSH environment file

# XDG Spec Config

# There are also settings in: /etc/xdg/ and programs xdg-user-dirs-*
# See: https://specifications.freedesktop.org

export XDG_CONFIG_HOME="$HOME/.config"
# XDG_CONFIG_DIRS
export XDG_DATA_HOME="$HOME/.local/share"
# XDG_DATA_DIRS
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
# Set up XDG well-known user directories
[[ -r ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs ]] && . ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs


# The PATH

# TeX Live
PATH="/usr/local/texlive/2023/bin/x86_64-linux:$PATH"
INFOPATH="/usr/local/texlive/2023/texmf-dist/doc/info:$INFOPATH"
