local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
  local tmux = util.template(
    [[
set -g mode-style "fg=${bg_soft_dark},bg=${orange_dark}"

set -g message-style "fg=${teal_dark},bg=${bg_dark}"

set -g status-style "fg=${blue_dark},bg=${bg_dark}"

setw -g window-status-style "fg=${green},bold,bg=${bg_dark}"
setw -g window-status-format " #I:#W "
setw -g window-status-current-style "fg=${bg_soft_dark},bold,bg=${green}"
setw -g window-status-current-format " #I:#W "

setw -g window-status-activity-style "fg=${orange_dark}"

setw -g pane-border-style "fg=${green_dark}"
setw -g pane-active-border-style "fg=${green_dark}"

set -g status on
set -g status-interval 5
set -g status-position bottom
set -g status-justify left
set -g status-right-length 100

wg_session="#[bg=${green},bold,fg=${bg_soft_dark}] #S #[default]"
wg_user_host="#[bg=${bg_dark},bold,fg=${red}] #(whoami)@#H"
wg_is_zoomed="#[fg=${bg_dark},bg=${red}]#{?window_zoomed_flag, ZOOM ,}#[default]"
wg_is_keys_off="#[fg=${bg_soft_dark},bg=${red}]#([ $(tmux show-option -qv key-table) = 'off' ] && echo ' KEYS OFF ')#[default]"
wg_date="#[bg=${green},bold,fg=${bg_soft_dark}] %h %d %H:%M #[default]"

set -g status-left "$wg_session"
set -g status-right "#{prefix_highlight} $wg_is_keys_off $wg_is_zoomed #{sysstat_cpu} | #{sysstat_mem} $wg_user_host #{online_status} $wg_date"

set -g @online_icon "#[fg=${green}]●#[default]"
set -g @offline_icon "#[fg=${red_dark}]●#[default]"

set -g @sysstat_mem_view_tmpl 'MEM:#[fg=#{mem.color}]#{mem.pused}#[default] #{mem.used}'

set -g @sysstat_cpu_color_low "${green}"
set -g @sysstat_cpu_color_medium "${orange}"
set -g @sysstat_cpu_color_stress "${red_dark}"

set -g @sysstat_mem_color_low "${green}"
set -g @sysstat_mem_color_medium "${orange}"
set -g @sysstat_mem_color_stress "${red_dark}"

set -g @prefix_highlight_output_prefix '['
set -g @prefix_highlight_output_suffix ']'
set -g @prefix_highlight_fg "${red},bold"
set -g @prefix_highlight_bg "${bg_soft_dark}"
set -g @prefix_highlight_show_copy_mode 'on'
set -g @prefix_highlight_copy_mode_attr "fg=${red},bold,bg=${bg_dark}"
]], colors)
  return tmux
end

return M
