set -g mode-style "fg=#1c2125,bg=#ff9010"

set -g message-style "fg=#1c7060,bg=#181d1f"

set -g status-style "fg=#0974a1,bg=#181d1f"

setw -g window-status-style "fg=#8AA55F,bold,bg=#181d1f"
setw -g window-status-format " #I:#W "
setw -g window-status-current-style "fg=#1c2125,bold,bg=#8AA55F"
setw -g window-status-current-format " #I:#W "

setw -g window-status-activity-style "fg=#ff9010"

setw -g pane-border-style "fg=#7d9654"
setw -g pane-active-border-style "fg=#7d9654"

set -g status on
set -g status-interval 5
set -g status-position bottom
set -g status-justify left
set -g status-right-length 100

wg_session="#[bg=#8AA55F,bold,fg=#1c2125] #S #[default]"
wg_user_host="#[bg=#181d1f,bold,fg=#e65e4f] #(whoami)@#H"
wg_is_zoomed="#[fg=#181d1f,bg=#e65e4f]#{?window_zoomed_flag, ZOOM ,}#[default]"
wg_is_keys_off="#[fg=#1c2125,bg=#e65e4f]#([ $(tmux show-option -qv key-table) = 'off' ] && echo ' KEYS OFF ')#[default]"
wg_date="#[bg=#8AA55F,bold,fg=#1c2125] %h %d %H:%M #[default]"

set -g status-left "$wg_session"
set -g status-right "#{prefix_highlight} $wg_is_keys_off $wg_is_zoomed #{sysstat_cpu} | #{sysstat_mem} $wg_user_host #{online_status} $wg_date"

set -g @online_icon "#[fg=#8AA55F]●#[default]"
set -g @offline_icon "#[fg=#e34a39]●#[default]"

set -g @sysstat_mem_view_tmpl 'MEM:#[fg=#{mem.color}]#{mem.pused}#[default] #{mem.used}'

set -g @sysstat_cpu_color_low "#8AA55F"
set -g @sysstat_cpu_color_medium "#FF9C2A"
set -g @sysstat_cpu_color_stress "#e34a39"

set -g @sysstat_mem_color_low "#8AA55F"
set -g @sysstat_mem_color_medium "#FF9C2A"
set -g @sysstat_mem_color_stress "#e34a39"

set -g @prefix_highlight_output_prefix '['
set -g @prefix_highlight_output_suffix ']'
set -g @prefix_highlight_fg "#e65e4f,bold"
set -g @prefix_highlight_bg "#1c2125"
set -g @prefix_highlight_show_copy_mode 'on'
set -g @prefix_highlight_copy_mode_attr "fg=#e65e4f,bold,bg=#181d1f"
