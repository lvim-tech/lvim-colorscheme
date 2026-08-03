local ret = vim.deepcopy(require("lvim-colorscheme.colors.rosepine_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#1b191d",
    bg_soft_light = "#19171b",
    bg = "#171519",
    bg_soft_dark = "#151317",
    bg_dark = "#131115",
})
