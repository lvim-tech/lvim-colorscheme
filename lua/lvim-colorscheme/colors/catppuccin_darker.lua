local ret = vim.deepcopy(require("lvim-colorscheme.colors.catppuccin_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#1c1d24",
    bg_soft_light = "#1a1b22",
    bg = "#181920",
    bg_soft_dark = "#16171e",
    bg_dark = "#14151c",
})
