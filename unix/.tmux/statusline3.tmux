# This tmux statusbar config was created by tmuxline.vim
# on Fri, 15 Nov 2019

set -g status-keys emacs
set -g status-left-style "none"
set -g status-justify "centre"                    # put the windows in the middle
set -g message-command-style "fg=#dfbf8e,bg=#504945"
set -g status-right-style "none"

# set -g pane-active-border-style "fg=#504945"
set -g status-interval 1
set -g status-style "none,bg=#282828"
set -g message-style "fg=#dfbf8e,bg=#504945"
set -g pane-border-style "fg=#282828"
set -g status-right-length "100"
set -g status-left-length "100"
setw -g window-status-activity-style "underscore,fg=#a89984,bg=#282828"
setw -g window-status-separator ""
setw -g window-status-style "none,fg=#a89984,bg=#282828"
set -g status-left "#[fg=#504945,bg=#dfbf8e] ▶ #S : #[fg=#dfbf8e,bg=#282828,nobold,nounderscore,noitalics]»"
set -g status-right "#[fg=#504945,bg=#282828,nobold,nounderscore,noitalics]« #{?client_prefix,🚀 🚀 🚀,} #[fg=#dfbf8e,bg=#504945] #[fg=#dfbf8e,bg=#504945,nobold,nounderscore,noitalics]«#[fg=#504945,bg=#dfbf8e] #(whoami) ◀ "
setw -g window-status-format "#[fg=#282828,bg=#282828,nobold,nounderscore,noitalics]»#[default] #I ▶ #W #[fg=#282828,bg=#282828,nobold,nounderscore,noitalics]»"
setw -g window-status-current-format "#[fg=#282828,bg=#504945,nobold,nounderscore,noitalics]»#[fg=#dfbf8e,bg=#504945] #I ▶ #W #[fg=#504945,bg=#282828,nobold,nounderscore,noitalics]»"
