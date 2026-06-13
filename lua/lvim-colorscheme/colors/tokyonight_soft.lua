local ret = vim.deepcopy(require("lvim-colorscheme.colors.tokyonight_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#2d3349",
    bg_soft_light = "#282d42",
    bg = "#1f202d",
    bg_soft_dark = "#1b1b24",
    bg_dark = "#181820",
    bg_highlight = "#3f4768",
})
