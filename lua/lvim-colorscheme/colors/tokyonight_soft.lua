local ret = vim.deepcopy(require("lvim-colorscheme.colors.tokyonight_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#262932",
    bg_soft_light = "#242730",
    bg = "#22252e",
    bg_soft_dark = "#20232c",
    bg_dark = "#1e212a",
})
