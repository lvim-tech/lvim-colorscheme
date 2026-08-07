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
    -- Every `fg=X,bg=Y` below names both sides, so each foreground is floored against the exact
    -- surface it is written on rather than against a guess. Measured beforehand, the status line
    -- read at 2.26:1 (`blue_dark` on `bg_dark`) and the message line at 2.27:1.
    --
    -- The `thm_*` variables are NOT floored, and that is deliberate: tmux.conf reads them to build
    -- the status line's own layout, and it uses them on both sides -- `thm_green` is the text of an
    -- inactive window and the background of the active one. Lifting them here would repaint that
    -- background to fix text whose surface this file cannot see. The same reasoning as waybar's
    -- accents. `pane-border-style` draws a frame, and `@sysstat_*` and `@prefix_highlight_*` are
    -- read by plugins with surfaces of their own. `@prefix_highlight_*` is the exception among
    -- those: it names BOTH sides right here -- the indicator's red on `bg_soft_dark`, and its
    -- copy-mode variant on `bg_dark` -- and the word "prefix" is read off it, so both are floored.
    local function text(hex, bg)
        return util.ensure_contrast(hex, bg, 4.5)
    end
    local t = vim.tbl_extend("force", colors, {
        -- Copy-mode's strip is an accent with words on it, so the text is CHOSEN from the two the
        -- theme has rather than walked toward one. Walking was tried and it fails here: the strip
        -- is `orange_dark`, which sits mid-luminance on every palette, and `ensure_contrast` picks
        -- its direction once from `luminance(bg) < 0.5` -- so it climbed toward white and stopped
        -- at **2.68:1** on solarized_soft while the other pole was available all along.
        tm_mode = util.readable_on(colors.orange_dark, colors.bg_soft_dark),
        tm_mode_bg = util.ensure_contrast(
            colors.orange_dark, util.readable_on(colors.orange_dark, colors.bg_soft_dark), 4.5
        ),
        tm_message = text(colors.teal_dark, colors.bg_dark),
        tm_status = text(colors.blue_dark, colors.bg_dark),
        tm_window = text(colors.green, colors.bg_dark),
        tm_window_current = util.readable_on(colors.green, colors.bg_soft_dark),
        tm_window_current_bg = util.ensure_contrast(
            colors.green, util.readable_on(colors.green, colors.bg_soft_dark), 4.5
        ),
        tm_prefix = text(colors.red, colors.bg_soft_dark),
        tm_prefix_copy = text(colors.red, colors.bg_dark),
    })
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

set -g mode-style "fg=${tm_mode},bg=${tm_mode_bg}"

set -g message-style "fg=${tm_message},bg=${bg_dark}"

set -g status-style "fg=${tm_status},bg=${bg_dark}"

setw -g window-status-style "fg=${tm_window},bold,bg=${bg_dark}"
setw -g window-status-current-style "fg=${tm_window_current},bold,bg=${tm_window_current_bg}"
setw -g window-status-activity-style "fg=${orange_dark}"

setw -g pane-border-style "fg=${green_dark}"
setw -g pane-active-border-style "fg=${green_dark}"

set -g @sysstat_cpu_color_low "${green}"
set -g @sysstat_cpu_color_medium "${orange}"
set -g @sysstat_cpu_color_stress "${red_dark}"

set -g @sysstat_mem_color_low "${green}"
set -g @sysstat_mem_color_medium "${orange}"
set -g @sysstat_mem_color_stress "${red_dark}"

set -g @prefix_highlight_fg "${tm_prefix},bold"
set -g @prefix_highlight_bg "${bg_soft_dark}"
set -g @prefix_highlight_copy_mode_attr "fg=${tm_prefix_copy},bold,bg=${bg_dark}"
]],
        t
    )
    return tmux
end

return M
