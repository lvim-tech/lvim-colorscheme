local ret = vim.deepcopy(require("lvim-colorscheme.colors.nord_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#2c313c",
    bg_soft_light = "#2a2f3a",
    bg = "#282d38",
    bg_soft_dark = "#262b36",
    bg_dark = "#242934",
})
