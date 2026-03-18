local ret = vim.deepcopy(require("lvim-colorscheme.colors.lvim_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light      = "#3c474f",
    bg_soft_light = "#313a40",
    bg            = "#262d31",
    bg_soft_dark  = "#22272b",
    bg_dark       = "#1e2325",
    bg_highlight  = "#353f46",
})
