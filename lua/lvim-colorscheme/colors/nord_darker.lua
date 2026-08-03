local ret = vim.deepcopy(require("lvim-colorscheme.colors.nord_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#21252c",
    bg_soft_light = "#1f232a",
    bg = "#1d2128",
    bg_soft_dark = "#1b1f26",
    bg_dark = "#191d24",
})
