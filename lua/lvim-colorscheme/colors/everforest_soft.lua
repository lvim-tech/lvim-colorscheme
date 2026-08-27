local ret = vim.deepcopy(require("lvim-colorscheme.colors.everforest_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#2f3636",
    bg_soft_light = "#2d3434",
    bg = "#2b3131",
    bg_soft_dark = "#292e2e",
    bg_dark = "#272c2c",
})
