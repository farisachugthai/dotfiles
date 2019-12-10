# This tmux statusbar config was created by tmuxline.vim
# on Fri, 15 Nov 2019
# Updates: Dec 10, 2019

# Basic Setup: {{{1
set -g status "on"
set -g status-interval 1
set -g status-keys emacs
set -g status-left-style "none"
set -g status-right-style "none"
set -g status-justify "centre"                    # put the windows in the middle
# set -g status-justify "left"

# set -g status-right-length "100"
# Doesnt do well on termux
set -g status-left-length "100"

# set -g status-bg '#1d2021'
# set -g status-fg '#ebdbb2'

# Basic Colors: {{{1
set -g status-interval 1
set -g status-style "none,bg=#282828"
# set -g status-style "none,bg=colour237"

# Panes: {{{1

# I don't know how this isn't listed as being set but pane-active-border-style
# could use work
set-window-option -g pane-active-border-style "fg=#7daea3,bold" # bg='#
# set-option -g pane-active-border-style fg=colour240 #fg=base01
# set-window-option -g pane-border-style "fg=#7daea3"
# setw -g pane-border-status
set -g pane-border-style "fg=#282828"
# set -g pane-border-style "fg=colour237"
# set -g pane-active-border-style "fg=#504945"

# Windows: {{{1
set-window-option -g window-status-style default
setw -g window-status-format "#[fg=cyan] #I #[fg=colour253 #W "
setw -g window-status-current-format "#[fg=cyan]#[fg=colour253] #I #[fg=colour253] #W #[fg=cyan]"

# active window title colors
set-window-option -g window-status-current-style fg=colour166,bg=default,bright # fg=orange

# TODO: This needs to be conditional on tmux version
# set-window-option -g window-size largest

# TODO: Need better colors
# set-window-option -g window-status-style bg=$BYOBU_DARK,fg=$BYOBU_LIGHT
# set-window-option -g window-status-current-style bg=$BYOBU_DARK,fg=$BYOBU_LIGHT,reverse
# set-window-option -g window-status-activity-style bg=$BYOBU_DARK,fg=$BYOBU_LIGHT,bold
# setw -g window-status-current-attr bright
# setw -g window-status-current-bg default
# setw -g window-status-current-fg colour237

setw -g window-status-activity-style "underscore,fg=#a89984,bg=#282828"
setw -g window-status-separator ""
setw -g window-status-style "none,fg=#a89984,bg=#282828"

# Message Command Line: {{{1
# set-option -g message-command-style fg='#ebdbb2',noreverse

# commands inactive
# set -g message-command-bg colour239 #fg3
# set -g message-command-fg colour223 #bg1
# set -g message-fg cyan
# set -g message-bg colour235  # black
# set -g message-attr bright

set -g message-command-style "fg=#dfbf8e,noreverse,bg=#504945"
# set -g message-command-style "fg=colour223,bg=colour239"
set -g message-style "fg=#dfbf8e,bg=#504945"
# set-option -g message-style bg=colour235,fg=colour166 # bg=base02, fg=orange
# set -g message-style "fg=colour223,bg=colour239"


# Format statements: {{{1

set -g status-left "#[fg=#504945,bg=#dfbf8e] ▶ #S : #[fg=#dfbf8e,bg=#282828,nobold,nounderscore,noitalics]»#[fg=colour246,bg=colour237] ▶ #(uptime  | cut -d \" \" -f 1,2,3) #[fg=colour237,bg=colour237,nobold,nounderscore,noitalics]»"

# set -g status-left "#[fg=colour246,bg=colour237] #S #[fg=colour237,bg=colour237,nobold,nounderscore,noitalics]»#[fg=colour246,bg=colour237] #(whoami) ▶ #(uptime  | cut -d \" \" -f 1,2,3) #[fg=colour237,bg=colour237,nobold,nounderscore,noitalics]»"

set -g status-right "#[fg=#504945,bg=#282828,nobold,nounderscore,noitalics]« #{?client_prefix,🚀 🚀 🚀,} #[fg=#dfbf8e,bg=#504945] #[fg=#dfbf8e,bg=#504945,nobold,nounderscore,noitalics]«#[fg=#504945,bg=#dfbf8e] ◀ "

# set -g status-right "#[fg=colour237,bg=colour237,nobold,nounderscore,noitalics]«#[fg=colour246,bg=colour237] #(date) #[fg=colour237,bg=colour237,nobold,nounderscore,noitalics]«#[fg=colour246,bg=colour237] %R ◀ %a ◀ %Y #[fg=colour237,bg=colour237,nobold,nounderscore,noitalics]«#[fg=colour246,bg=colour237] #H "


# indicate whether Prefix has been captured + time in the right-status area
# set -g status-left "#[fg=colour166] #h #[fg=colour166] #S "
# set -g status-right '#[fg=colour66]#[fg=colour66] %H:%M '

setw -g window-status-format "#[fg=#282828,bg=#282828,nobold,nounderscore,noitalics]»#[default] #I ▶ #W #[fg=#282828,bg=#282828,nobold,nounderscore,noitalics]»"

setw -g window-status-current-format "#[fg=#282828,bg=#504945,nobold,nounderscore,noitalics]»#[fg=#dfbf8e,bg=#504945] #I ▶ #W #F #[fg=#504945,bg=#282828,nobold,nounderscore,noitalics]»"

