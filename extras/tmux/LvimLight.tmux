set -g mode-style "fg=#dfdfdf,bg=#b66400"

set -g message-style "fg=#2a9b86,bg=#dadada"

set -g status-style "fg=#0d8abf,bg=#dadada"

setw -g window-status-style "fg=#748c50,bold,bg=#dadada"
setw -g window-status-format " #I:#W "
setw -g window-status-current-style "fg=#dfdfdf,bold,bg=#748c50"
setw -g window-status-current-format " #I:#W "

setw -g window-status-activity-style "fg=#b66400"

setw -g pane-border-style "fg=#556738"
setw -g pane-active-border-style "fg=#556738"

set -g status on
set -g status-interval 5
set -g status-position bottom
set -g status-justify left
set -g status-right-length 100

wg_session="#[bg=#748c50,bold,fg=#dfdfdf] #S #[default]"
wg_user_host="#[bg=#dadada,bold,fg=#ac4135] #(whoami)@#H"
wg_is_zoomed="#[fg=#dadada,bg=#ac4135]#{?window_zoomed_flag, ZOOM ,}#[default]"
wg_is_keys_off="#[fg=#dfdfdf,bg=#ac4135]#([ $(tmux show-option -qv key-table) = 'off' ] && echo ' KEYS OFF ')#[default]"
wg_date="#[bg=#748c50,bold,fg=#dfdfdf] %h %d %H:%M #[default]"

set -g status-left "$wg_session"
set -g status-right "#{prefix_highlight} $wg_is_keys_off $wg_is_zoomed #{sysstat_cpu} | #{sysstat_mem} $wg_user_host #{online_status} $wg_date"

set -g @online_icon "#[fg=#748c50]●#[default]"
set -g @offline_icon "#[fg=#c53f30]●#[default]"

set -g @sysstat_mem_view_tmpl 'MEM:#[fg=#{mem.color}]#{mem.pused}#[default] #{mem.used}'

set -g @sysstat_cpu_color_low "#748c50"
set -g @sysstat_cpu_color_medium "#a96400"
set -g @sysstat_cpu_color_stress "#c53f30"

set -g @sysstat_mem_color_low "#748c50"
set -g @sysstat_mem_color_medium "#a96400"
set -g @sysstat_mem_color_stress "#c53f30"

set -g @prefix_highlight_output_prefix '['
set -g @prefix_highlight_output_suffix ']'
set -g @prefix_highlight_fg "#ac4135,bold"
set -g @prefix_highlight_bg "#dfdfdf"
set -g @prefix_highlight_show_copy_mode 'on'
set -g @prefix_highlight_copy_mode_attr "fg=#ac4135,bold,bg=#dadada"
