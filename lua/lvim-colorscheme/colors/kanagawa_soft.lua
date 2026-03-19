local ret = vim.deepcopy(require("lvim-colorscheme.colors.kanagawa_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light      = "#2f3038",
    bg_soft_light = "#2b2c33",
    bg            = "#26272d",
    bg_soft_dark  = "#212227",
    bg_dark       = "#1d1e22",
    bg_highlight  = "#202028",
})
