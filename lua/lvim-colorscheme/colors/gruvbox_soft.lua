local ret = vim.deepcopy(require("lvim-colorscheme.colors.gruvbox_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#2c2b2a",
    bg_soft_light = "#2a2928",
    bg = "#282726",
    bg_soft_dark = "#262524",
    bg_dark = "#242322",
})
