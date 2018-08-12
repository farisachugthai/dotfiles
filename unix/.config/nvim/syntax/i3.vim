if exists('b:current_syntax')
  finish
endif

syntax keyword i3Keyword bindsym bindcode exec

syntax keyword i3Action  exec exec_always focus set move split unmark
syntax keyword i3Action  show reload restart resize assign

syntax keyword i3Type    mode bar colors container scratchpad output window mark hidden_state
syntax keyword i3Type    parent child layout floating tiling border client width height

syntax keyword i3Repeat  for_window

syntax match   ExecCmd   "\(exec --no-startup-id \+\|exec \+\)\@<=.*" contains=i3Comment

" https://vi.stackexchange.com/questions/13062/exclude-start-and-end-match-from-region
syntax region  i3Params matchgroup=i3ParamsContents start='\[' end='\]' oneline contains=i3Param,i3ParamValue
syntax match   i3Param      /\v[A-z]+\=/ contained
syntax match   i3ParamValue /\v"[^"]+"/ contained

syntax keyword i3Keyword smart_borders new_window new_float workspace
syntax keyword i3Keyword workspace_auto_back_and_forth workspace_layout
syntax keyword i3Keyword status_command position font separator
syntax keyword i3Keyword background statusline separator_symbol
syntax keyword i3Keyword focused_workspace active_workspace
syntax keyword i3Keyword inactive_workspace urgent_workspace
syntax keyword i3Keyword mouse_warping floating_modifier px ppt ms
syntax keyword i3Keyword hide_edge_borders force_xinerama
syntax keyword i3Keyword force_display_urgency_hint focus_on_window_activation
syntax keyword i3Keyword default_orientation force_focus_wrapping
syntax keyword i3Keyword no_focus focus_follows_mouse popup_during_fullscreen
syntax keyword i3Keyword show_marks id tray_padding workspace_buttons
syntax keyword i3Keyword strip_workspace_numbers binding_mode_indicator
syntax keyword i3Keyword sticky title_format
syntax keyword i3Keyword shmlog debuglog nop

" TODO; 'unicode encoded arrow'

syntax keyword i3Function shrink grow

syntax keyword i3Boolean yes no on off none enable disable toggle mode_toggle
syntax keyword i3Boolean left right up down center
syntax keyword i3Boolean next_on_output prev_on_output
syntax keyword i3Boolean pango normal pixel top bottom
syntax keyword i3Boolean stacking tabbed fullscreen to or
syntax keyword i3Boolean horizontal vertical auto both
syntax keyword i3Boolean smart ignore leave_fullscreen
syntax keyword i3Boolean dock hide invisible splitv splith all
syntax keyword i3Boolean number prev next current back_and_forth
syntax match   i3Boolean "--no-startup-id"
syntax match   i3Boolean "--release"
syntax match   i3Boolean "--whole-window"
syntax match   i3Boolean "--toggle"

syntax match   i3Variable "\v\$[A-z0-9_]+"

syntax match   i3Number  "\v[0-9]+\: [A-z0-9]+"
syntax match   i3Number  "\v<[0-9]+>"
syntax match   i3Number  "\v[0-9]+: +[A-z0-9]+"

syntax match   i3Comment "\v#.*$"
syntax match   Colour    "\v#[A-Fa-f0-9]{6}"
 "
syntax region  i3String  start='"' end='"' oneline

syntax match   Font      "\(font pango: \|font \)\@<=.*$"
syntax match   KeyBind   "\(bindsym \)\@<=[^ ]\+"

syntax match   ClientType "\(client.\)\@<=[A-z]\+"

highlight default link i3Operator    Operator
highlight default link i3Keyword     Keyword
highlight default link i3Action      Function
highlight default link i3Repeat      Repeat
highlight default link i3Type        Type
highlight default link i3Function    Function
highlight default link i3Comment     Comment
highlight default link i3String      String
highlight default link i3Variable    Identifier
highlight default link i3Boolean     Boolean
highlight default link i3Number      Number
highlight default link ClientType    Boolean

highlight default link i3Param       Identifier
highlight default link i3ParamValue  String
highlight default link i3ParamsContents Normal

highlight default link ExecCmd       Default

highlight default link Font          String
highlight default link Colour        String
highlight default link KeyBind       Identifier

let b:current_syntax = 'i3'
