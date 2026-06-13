local ret = vim.deepcopy(require("lvim-colorscheme.colors.solarized_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#105363",
    bg_soft_light = "#083e4c",
    bg = "#003441",
    bg_soft_dark = "#002d39",
    bg_dark = "#002832",
    bg_highlight = "#0b4756",
})
