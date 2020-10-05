# .zprofile --- ZSH configuration for login shells (read before .zshrc).


# The serial console window often defaults to LINES=24 COLUMNS=80, which is way
# too small these days. Detect whether we are logged in over the serial console,
# and if so, resize the console window to match the actual screen size we have.
# This uses the =resize= program from the Manjaro =xterm= package.
[[ $(tty) = /dev/ttyS0 ]] && resize
