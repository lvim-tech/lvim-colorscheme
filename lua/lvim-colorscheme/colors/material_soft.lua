local ret = vim.deepcopy(require("lvim-colorscheme.colors.material_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#36464e",
    bg_soft_light = "#2d3b42",
    bg = "#273339",
    bg_soft_dark = "#232e33",
    bg_dark = "#1f282d",
    bg_highlight = "#364b50",
})
