local utils = require("lvim-colorscheme.utils")

local colors = {
    NONE = "NONE",
    bg_01 = "#1f262b",
    bg_02 = "#20272c",
    bg_03 = "#222a2f",
    bg_04 = "#364249",
    bg_05 = "#415058",
    bg_06 = "#4C5D67",
    fg_01 = "#97b9ac",
    fg_02 = "#83A598",
    fg_03 = "#6f9184",
    fg_04 = "#70A9A8",
    fg_05 = "#90C1A3",
    fg_06 = "#7CB692",
    blue_01 = "#28a3d7",
    blue_02 = "#148fc3",
    blue_03 = "#007baf",
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
    git = { add = "#A7C080", change = "#F2AF5C", delete = "#F05F4E", conflict = "#F2994B", ignore = "#008499" },
    gitSigns = { add = "#A7C080", change = "#F2AF5C", delete = "#F05F4E" },
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
