local ret = vim.deepcopy(require("lvim-colorscheme.colors.solarized_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#0c404c",
    bg_soft_light = "#062b34",
    bg = "#001f27",
    bg_soft_dark = "#00181f",
    bg_dark = "#001318",
    bg_highlight = "#08343e",
})
