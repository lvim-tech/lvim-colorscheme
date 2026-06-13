local ret = vim.deepcopy(require("lvim-colorscheme.colors.rosepine_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#3b384b",
    bg_soft_light = "#2b2741",
    bg = "#1e1b2b",
    bg_soft_dark = "#242134",
    bg_dark = "#141321",
    bg_highlight = "#36344b",
})
