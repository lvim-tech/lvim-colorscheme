-- lvim-colorscheme.extra.trippy: generate the [theme-colors] block of a
-- trippy config from the palette.
--
--     mkdir -p ~/.config/trippy
--     ln -sf .../extras/trippy/LvimNord_dark.toml ~/.config/trippy/trippy.toml
--
-- Hex here carries NO leading '#': trippy's parser wants exactly six hex
-- digits and rejects the '#' form outright.
--
-- Only the colours are written; trippy's probing and TUI behaviour keep their
-- defaults (`trip --print-config-template` prints the full set if you want to
-- keep options alongside).
--
---@module "lvim-colorscheme.extra.network.trippy"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    local bare = {}
    for k, v in pairs(colors) do
        bare[k] = type(v) == "string" and v:gsub("^#", "") or v
    end
    return util.template(
        [[
# ${_style_name}
[theme-colors]
bg-color = "${bg_dark}"
border-color = "${bg_light}"
text-color = "${fg}"
tab-text-color = "${magenta}"
hops-table-header-bg-color = "${bg_highlight}"
hops-table-header-text-color = "${fg_light}"
hops-table-row-active-text-color = "${green}"
hops-table-row-inactive-text-color = "${comment}"
hops-chart-selected-color = "${green}"
hops-chart-unselected-color = "${comment}"
hops-chart-axis-color = "${bg_light}"
frequency-chart-bar-color = "${cyan}"
frequency-chart-text-color = "${fg}"
flows-chart-bar-selected-color = "${green}"
flows-chart-bar-unselected-color = "${bg_light}"
flows-chart-text-current-color = "${fg_light}"
flows-chart-text-non-current-color = "${comment}"
samples-chart-color = "${green}"
samples-chart-lost-color = "${red}"
help-dialog-bg-color = "${bg}"
help-dialog-text-color = "${fg}"
settings-dialog-bg-color = "${bg}"
settings-tab-text-color = "${magenta}"
settings-table-header-text-color = "${fg_light}"
settings-table-header-bg-color = "${bg_highlight}"
settings-table-row-text-color = "${fg}"
map-world-color = "${bg_light}"
map-radius-color = "${yellow}"
map-selected-color = "${green}"
map-info-panel-border-color = "${bg_light}"
map-info-panel-bg-color = "${bg}"
map-info-panel-text-color = "${fg}"
info-bar-bg-color = "${bg_highlight}"
info-bar-text-color = "${fg}"
]],
        bare
    )
end

return M
