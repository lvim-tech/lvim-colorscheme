local ret = vim.deepcopy(require("lvim-colorscheme.colors.everforest_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#1f2626",
    bg_soft_light = "#1d2424",
    bg = "#1b2121",
    bg_soft_dark = "#191e1e",
    bg_dark = "#171c1c",
})
