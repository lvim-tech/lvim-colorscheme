local ret = vim.deepcopy(require("lvim-colorscheme.colors.catppuccin_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#393b4a",
    bg_soft_light = "#2f2f41",
    bg = "#222235",
    bg_soft_dark = "#1c1c2c",
    bg_dark = "#151522",
    bg_highlight = "#4f5264",
})
