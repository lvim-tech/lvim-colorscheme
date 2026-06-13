local ret = vim.deepcopy(require("lvim-colorscheme.colors.nord_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#373e4d",
    bg_soft_light = "#2f3441",
    bg = "#282d38",
    bg_soft_dark = "#232933",
    bg_dark = "#1f232c",
    bg_highlight = "#4b5569",
})
