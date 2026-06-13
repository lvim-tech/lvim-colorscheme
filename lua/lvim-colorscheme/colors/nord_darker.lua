local ret = vim.deepcopy(require("lvim-colorscheme.colors.nord_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#2c323d",
    bg_soft_light = "#242831",
    bg = "#1d2128",
    bg_soft_dark = "#181d23",
    bg_dark = "#14171c",
    bg_highlight = "#404959",
})
