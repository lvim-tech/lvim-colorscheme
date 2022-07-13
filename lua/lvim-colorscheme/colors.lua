local util = require("lvim-colorscheme.util")

local M = {}

function M.setup(config)
    config = config or require("lvim-colorscheme.config")
    local colors = {}
    colors = {
        none = "NONE",
        color_01 = "#242B30",
        color_02 = "#272F35",
        color_03 = "#2A3339",
        color_04 = "#364249",
        color_05 = "#415058",
        color_06 = "#4c5d67",
        color_07 = "#00839F",
        color_08 = "#1C9898",
        color_09 = "#2AA198",
        color_10 = "#20acac",
        color_11 = "#41a6b5",
        color_12 = "#609f9e",
        color_13 = "#70a9a8",
        color_14 = "#8fbcbb",
        color_15 = "#83a598",
        color_16 = "#90c1a3",
        color_17 = "#7cb692",
        color_18 = "#A7C080",
        color_19 = "#95b365",
        color_20 = "#f08628",
        color_21 = "#F2994B",
        color_22 = "#F2AF5C",
        color_23 = "#E6C068",
        color_24 = "#F05F4E",
        color_25 = "#f16a5b",
        git = { add = "#A7C080", change = "#F2AF5C", delete = "#F05F4E", conflict = "#E6C068" },
        gitSigns = { add = "#A7C080", change = "#F2AF5C", delete = "#F05F4E" },
    }
    colors.diff = {
        add = colors.color_18,
        change = colors.color_24,
        delete = colors.color_24,
        text = colors.color_05,
    }
    colors.gitSigns = {
        add = colors.gitSigns.add,
        change = colors.gitSigns.change,
        delete = colors.gitSigns.delete,
    }
    colors.git.ignore = colors.color_05
    colors.black = util.darken(colors.color_03, 0.5, "#161a1d")
    colors.border_highlight = colors.color_01
    colors.border = colors.black
    colors.bg_popup = util.darken(colors.color_01, 0.7, "#161a1d")
    colors.bg_statusline = util.darken(colors.color_01, 0.7, "#161a1d")
    colors.bg_sidebar = util.darken(colors.color_01, 0.7, "#161a1d")
    colors.bg_float = config.darkFloat and colors.color_01 or util.darken(colors.color_01, 0.7, "#161a1d")
    colors.bg_visual = colors.color_05
    colors.bg_search = colors.color_05
    colors.fg_sidebar = colors.color_22
    colors.success = colors.color_18
    colors.error = colors.color_24
    colors.warning = colors.color_22
    colors.info = colors.color_07
    colors.hint = colors.color_23
    util.color_overrides(colors, config)
    return colors
end

return M
