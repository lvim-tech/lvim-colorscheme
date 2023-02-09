local utils = require("lvim-colorscheme.utils")

local colors = {
    NONE = "NONE",
    bg_01 = "#1a2126",
    bg_02 = "#1b2227",
    bg_03 = "#1d252a",
    bg_04 = "#313d44",
    bg_05 = "#3c4b53",
    bg_06 = "#475862",
    fg_01 = "#97b9ac",
    fg_02 = "#83A598",
    fg_03 = "#6f9184",
    fg_04 = "#70A9A8",
    fg_05 = "#90C1A3",
    fg_06 = "#7CB692",
    blue_01 = "#32ade1",
    blue_02 = "#1e99cd",
    blue_03 = "#0a85b9",
    teal_01 = "#2ab198",
    teal_02 = "#169d84",
    teal_03 = "#028970",
    cyan_01 = "#00acc1",
    cyan_02 = "#0098ad",
    cyan_03 = "#008499",
    green_01 = "#A7C080",
    green_02 = "#93ac6c",
    green_03 = "#7f9858",
    red_01 = "#F16A5B",
    red_02 = "#dd5647",
    red_03 = "#c94233",
    orange_01 = "#ffae50",
    orange_02 = "#ff9a3c",
    orange_03 = "#F08628",
    git = { add = "#93ac6c", change = "#ff9a3c", delete = "#dd5647", conflict = "#ff9a3c", ignore = "#0098ad" },
    gitSigns = {
        add = "#93ac6c",
        change = "#ff9a3c",
        change_delete = "#dc7214",
        delete = "#dd5647",
        top_delete = "#b52e1f",
        untracked = "#0a85b9",
    },
    diff = { add = "#323926", change = "#48341B", delete = "#481C17", text = "#242B30" },
}
colors.success = colors.green_02
colors.error = colors.red_02
colors.warning = colors.orange_02
colors.info = colors.blue_02
colors.hint = colors.teal_02
colors.bg_sidebar = utils.darken(colors.bg_01, 0.7, "#141414")
colors.bg_statusline = utils.darken(colors.bg_01, 0.7, "#141414")
colors.bg_popup = utils.darken(colors.bg_01, 0.7, "#141414")
colors.bg_float = utils.darken(colors.bg_01, 0.7, "#141414")
colors.bg_visual = colors.bg_05
colors.bg_search = colors.bg_05
colors.bg_cursor_line = utils.darken(colors.bg_04, 0.7, "#141414")
colors.fg_sidebar = colors.orange_02

return colors
