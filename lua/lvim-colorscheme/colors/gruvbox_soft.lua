local ret = vim.deepcopy(require("lvim-colorscheme.colors.gruvbox_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light      = "#3b3837",
    bg_soft_light = "#32302f",
    bg            = "#282726",
    bg_soft_dark  = "#232221",
    bg_dark       = "#1e1d1a",
    bg_highlight  = "#494544",
})
