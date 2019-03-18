# Emacs keys

# Emacs: {{{1

# Mar 08, 2019:
# Spent a little bit rereading things and just realized how much you lose by
# setting vim keybindings. But I want all the functionality! So
bind-key    -T copy-mode-vi   C-Space           send-keys -X begin-selection
bind-key    -T copy-mode-vi    C-g               send-keys -X clear-selection
bind-key    -T copy-mode-vi    C-n               send-keys -X cursor-down
bind-key    -T copy-mode-vi    C-p               send-keys -X cursor-up
bind-key    -T copy-mode-vi    C-r               command-prompt -i -I "#{pane_search_string}" -p "(search up)" "send -X search-backward-incremental \"%%%\""
bind-key    -T copy-mode-vi    C-s               command-prompt -i -I "#{pane_search_string}" -p "(search down)" "send -X search-forward-incremental \"%%%\""
bind-key    -T copy-mode-vi    C-v               send-keys -X page-down
bind-key    -T copy-mode-vi    C-w               send-keys -X copy-selection-and-cancel
bind-key    -T copy-mode-vi    ,                 send-keys -X jump-reverse
bind-key    -T copy-mode-vi    ;                 send-keys -X jump-again
bind-key    -T copy-mode-vi    F                 command-prompt -1 -p "(jump backward)" "send -X jump-backward \"%%%\""
bind-key    -T copy-mode-vi    N                 send-keys -X search-reverse
bind-key    -T copy-mode-vi    R                 send-keys -X rectangle-toggle
bind-key    -T copy-mode-vi    T                 command-prompt -1 -p "(jump to backward)" "send -X jump-to-backward \"%%%\""
bind-key    -T copy-mode-vi    f                 command-prompt -1 -p "(jump forward)" "send -X jump-forward \"%%%\""
bind-key    -T copy-mode-vi    g                 command-prompt -p "(goto line)" "send -X goto-line \"%%%\""
bind-key    -T copy-mode-vi    n                 send-keys -X search-again
bind-key    -T copy-mode-vi    t                 command-prompt -1 -p "(jump to forward)" "send -X jump-to-forward \"%%%\""
bind-key    -T copy-mode-vi    MouseDown1Pane    select-pane
bind-key    -T copy-mode-vi    MouseDrag1Pane    select-pane ; send-keys -X begin-selection
bind-key    -T copy-mode-vi    MouseDragEnd1Pane send-keys -X copy-selection-and-cancel
bind-key    -T copy-mode-vi    WheelUpPane       select-pane ; send-keys -X -N 5 scroll-up
bind-key    -T copy-mode-vi    WheelDownPane     select-pane ; send-keys -X -N 5 scroll-down
bind-key    -T copy-mode-vi    DoubleClick1Pane  select-pane ; send-keys -X select-word
bind-key    -T copy-mode-vi    TripleClick1Pane  select-pane ; send-keys -X select-line
bind-key    -T copy-mode-vi    Home              send-keys -X start-of-line
bind-key    -T copy-mode-vi    End               send-keys -X end-of-line
bind-key    -T copy-mode-vi    NPage             send-keys -X page-down
bind-key    -T copy-mode-vi    PPage             send-keys -X page-up
bind-key    -T copy-mode-vi    Up                send-keys -X cursor-up
bind-key    -T copy-mode-vi    Down              send-keys -X cursor-down
bind-key    -T copy-mode-vi    Left              send-keys -X cursor-left
bind-key    -T copy-mode-vi    Right             send-keys -X cursor-right
bind-key    -T copy-mode-vi    M-1               command-prompt -N -I 1 -p (repeat) "send -N \"%%%\""
bind-key    -T copy-mode-vi    M-2               command-prompt -N -I 2 -p (repeat) "send -N \"%%%\""
bind-key    -T copy-mode-vi    M-3               command-prompt -N -I 3 -p (repeat) "send -N \"%%%\""
bind-key    -T copy-mode-vi    M-4               command-prompt -N -I 4 -p (repeat) "send -N \"%%%\""
bind-key    -T copy-mode-vi    M-5               command-prompt -N -I 5 -p (repeat) "send -N \"%%%\""
bind-key    -T copy-mode-vi    M-6               command-prompt -N -I 6 -p (repeat) "send -N \"%%%\""
bind-key    -T copy-mode-vi    M-7               command-prompt -N -I 7 -p (repeat) "send -N \"%%%\""
bind-key    -T copy-mode-vi    M-8               command-prompt -N -I 8 -p (repeat) "send -N \"%%%\""
bind-key    -T copy-mode-vi    M-9               command-prompt -N -I 9 -p (repeat) "send -N \"%%%\""
bind-key    -T copy-mode-vi    M-<               send-keys -X history-top
bind-key    -T copy-mode-vi    M->               send-keys -X history-bottom
bind-key    -T copy-mode-vi    M-R               send-keys -X top-line
bind-key    -T copy-mode-vi    M-b               send-keys -X previous-word
bind-key    -T copy-mode-vi    M-f               send-keys -X next-word-end
bind-key    -T copy-mode-vi    M-m               send-keys -X back-to-indentation
bind-key    -T copy-mode-vi    M-r               send-keys -X middle-line
bind-key    -T copy-mode-vi    M-v               send-keys -X page-up
bind-key    -T copy-mode-vi    M-w               send-keys -X copy-selection-and-cancel
bind-key    -T copy-mode-vi    M-{               send-keys -X previous-paragraph
bind-key    -T copy-mode-vi    M-}               send-keys -X next-paragraph
bind-key    -T copy-mode-vi    M-Up              send-keys -X halfpage-up
bind-key    -T copy-mode-vi    M-Down            send-keys -X halfpage-down
bind-key    -T copy-mode-vi    C-Up              send-keys -X scroll-up
bind-key    -T copy-mode-vi    C-Down            send-keys -X scroll-down
