local utils = require("lvim-colorscheme.utils")

local colors = {
    NONE = "NONE",
    bg_01 = "#FFFFFF",
    bg_02 = "#f5f5f5",
    bg_03 = "#ebebeb",
    bg_04 = "#e1e1e1",
    bg_05 = "#d7d7d7",
    bg_06 = "#bbbbbb",
    fg_01 = "#6f9184",
    fg_02 = "#5b7d70",
    fg_03 = "#7b9d90",
    fg_04 = "#488180",
    fg_05 = "#5e8f71",
    fg_06 = "#4a8460",
    blue_01 = "#28a3d7",
    blue_02 = "#148fc3",
    blue_03 = "#007baf",
    teal_01 = "#2ab198",
    teal_02 = "#169d84",
    teal_03 = "#028970",
    cyan_01 = "#00acc1",
    cyan_02 = "#0098ad",
    cyan_03 = "#008499",
    green_01 = "#7f9858",
    green_02 = "#6b8444",
    green_03 = "#577030",
    red_01 = "#c94233",
    red_02 = "#b52e1f",
    red_03 = "#a11a0b",
    orange_01 = "#f08628",
    orange_02 = "#dc7214",
    orange_03 = "#c85e00",
    git = { add = "#7f9858", change = "#dc7214", delete = "#c94233", conflict = "#dc7214", ignore = "#008499" },
    gitSigns = {
        add = "#93ac6c",
        change = "#ff9a3c",
        change_delete = "#dc7214",
        delete = "#dd5647",
        top_delete = "#b52e1f",
        untracked = "#0a85b9",
    },
    diff = { add = "#323926", change = "#48341B", delete = "#481C17", text = "#f5f5f5" },
}
colors.success = colors.green_02
colors.error = colors.red_02
colors.warning = colors.orange_02
colors.info = colors.blue_02
colors.hint = colors.teal_02
colors.bg_sidebar = utils.darken(colors.bg_01, 0.6, "#bababa")
colors.bg_statusline = utils.darken(colors.bg_01, 0.6, "#bababa")
colors.bg_popup = utils.darken(colors.bg_01, 0.6, "#bababa")
colors.bg_float = utils.darken(colors.bg_01, 0.6, "#bababa")
colors.bg_visual = utils.darken(colors.bg_05, 0.4, "#bababa")
colors.bg_search = utils.darken(colors.bg_05, 0.4, "#bababa")
colors.bg_cursor_line = utils.darken(colors.bg_01, 0.5, "#bababa")
colors.fg_sidebar = colors.orange_02

return colors
