local utils = require("lvim-colorscheme.utils")
vim.opt.background = "dark"
local colors = {
    NONE = "NONE",
    white = "#FFFFFF",
    corection = "#141420",
    bg = "#191B25", -- +2
    bg_01 = "#1D1F2B", -- base
    bg_02 = "#1F212E", -- -1
    bg_03 = "#212331", -- -1
    bg_04 = "#3A3D56", -- -12
    bg_05 = "#444865", -- -5
    bg_06 = "#4F5374", -- -5
    bg_07 = "#595D84", -- -5
    fg_01 = "#B5BFE2",
    fg_02 = "#A5ADCE",
    fg_03 = "#949CBB",
    fg_04 = "#838BA7",
    fg_05 = "#4d6263",
    fg_06 = "#626880",
    fg_07 = "#448589",
    blue_01 = "#0C97D3",
    blue_02 = "#0B8EC6",
    blue_03 = "#0A85B9",
    teal_01 = "#02A384",
    teal_02 = "#02967A",
    teal_03 = "#028970",
    cyan_01 = "#019AB3",
    cyan_02 = "#018FA6",
    cyan_03 = "#018499",
    green_01 = "#95B266",
    green_02 = "#8AA55F",
    green_03 = "#7F9858",
    red_01 = "#E34A39",
    red_02 = "#D64636",
    red_03 = "#C94233",
    orange_01 = "#FF9C2A",
    orange_02 = "#F29428",
    orange_03 = "#E58C26",
    git = {
        add = "#93AC6C",
        change = "#FF9A3C",
        delete = "#DD5647",
        conflict = "#FF9A3C",
        ignore = "#0098AD",
    },
    gitSigns = {
        add = "#93AC6C",
        change = "#FF9A3C",
        change_delete = "#DC7214",
        delete = "#DD5647",
        top_delete = "#B52E1F",
        untracked = "#0A85B9",
    },
    diff = { add = "#323926", change = "#48341B", delete = "#481C17", text = "#242B30" },
}
colors.success = colors.green_02
colors.error = colors.red_02
colors.warning = colors.orange_02
colors.info = colors.blue_02
colors.hint = colors.teal_02
colors.bg_sidebar = utils.darken(colors.bg_01, 0.7, colors.corection)
colors.bg_statusline = utils.darken(colors.bg_01, 0.7, colors.corection)
colors.bg_popup = utils.darken(colors.bg_01, 0.7, colors.corection)
colors.bg_float = utils.darken(colors.bg_01, 0.7, colors.corection)
colors.bg_visual = utils.darken(colors.bg_04, 0.6, colors.corection)
colors.bg_search = utils.darken(colors.bg_05, 0.6, colors.corection)
colors.bg_cursor_line = utils.darken(colors.bg_04, 0.6, colors.corection)
colors.fg_sidebar = colors.orange_02

return colors
