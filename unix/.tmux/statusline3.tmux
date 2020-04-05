# This tmux statusbar config was created by tmuxline.vim
# on Fri, 15 Nov 2019
# Updates: Dec 10, 2019
# NOTE: The super long format expressions are at the bottom

# Basic Setup: {{{
set -g status "on"
# Update the statusline every second. The default is 1 time every 15 seconds wth?
set -g status-interval 1
set -g status-keys emacs
# put the windows in the middle
set -g status-justify "centre"
# Note the quoting and that both of these works.
set -g status-left-length "75"
set -g status-right-length 100

set -g status-bg '#1d2021'
set -g status-fg '#ebdbb2'

# Equivalent to is the same color but not 16m.
# set -g status-style "none,bg=colour237"
set -g status-style "none,bg=#282828"

set-option -g pane-active-border-style "fg=#7daea3,bold"
setw -g pane-border-style "fg=#7daea3,bold"

# set -g pane-border-style "fg=#504945"
# set -g pane-border-style "fg=colour237"
setw -g pane-border-status top
setw -g pane-border-format '#{t:window_activity}'

set-window-option -g window-status-style default
setw -g window-status-format "#[fg=cyan] #I#F #[fg=colour253] #W "
setw -g window-status-current-format "#[fg=cyan]#[fg=colour253] #I#F #[fg=colour253] #W #[fg=cyan]"

# active window title colors
set-window-option -g window-status-current-style fg=colour166,bg=default,bright # fg=orange

# TODO: This needs to be conditional on tmux version
# set-window-option -g window-size largest

setw -g window-status-activity-style "underscore,fg=#a89984,bg=#282828"
setw -g window-status-separator ""
setw -g window-status-style "none,fg=#a89984,bg=#282828"
# }}}

# Server: Display-panes: {{{
# set -g display-panes-active-colour "#7daea3"
set -g display-panes-time 750
# }}}

# Message Command Line: {{{1
# set -g message-command-style "fg=colour223,bg=colour239"
# Equivalent to
set -g message-command-style "fg=#dfbf8e,noreverse,bg=#504945,bright"

# set -g message-style "fg=colour223,bg=colour239"
set -g message-style "fg=#dfbf8e,bg=#504945"

# set-option -g message-style bg=colour235,fg=colour166 # bg=base02, fg=orange
# }}}

# Format statements: {{{1

set-option -g status-left " #[fg=#504945,bg=#dfbf8e] ▶ #S: #[fg=#dfbf8e,bg=#282828] » #(sysctl vm.loadavg) #[fg=colour246,bg=colour237] #(whoami) ▶ #[fg=#dfbf8e,bg=#282828] » "

# set -g status-left "#[fg=colour246,bg=colour237] #S #[fg=colour237,bg=colour237,nobold,nounderscore,noitalics]»#[fg=colour246,bg=colour237] #(whoami) ▶  #[fg=colour237,bg=colour237,nobold,nounderscore,noitalics]»"

# Alright well this is dying on byobu so TODO: figure out a check for if wer're in their shell or tmux
set-option -g status-right " #[fg=#dfbf8e,bg=#282828] « #{=21:pane_title} « #{?client_prefix,🚀 🚀 🚀,} #[fg=#dfbf8e,bg=#282828] « %R ◀ %a ◀ #[fg=#dfbf8e,bg=#504945] « #[fg=#504945,bg=#dfbf8e] ◀ #H:%M "

# "#(tmux right -R pane_id=\`tmux display -p #D`)"
# This is the only part I really care about anyway
# set -ag status-right "#{?client_prefix,🚀 🚀 🚀,}"
# set -g status-right '#[fg=colour66]#[fg=colour66] %H:%M '
setw -g window-status-format " #[fg=#dfbf8e,bg=#282828] » #[default] #I ▶ #W #[fg=#dfbf8e,bg=#282828] « "
setw -g window-status-current-format " #[fg=#dfbf8e,bg=#282828] » #[fg=#dfbf8e,bg=#504945] #I#F ▶ #W #[fg=#dfbf8e,bg=#282828] » "
# Who wants to see if we can add unicode symbols directly in here. Nope.
# setw -ga window-status-current-format U+1F5A5
# }}}

