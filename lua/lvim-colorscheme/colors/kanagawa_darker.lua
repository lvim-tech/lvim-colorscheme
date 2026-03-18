local ret = vim.deepcopy(require("lvim-colorscheme.colors.kanagawa"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light      = "#25262e",
    bg_soft_light = "#212229",
    bg            = "#1c1d23",
    bg_soft_dark  = "#17181d",
    bg_dark       = "#131418",
    bg_highlight  = "#16161e",
})
