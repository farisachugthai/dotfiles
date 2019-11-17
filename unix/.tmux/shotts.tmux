# From:
# http://linuxcommand.org/lc3_adv_termmux.php

#####
# Create session with 4 windows
#####

# Create session and first window
new-session -d -s MySession

# Create second window and vertically split it
new-window
split-window -d -h

# Create third window (and name it) running Midnight Commander
# new-window -d -n MdnghtCmdr mc
new-window -d -n ranger ranger

# Create fourth window (and name it) running htop
new-window -d -n htop htop

# Give focus to the first window in the session
select-window -t 0

# Since this configuration creates a new session, we should launch tmux by
# entering the command tmux attach to avoid the default behavior of
# automatically creating a new session. Otherwise, we end up with an additional
# and unwanted session.

# Vim: set ft=tmux :
