set -g mode-style "fg=#1b1c21,bg=#c68f58"

set -g message-style "fg=#4b869b,bg=#17181c"

set -g status-style "fg=#4a6494,bg=#17181c"

setw -g window-status-style "fg=#6e8156,bold,bg=#17181c"
setw -g window-status-format " #I:#W "
setw -g window-status-current-style "fg=#1b1c21,bold,bg=#6e8156"
setw -g window-status-current-format " #I:#W "

setw -g window-status-activity-style "fg=#c68f58"

setw -g pane-border-style "fg=#697b52"
setw -g pane-active-border-style "fg=#697b52"

set -g status on
set -g status-interval 5
set -g status-position bottom
set -g status-justify left
set -g status-right-length 100

wg_session="#[bg=#6e8156,bold,fg=#1b1c21] #S #[default]"
wg_user_host="#[bg=#17181c,bold,fg=#b65252] #(whoami)@#H"
wg_is_zoomed="#[fg=#17181c,bg=#b65252]#{?window_zoomed_flag, ZOOM ,}#[default]"
wg_is_keys_off="#[fg=#1b1c21,bg=#b65252]#([ $(tmux show-option -qv key-table) = 'off' ] && echo ' KEYS OFF ')#[default]"
wg_date="#[bg=#6e8156,bold,fg=#1b1c21] %h %d %H:%M #[default]"

set -g status-left "$wg_session"
set -g status-right "#{prefix_highlight} $wg_is_keys_off $wg_is_zoomed #{sysstat_cpu} | #{sysstat_mem} $wg_user_host #{online_status} $wg_date"

set -g @online_icon "#[fg=#6e8156]●#[default]"
set -g @offline_icon "#[fg=#b24b4b]●#[default]"

set -g @sysstat_mem_view_tmpl 'MEM:#[fg=#{mem.color}]#{mem.pused}#[default] #{mem.used}'

set -g @sysstat_cpu_color_low "#6e8156"
set -g @sysstat_cpu_color_medium "#c99460"
set -g @sysstat_cpu_color_stress "#b24b4b"

set -g @sysstat_mem_color_low "#6e8156"
set -g @sysstat_mem_color_medium "#c99460"
set -g @sysstat_mem_color_stress "#b24b4b"

set -g @prefix_highlight_output_prefix '['
set -g @prefix_highlight_output_suffix ']'
set -g @prefix_highlight_fg "#b65252,bold"
set -g @prefix_highlight_bg "#1b1c21"
set -g @prefix_highlight_show_copy_mode 'on'
set -g @prefix_highlight_copy_mode_attr "fg=#b65252,bold,bg=#17181c"
