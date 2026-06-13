local ret = vim.deepcopy(require("lvim-colorscheme.colors.material_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#2b383e",
    bg_soft_light = "#222d32",
    bg = "#1c2529",
    bg_soft_dark = "#182023",
    bg_dark = "#141a1d",
    bg_highlight = "#2b3c40",
})
