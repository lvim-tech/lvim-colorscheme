local ret = vim.deepcopy(require("lvim-colorscheme.colors.catppuccin_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#262731",
    bg_soft_light = "#24252f",
    bg = "#22232d",
    bg_soft_dark = "#20212b",
    bg_dark = "#1e1f29",
})
