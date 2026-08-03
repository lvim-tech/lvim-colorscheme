-- lvim-colorscheme.extra.tmux: generate a Tmux theme/colour config from the lvim-colorscheme palette.
--
---@module "lvim-colorscheme.extra.tmux"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    -- Colours only. The status bar LAYOUT this used to carry (status-position,
    -- the wg_* widgets, status-left/right, prefix_highlight punctuation) lives
    -- in tmux.conf, which reads the palette through the thm_* variables below —
    -- tmux keeps config variables in the server environment, so a file sourced
    -- later sees what an earlier one set. Both live paths (config.sh and
    -- themer) source the theme first, tmux.conf second.
    local tmux = util.template(
        [[
# Palette for the layout in tmux.conf.
thm_bg="${bg}"
thm_bg_dark="${bg_dark}"
thm_bg_soft_dark="${bg_soft_dark}"
thm_fg="${fg}"
thm_green="${green}"
thm_green_dark="${green_dark}"
thm_red="${red}"
thm_red_dark="${red_dark}"
thm_orange="${orange}"
thm_orange_dark="${orange_dark}"
thm_blue_dark="${blue_dark}"
thm_teal_dark="${teal_dark}"

set -g mode-style "fg=${bg_soft_dark},bg=${orange_dark}"

set -g message-style "fg=${teal_dark},bg=${bg_dark}"

set -g status-style "fg=${blue_dark},bg=${bg_dark}"

setw -g window-status-style "fg=${green},bold,bg=${bg_dark}"
setw -g window-status-current-style "fg=${bg_soft_dark},bold,bg=${green}"
setw -g window-status-activity-style "fg=${orange_dark}"

setw -g pane-border-style "fg=${green_dark}"
setw -g pane-active-border-style "fg=${green_dark}"

set -g @sysstat_cpu_color_low "${green}"
set -g @sysstat_cpu_color_medium "${orange}"
set -g @sysstat_cpu_color_stress "${red_dark}"

set -g @sysstat_mem_color_low "${green}"
set -g @sysstat_mem_color_medium "${orange}"
set -g @sysstat_mem_color_stress "${red_dark}"

set -g @prefix_highlight_fg "${red},bold"
set -g @prefix_highlight_bg "${bg_soft_dark}"
set -g @prefix_highlight_copy_mode_attr "fg=${red},bold,bg=${bg_dark}"
]],
        colors
    )
    return tmux
end

return M
