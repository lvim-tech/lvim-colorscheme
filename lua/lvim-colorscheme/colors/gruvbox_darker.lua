local ret = vim.deepcopy(require("lvim-colorscheme.colors.gruvbox_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#222120",
    bg_soft_light = "#201f1e",
    bg = "#1e1d1c",
    bg_soft_dark = "#1c1b1a",
    bg_dark = "#1a1918",
})
