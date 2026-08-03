local ret = vim.deepcopy(require("lvim-colorscheme.colors.nightfox_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#212c3b",
    bg_soft_light = "#1f2a39",
    bg = "#1d2837",
    bg_soft_dark = "#1b2635",
    bg_dark = "#192433",
})
