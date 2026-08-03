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
    return util.template(
        [[
# ${_style_name}

[styles.cpu]
all_entry_color = "${fg}"
avg_entry_color = "${magenta}"
cpu_core_colors = ["${blue}", "${green}", "${yellow}", "${orange}", "${purple}", "${teal}", "${cyan}", "${red}"]

[styles.memory]
ram_color = "${green}"
cache_color = "${cyan}"
swap_color = "${orange}"
arc_color = "${teal}"

[styles.network]
rx_color = "${green}"
tx_color = "${magenta}"
rx_total_color = "${green_dark}"
tx_total_color = "${magenta_dark}"

[styles.battery]
high_battery_color = "${green}"
medium_battery_color = "${yellow}"
low_battery_color = "${red}"

[styles.tables]
headers = { color = "${blue}", bold = true }

[styles.graphs]
graph_color = "${comment}"
legend_text = "${fg_dark}"

[styles.widgets]
border_color = "${bg_light}"
selected_border_color = "${blue}"
widget_title = { color = "${fg_light}", bold = true }
text = "${fg}"
selected_text = { color = "${bg_dark}", bg_color = "${blue}" }
disabled_text = "${comment}"
]],
        colors
    )
end

return M
