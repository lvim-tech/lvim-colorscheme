local ret = vim.deepcopy(require("lvim-colorscheme.colors.dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#323c43",
    bg_soft_light = "#272f34",
    bg = "#1c2225",
    bg_soft_dark = "#181c1f",
    bg_dark = "#141819",
    bg_highlight = "#2b343a",
})
