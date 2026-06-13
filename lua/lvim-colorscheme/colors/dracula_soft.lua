local ret = vim.deepcopy(require("lvim-colorscheme.colors.dracula_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#393b4a",
    bg_soft_light = "#2f323f",
    bg = "#292b36",
    bg_soft_dark = "#252630",
    bg_dark = "#20222b",
    bg_highlight = "#494c60",
})
