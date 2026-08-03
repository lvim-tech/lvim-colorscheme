local ret = vim.deepcopy(require("lvim-colorscheme.colors.material_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#2b373d",
    bg_soft_light = "#29353b",
    bg = "#273339",
    bg_soft_dark = "#253137",
    bg_dark = "#232f35",
})
