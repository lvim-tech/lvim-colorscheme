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
    -- trippy paints its own surfaces, and there are three of them: `bg-color` (the panel),
    -- `bg` (the help and settings dialogs and the map panel) and `bg_highlight` (the table header
    -- and the info bar). Each text colour is floored against the one it is actually written on —
    -- measured beforehand, `hops-table-row-inactive-text-color` read at 1.94:1 and the ordinary
    -- `text-color` at 2.09:1 on their own panel.
    --
    -- The chart and map colours are NOT floored: `hops-chart-*`, `frequency-chart-bar-color`,
    -- `flows-chart-bar-*`, `samples-chart-*`, `map-world-color`, `map-radius-color`,
    -- `map-selected-color`, `hops-chart-axis-color` and every `border-color` draw a bar, an axis, a
    -- coastline or a frame. Nothing is read against them.
    local function text(hex, bg)
        return util.ensure_contrast(hex, bg, 4.5)
    end
    local panel, dialog, header = colors.bg_dark, colors.bg, colors.bg_highlight
    local derived = vim.tbl_extend("force", colors, {
        t_text = text(colors.fg, panel),
        t_tab = text(colors.magenta, panel),
        t_header_text = text(colors.fg_light, header),
        t_row_active = text(colors.green, panel),
        t_row_inactive = text(colors.comment, panel),
        t_freq_text = text(colors.fg, panel),
        t_flow_current = text(colors.fg_light, panel),
        t_flow_other = text(colors.comment, panel),
        t_dialog_text = text(colors.fg, dialog),
        t_settings_tab = text(colors.magenta, dialog),
        t_settings_header = text(colors.fg_light, header),
        t_settings_row = text(colors.fg, dialog),
        t_map_text = text(colors.fg, dialog),
        t_bar_text = text(colors.fg, header),
    })
    local bare = {}
    for k, v in pairs(derived) do
        bare[k] = type(v) == "string" and v:gsub("^#", "") or v
    end
    return util.template(
        [[
# ${_style_name}
[theme-colors]
bg-color = "${bg_dark}"
border-color = "${bg_light}"
text-color = "${t_text}"
tab-text-color = "${t_tab}"
hops-table-header-bg-color = "${bg_highlight}"
hops-table-header-text-color = "${t_header_text}"
hops-table-row-active-text-color = "${t_row_active}"
hops-table-row-inactive-text-color = "${t_row_inactive}"
hops-chart-selected-color = "${green}"
hops-chart-unselected-color = "${comment}"
hops-chart-axis-color = "${bg_light}"
frequency-chart-bar-color = "${cyan}"
frequency-chart-text-color = "${t_freq_text}"
flows-chart-bar-selected-color = "${green}"
flows-chart-bar-unselected-color = "${bg_light}"
flows-chart-text-current-color = "${t_flow_current}"
flows-chart-text-non-current-color = "${t_flow_other}"
samples-chart-color = "${green}"
samples-chart-lost-color = "${red}"
help-dialog-bg-color = "${bg}"
help-dialog-text-color = "${t_dialog_text}"
settings-dialog-bg-color = "${bg}"
settings-tab-text-color = "${t_settings_tab}"
settings-table-header-text-color = "${t_settings_header}"
settings-table-header-bg-color = "${bg_highlight}"
settings-table-row-text-color = "${t_settings_row}"
map-world-color = "${bg_light}"
map-radius-color = "${yellow}"
map-selected-color = "${green}"
map-info-panel-border-color = "${bg_light}"
map-info-panel-bg-color = "${bg}"
map-info-panel-text-color = "${t_map_text}"
info-bar-bg-color = "${bg_highlight}"
info-bar-text-color = "${t_bar_text}"
]],
        bare
    )
end

return M
