-- lvim-colorscheme.extra.bottom: generate the [styles] block of a bottom
-- config from the palette.
--
--     mkdir -p ~/.config/bottom
--     ln -sf .../extras/bottom/LvimNord_dark.toml ~/.config/bottom/bottom.toml
--
-- Only [styles.*] is written: bottom's behaviour keys (widget layout,
-- refresh rate, process defaults) keep their defaults rather than being
-- frozen by a colour scheme. `theme =` is deliberately absent — naming a
-- built-in theme there would take precedence over these colours.
--
---@module "lvim-colorscheme.extra.system.bottom"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    -- bottom writes no background of its own, so its text sits on the TERMINAL's — which this
    -- project themes from the same palette, making `terminal.background` the honest surface rather
    -- than a guess. Every colour below that names a legend, a header, a title or a row of text is
    -- floored against it.
    --
    -- `graph_color`, `border_color` and `selected_border_color` are NOT: a graph line and a widget
    -- frame are drawn, not read, and `graph_color` is deliberately `comment` so the plotted line
    -- stays behind the numbers written over it.
    local term = colors.terminal.background
    local function text(hex)
        return util.ensure_contrast(hex, term, 4.5)
    end
    -- The selected row is the one place bottom paints a surface and puts words on it, so the text
    -- is chosen from the two the theme has and the surface gives a step of lightness only if that
    -- still cannot reach the floor.
    local sel_fg = util.readable_on(colors.blue, colors.bg_dark)
    local t = vim.tbl_extend("force", colors, {
        b_fg = text(colors.fg), b_magenta = text(colors.magenta), b_blue = text(colors.blue),
        b_green = text(colors.green), b_yellow = text(colors.yellow), b_orange = text(colors.orange),
        b_purple = text(colors.purple), b_teal = text(colors.teal), b_cyan = text(colors.cyan),
        b_red = text(colors.red), b_green_dark = text(colors.green_dark),
        b_magenta_dark = text(colors.magenta_dark), b_fg_dark = text(colors.fg_dark),
        b_fg_light = text(colors.fg_light), b_comment = text(colors.comment),
        b_sel_fg = sel_fg,
        b_sel_bg = util.ensure_contrast(colors.blue, sel_fg, 4.5),
    })
    return util.template(
        [[
# ${_style_name}

[styles.cpu]
all_entry_color = "${b_fg}"
avg_entry_color = "${b_magenta}"
cpu_core_colors = ["${b_blue}", "${b_green}", "${b_yellow}", "${b_orange}", "${b_purple}", "${b_teal}", "${b_cyan}", "${b_red}"]

[styles.memory]
ram_color = "${b_green}"
cache_color = "${b_cyan}"
swap_color = "${b_orange}"
arc_color = "${b_teal}"

[styles.network]
rx_color = "${b_green}"
tx_color = "${b_magenta}"
rx_total_color = "${b_green_dark}"
tx_total_color = "${b_magenta_dark}"

[styles.battery]
high_battery_color = "${b_green}"
medium_battery_color = "${b_yellow}"
low_battery_color = "${b_red}"

[styles.tables]
headers = { color = "${b_blue}", bold = true }

[styles.graphs]
graph_color = "${comment}"
legend_text = "${b_fg_dark}"

[styles.widgets]
border_color = "${bg_light}"
selected_border_color = "${blue}"
widget_title = { color = "${b_fg_light}", bold = true }
text = "${b_fg}"
selected_text = { color = "${b_sel_fg}", bg_color = "${b_sel_bg}" }
disabled_text = "${b_comment}"
]],
        t
    )
end

return M
