local ret = vim.deepcopy(require("lvim-colorscheme.colors.nightfox_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#2d3e56",
    bg_soft_light = "#253346",
    bg = "#1d2837",
    bg_soft_dark = "#19222f",
    bg_dark = "#171f2b",
    bg_highlight = "#2f4058",
})
