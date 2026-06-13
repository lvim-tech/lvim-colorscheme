local ret = vim.deepcopy(require("lvim-colorscheme.colors.rosepine_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#2f2c3c",
    bg_soft_light = "#201d30",
    bg = "#13111b",
    bg_soft_dark = "#191724",
    bg_dark = "#0a0910",
    bg_highlight = "#2a293b",
})
