local ret = vim.deepcopy(require("lvim-colorscheme.colors.kanagawa_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#202127",
    bg_soft_light = "#1e1f25",
    bg = "#1c1d23",
    bg_soft_dark = "#1a1b21",
    bg_dark = "#18191f",
})
