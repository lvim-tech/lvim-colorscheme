local ret = vim.deepcopy(require("lvim-colorscheme.colors.solarized_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#04232b",
    bg_soft_light = "#022129",
    bg = "#001f27",
    bg_soft_dark = "#001d25",
    bg_dark = "#001b23",
})
