local ret = vim.deepcopy(require("lvim-colorscheme.colors.material_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#20292d",
    bg_soft_light = "#1e272b",
    bg = "#1c2529",
    bg_soft_dark = "#1a2327",
    bg_dark = "#182125",
})
