local ret = vim.deepcopy(require("lvim-colorscheme.colors.dracula_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#21232b",
    bg_soft_light = "#1f2129",
    bg = "#1d1f27",
    bg_soft_dark = "#1b1d25",
    bg_dark = "#191b23",
})
