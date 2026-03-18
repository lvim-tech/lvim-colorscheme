local ret = vim.deepcopy(require("lvim-colorscheme.colors.everforest_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light      = "#282f35",
    bg_soft_light = "#232a2f",
    bg            = "#1f2529",
    bg_soft_dark  = "#1b2023",
    bg_dark       = "#161b1d",
    bg_highlight  = "#414d52",
})
