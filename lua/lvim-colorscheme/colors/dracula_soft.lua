local ret = vim.deepcopy(require("lvim-colorscheme.colors.dracula_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#2d2f3a",
    bg_soft_light = "#2b2d38",
    bg = "#292b36",
    bg_soft_dark = "#272934",
    bg_dark = "#252732",
})
