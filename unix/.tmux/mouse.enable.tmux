# Tmux mouse enable

#### TODO: We need to figure out version checks because these are the events
# in tmux2
           # WheelUp       WheelDown
           # MouseDown1    MouseUp1      MouseDrag1   MouseDragEnd1
           # MouseDown2    MouseUp2      MouseDrag2   MouseDragEnd2
           # MouseDown3    MouseUp3      MouseDrag3   MouseDragEnd3
           # DoubleClick1  DoubleClick2  DoubleClick3 WheelUp
           # TripleClick1  TripleClick2  TripleClick3 WheelDown


set -g mouse on
bind-key    -T copy-mode-vi    MouseDown1Pane         send-keys -M scroll-down
bind-key    -T copy-mode-vi    MouseUp1Pane           send-keys -M scroll-up

# Defaults but make sure
bind-key    -T copy-mode-vi    MouseDrag1Pane        select-pane \; send-keys -M begin-selection
bind-key    -T copy-mode-vi    MouseDragEnd1Pane     send-keys -M copy-selection-and-cancel
bind-key    -T copy-mode-vi    WheelUpPane           select-pane \; send-keys -M -N 5 scroll-up
bind-key    -T copy-mode-vi    WheelDownPane         select-pane \; send-keys -M -N 5 scroll-down
bind-key    -T copy-mode-vi    DoubleClick1Pane      select-pane \; send-keys -M select-word
bind-key    -T copy-mode-vi    TripleClick1Pane      select-pane \; send-keys -M select-line

# Dude byobu went nuts on this one
bind-key    -T root         MouseDown1Pane        select-pane -t = \; send-keys -M

bind-key    -T root         MouseDown1Status      select-window -t =

bind-key    -T root         MouseDown3Pane        if-shell -F -t = "#{||:#{mouse_any_flag},#{pane_in_mode}}" "select-pane -t=; send-keys -M" "display-menu -t= -xM -yM -T \"#[align=centre]#{pane_index} (#{pane_id})\"  '#{?mouse_word,Search For #[underscore]#{=/9/...:mouse_word},}' 'C-r' {copy-mode -t=; send -Xt= search-backward \"#{q:mouse_word}\"} '#{?mouse_word,Type #[underscore]#{=/9/...:mouse_word},}' 'C-y' {send-keys -l -- \"#{q:mouse_word}\"} '#{?mouse_word,Copy #[underscore]#{=/9/...:mouse_word},}' 'c' {set-buffer -- \"#{q:mouse_word}\"} '#{?mouse_line,Copy Line,}' 'l' {set-buffer -- \"#{q:mouse_line}\"} '' 'Horizontal Split' 'h' {split-window -h} 'Vertical Split' 'v' {split-window -v} '' 'Swap Up' 'u' {swap-pane -U} 'Swap Down' 'd' {swap-pane -D} '#{?pane_marked_set,,-}Swap Marked' 's' {swap-pane} '' 'Kill' 'X' {kill-pane} 'Respawn' 'R' {respawn-pane -k} '#{?pane_marked,Unmark,Mark}' 'm' {select-pane -m} '#{?window_zoomed_flag,Unzoom,Zoom}' 'z' {resize-pane -Z}"

# So this is one of the ones that needs to be conditional
# bind-key    -T root         MouseDown3Status      display-menu -T "#[align=centre]#{window_index}:#{window_name}" -t = -x W -y S "Swap Left" l "swap-window -t:-1" "Swap Right" r "swap-window -t:+1" "#{?pane_marked_set,,-}Swap Marked" s swap-window  Kill X kill-window Respawn R "respawn-window -k" "#{?pane_marked,Unmark,Mark}" m "select-pane -m" Rename n "command-prompt -I \"#W\" \"rename-window -- '%%'\""  "New After" w "new-window -a" "New At End" W new-window

# And these 2
# bind-key    -T root         MouseDown3StatusLeft  display-menu -T "#[align=centre]#{session_name}" -t = -x M -y S Next n "switch-client -n" Previous p "switch-client -p"  Renumber N "move-window -r" Rename n "command-prompt -I \"#S\" \"rename-session -- '%%'\""  "New Session" s new-session "New Window" w new-window

# bind-key    -T root         MouseDown3StatusRight display-menu -T "#[align=centre]#{client_name}" -t = -x M -y S Detach d detach-client "Detach & Kill" X "detach-client -P" "Detach Others" o "detach-client -a"  Lock l lock-client

bind-key    -T root         MouseDrag1Pane        if-shell -F -t = "#{mouse_any_flag}" "if -Ft= \"#{pane_in_mode}\" \"copy-mode -M\" \"send-keys -M\"" "copy-mode -M"

bind-key    -T root         MouseDrag1Border      resize-pane -M
bind-key    -T root         WheelUpPane           if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= \"#{pane_in_mode}\" \"send-keys -M\" \"copy-mode -et=\""

bind-key    -T root         WheelUpStatus         previous-window
bind-key    -T root         WheelDownStatus       next-window
bind-key    -T root         PPage                 copy-mode -eu

# So this is one of the ones that needs to be conditional
# bind-key    -T root         M-MouseDown3Pane      display-menu -T "#[align=centre]#{pane_index} (#{pane_id})" -t = -x M -y M "#{?mouse_word,Search For #[underscore]#{=/9/...:mouse_word},}" C-r "copy-mode -t=; send -Xt= search-backward \"#{q:mouse_word}\"" "#{?mouse_word,Type #[underscore]#{=/9/...:mouse_word},}" C-y "send-keys -l -- \"#{q:mouse_word}\"" "#{?mouse_word,Copy #[underscore]#{=/9/...:mouse_word},}" c "set-buffer -- \"#{q:mouse_word}\"" "#{?mouse_line,Copy Line,}" l "set-buffer -- \"#{q:mouse_line}\""  "Horizontal Split" h "split-window -h" "Vertical Split" v "split-window -v"  "Swap Up" u "swap-pane -U" "Swap Down" d "swap-pane -D" "#{?pane_marked_set,,-}Swap Marked" s swap-pane  Kill X kill-pane Respawn R "respawn-pane -k" "#{?pane_marked,Unmark,Mark}" m "select-pane -m" "#{?window_zoomed_flag,Unzoom,Zoom}" z "resize-pane -Z"

bind-key    -T root         S-F12                 source-file /data/data/com.termux/files/usr/share/byobu/keybindings/f-keys.tmux \; source-file /data/data/com.termux/files/home/.byobu/keybindings.tmux \; display-message "Byobu F-keys: ENABLED"

# Why? I dont know. Also raised on error on tmux 2
# display-message "Mouse: ON"
