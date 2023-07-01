local utils = require("lvim-colorscheme.utils")

local colors = {
    NONE = "NONE",
    white = "#FFFFFF",
    bg = "#E4E4E4",
    bg_01 = "#FFFFFF",
    bg_02 = "#F5F5F5",
    bg_03 = "#EBEBEB",
    bg_04 = "#E1E1E1",
    bg_05 = "#D7D7D7",
    bg_06 = "#BBBBBB",
    fg_01 = "#6F9184",
    fg_02 = "#5B7D70",
    fg_03 = "#7B9D90",
    fg_04 = "#488180",
    fg_05 = "#5E8F71",
    fg_06 = "#4A8460",
    fg_07 = "#448589",
    blue_01 = "#28A3D7",
    blue_02 = "#148FC3",
    blue_03 = "#007BAF",
    teal_01 = "#2AB198",
    teal_02 = "#169D84",
    teal_03 = "#028970",
    cyan_01 = "#00ACC1",
    cyan_02 = "#0098AD",
    cyan_03 = "#008499",
    green_01 = "#7F9858",
    green_02 = "#6B8444",
    green_03 = "#577030",
    red_01 = "#C94233",
    red_02 = "#B52E1F",
    red_03 = "#A11A0B",
    orange_01 = "#F08628",
    orange_02 = "#DC7214",
    orange_03 = "#C85E00",
    git = { add = "#7F9858", change = "#DC7214", delete = "#C94233", conflict = "#DC7214", ignore = "#008499" },
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
