local ret = vim.deepcopy(require("lvim-colorscheme.colors.lvim_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#2a3135",
    bg_soft_light = "#282f33",
    bg = "#262d31",
    bg_soft_dark = "#242b2f",
    bg_dark = "#22292d",
})
