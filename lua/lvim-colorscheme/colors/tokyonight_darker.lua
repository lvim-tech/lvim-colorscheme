local ret = vim.deepcopy(require("lvim-colorscheme.colors.tokyonight_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#1c1f26",
    bg_soft_light = "#1a1d24",
    bg = "#181b22",
    bg_soft_dark = "#161920",
    bg_dark = "#14171e",
})
