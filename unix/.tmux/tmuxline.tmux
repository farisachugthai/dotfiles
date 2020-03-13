# This tmux statusbar config was created by tmuxline.vim
# on Sun, 01 Sep 2019

# setw -g window-status-activity-style "underscore,fg=colour246,bg=colour237"
setw -g window-status-activity-style "underscore,fg=#a89984,bg=#282828"
# setw -g window-status-style "none,fg=colour246,bg=colour237"
setw -g window-status-style "none,fg=#a89984,bg=#282828"

set-option -g status-right " #[fg=#dfbf8e,bg=#282828] « #{=21:pane_title} %H:%M %d-%b-%y #{?client_prefix,🚀 🚀 🚀,} #[fg=#dfbf8e,bg=#504945] %R ◀ %a ◀ %Y #[fg=#dfbf8e,bg=#504945] « #[fg=#504945,bg=#dfbf8e] ◀ "
set -g status-right "#[fg=colour237,bg=colour237,nobold,nounderscore,noitalics]«#[fg=colour246,bg=colour237] #(date) #[fg=colour237,bg=colour237,nobold,nounderscore,noitalics]«#[fg=colour246,bg=colour237] %R ◀ %a ◀ %Y #[fg=colour237,bg=colour237,nobold,nounderscore,noitalics]«#[fg=colour246,bg=colour237] #H "
setw -g window-status-format "#[fg=colour237,bg=colour237,nobold,nounderscore,noitalics]»#[default] #I ▶ #W #[fg=colour237,bg=colour237,nobold,nounderscore,noitalics]»"

setw -g window-status-current-format "#[fg=colour237,bg=colour239,nobold,nounderscore,noitalics]»#[fg=colour223,bg=colour239] #I ▶ #W ▶ #F #[fg=colour239,bg=colour237,nobold,nounderscore,noitalics]»"
