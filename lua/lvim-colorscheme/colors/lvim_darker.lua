local ret = vim.deepcopy(require("lvim-colorscheme.colors.lvim_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#202629",
    bg_soft_light = "#1e2427",
    bg = "#1c2225",
    bg_soft_dark = "#1a2023",
    bg_dark = "#181e21",
})
