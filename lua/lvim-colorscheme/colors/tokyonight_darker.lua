local ret = vim.deepcopy(require("lvim-colorscheme.colors.tokyonight_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#232739",
    bg_soft_light = "#1e2231",
    bg = "#14151d",
    bg_soft_dark = "#101015",
    bg_dark = "#0d0d11",
    bg_highlight = "#353c57",
})
