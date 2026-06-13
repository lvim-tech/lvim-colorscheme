local ret = vim.deepcopy(require("lvim-colorscheme.colors.dracula_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#2d2f3b",
    bg_soft_light = "#242630",
    bg = "#1d1f27",
    bg_soft_dark = "#191a21",
    bg_dark = "#15161c",
    bg_highlight = "#3d4051",
})
