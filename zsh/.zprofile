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

# Ensure the ssh-agent environment variables are set.
#
# Note: we don't want to overwrite an existing value of SSH_AUTH_SOCK set by a
# forwarded ssh agent.
#
# Pull the variables in from systemd user environment. We only need this when
# logging in on a tty; gdm-wayland-session automatically propagates systemd user
# environment into the wayland session.

if [[ ! -v SSH_AUTH_SOCK ]]; then
  eval $(systemctl --user show-environment | grep SSH_AUTH_SOCK)
  export SSH_AUTH_SOCK
fi
if [[ ! -v SSH_AGENT_PID ]]; then
  eval $(systemctl --user show-environment | grep SSH_AGENT_PID)
  export SSH_AGENT_PID
fi
