local utils = require("lvim-colorscheme.utils")

local colors = {
    NONE = "NONE",
    bg_01 = "#242B30",
    bg_02 = "#272F35",
    bg_03 = "#2A3339",
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
    -- color_01 = "#242B30",
    -- color_02 = "#272F35",
    -- color_03 = "#2A3339",
    -- color_04 = "#364249",
    -- color_05 = "#415058",
    -- color_06 = "#4C5D67",
    -- color_07 = "#00839F",
    -- color_08 = "#1C9898",
    -- color_09 = "#2AA198",
    -- color_10 = "#20ACAC",
    -- color_11 = "#41A6B5",
    -- color_12 = "#609F9E",
    -- color_13 = "#70A9A8",
    -- color_14 = "#8fBCBB",
    -- color_15 = "#83A598",
    -- color_16 = "#90C1A3",
    -- color_17 = "#7CB692",
    -- color_18 = "#A7C080",
    -- color_19 = "#95B365",
    -- color_20 = "#F08628",
    -- color_21 = "#F2994B",
    -- color_22 = "#F2AF5C",
    -- color_23 = "#E6C068",
    -- color_24 = "#F05F4E",
    -- color_25 = "#F16A5B",
    git = { add = "#A7C080", change = "#F2AF5C", delete = "#F05F4E", conflict = "#F2994B", ignore = "#008499" },
    gitSigns = { add = "#A7C080", change = "#F2AF5C", delete = "#F05F4E" },
    diff = { add = "#323926", change = "#48341B", delete = "#481C17", text = "#242B30" },
}
colors.success = colors.green_02
colors.error = colors.red_02
colors.warning = colors.orange_02
colors.info = colors.blue_02
colors.hint = colors.teal_02
colors.bg_sidebar = utils.darken(colors.bg_01, 0.7, "#161a1d")
colors.bg_statusline = utils.darken(colors.bg_01, 0.7, "#161a1d")
colors.bg_popup = utils.darken(colors.bg_01, 0.7, "#161a1d")
colors.bg_float = utils.darken(colors.bg_01, 0.7, "#161a1d")
colors.bg_visual = colors.bg_05
colors.bg_search = colors.bg_05
colors.fg_sidebar = colors.orange_02

return colors
