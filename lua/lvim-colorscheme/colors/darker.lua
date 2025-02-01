local ret = vim.deepcopy(require("lvim-colorscheme.colors.dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#323c43", -- #737aa2
    bg_soft_light = "#272f34", -- #545c7e
    bg = "#1c2225", -- #222436
    bg_soft_dark = "#181c1f", -- #1e2030
    bg_dark = "#141819", -- #191B29
    bg_highlight = "#2b343a", -- #2f334d
})
