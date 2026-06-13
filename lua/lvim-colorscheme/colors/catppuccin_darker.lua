local ret = vim.deepcopy(require("lvim-colorscheme.colors.catppuccin_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#2d2f3b",
    bg_soft_light = "#242431",
    bg = "#181825",
    bg_soft_dark = "#12121c",
    bg_dark = "#0b0b12",
    bg_highlight = "#434655",
})
