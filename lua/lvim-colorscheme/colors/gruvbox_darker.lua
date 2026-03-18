local ret = vim.deepcopy(require("lvim-colorscheme.colors.gruvbox"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light      = "#312e2d",
    bg_soft_light = "#282625",
    bg            = "#1e1d1c",
    bg_soft_dark  = "#191817",
    bg_dark       = "#141310",
    bg_highlight  = "#3f3b3a",
})
