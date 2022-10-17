local util = require("lvim-colorscheme.util")

local M = {}

M.default = {
    none = "NONE",
    color_01 = "#242B30",
    color_02 = "#272F35",
    color_03 = "#2A3339",
    color_04 = "#364249",
    color_05 = "#415058",
    color_06 = "#4C5D67",
    color_07 = "#00839F",
    color_08 = "#1C9898",
    color_09 = "#2AA198",
    color_10 = "#20ACAC",
    color_11 = "#41A6B5",
    color_12 = "#609F9E",
    color_13 = "#70A9A8",
    color_14 = "#8fBCBB",
    color_15 = "#83A598",
    color_16 = "#90C1A3",
    color_17 = "#7CB692",
    color_18 = "#A7C080",
    color_19 = "#95B365",
    color_20 = "#F08628",
    color_21 = "#F2994B",
    color_22 = "#F2AF5C",
    color_23 = "#E6C068",
    color_24 = "#F05F4E",
    color_25 = "#F16A5B",
    git = { add = "#A7C080", change = "#F2AF5C", delete = "#F05F4E", conflict = "#F2994B", ignore = "#2AA198" },
    gitSigns = { add = "#A7C080", change = "#F2AF5C", delete = "#F05F4E" },
    diff = { add = "#323926", change = "#48341B", delete = "#481C17", text = "#242B30" },
}

M.night = {
    bg = "#1a1b26",
    bg_dark = "#16161e",
}
M.day = M.night

M.moon = function()
    local ret = {
        none = "NONE",
        bg_dark = "#1e2030", --
        bg = "#222436", --
        bg_highlight = "#2f334d", --
        terminal_black = "#444a73", --
        fg = "#c8d3f5", --
        fg_dark = "#828bb8", --
        fg_gutter = "#3b4261",
        dark3 = "#545c7e",
        comment = "#7a88cf", --
        dark5 = "#737aa2",
        blue0 = "#3e68d7", --
        blue = "#82aaff", --
        cyan = "#86e1fc", --
        blue1 = "#65bcff", --
        blue2 = "#0db9d7",
        blue5 = "#89ddff",
        blue6 = "#b4f9f8", --
        blue7 = "#394b70",
        purple = "#fca7ea", --
        magenta2 = "#ff007c",
        magenta = "#c099ff", --
        orange = "#ff966c", --
        yellow = "#ffc777", --
        green = "#c3e88d", --
        green1 = "#4fd6be", --
        green2 = "#41a6b5",
        teal = "#4fd6be", --
        red = "#ff757f", --
        red1 = "#c53b53", --
    }
    ret.git = {
        change = util.blend(ret.blue, ret.bg, "ee"),
        add = util.blend(ret.green, ret.bg, "ee"),
        delete = util.blend(ret.red, ret.bg, "dd"),
    }
    ret.gitSigns = {
        change = util.blend(ret.blue, ret.bg, "66"),
        add = util.blend(ret.green, ret.bg, "66"),
        delete = util.blend(ret.red, ret.bg, "aa"),
    }
    return ret
end

function M.setup(opts)
    opts = opts or {}
    local config = require("lvim-colorscheme.config")
    local style = config.is_light() and config.options.light_style or config.options.style
    local palette = M[style] or {}
    if type(palette) == "function" then
        palette = palette()
    end
    local colors = vim.tbl_deep_extend("force", M.default, palette)
    util.bg = colors.color_01
    util.lght_brightness = config.options.light_brightnes
    colors.black = util.darken(colors.color_03, 0.5, "#161a1d")
    colors.border_highlight = colors.color_06
    colors.border = colors.black
    colors.bg_popup = util.darken(colors.color_01, 0.7, "#161a1d")
    colors.bg_statusline = util.darken(colors.color_01, 0.7, "#161a1d")
    colors.bg_sidebar = config.darkSidebar and util.darken(colors.color_01, 0.7, "#161a1d") or colors.color_01
    colors.bg_float = config.darkFloat and util.darken(colors.color_01, 0.7, "#161a1d") or colors.color_01
    colors.bg_visual = colors.color_05
    colors.bg_search = colors.color_05
    colors.fg_sidebar = colors.color_22
    colors.success = colors.color_18
    colors.error = colors.color_24
    colors.warning = colors.color_21
    colors.info = colors.color_07
    colors.hint = colors.color_09
    config.options.on_colors(colors)
    if opts.transform and config.is_light() then
        util.invert_colors(colors)
    end
    return colors
end

return M
