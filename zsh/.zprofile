# .zprofile --- ZSH configuration for login shells (read before .zshrc).

# The serial console window often defaults to LINES=24 COLUMNS=80, which is way
# too small these days. Detect whether we are logged in over the serial console,
# and if so, resize the console window to match the actual screen size we have.
# This uses the =resize= program from the Manjaro =xterm= package.

[[ $(tty) = /dev/ttyS0 ]] && eval $(resize)

# When logging in over ssh, we need to set XAUTHORITY to the value that GDM sets
# it to, so that all X client programs will use the same X authority db that the
# emacs daemon is using. This way, emacsclient and all other X clients will work
# over ssh with X forwarding.
#
# We have to do this here AND in ~/.ssh/rc.

systemdXauthority=$(systemctl --user show-environment | grep '^XAUTHORITY=')

if [ -z "$XAUTHORITY" ] && [ -n "$systemdXauthority" ]; then
  export XAUTHORITY=$(echo $systemdXauthority | cut -d= -f2)
fi

unset systemdXauthority
