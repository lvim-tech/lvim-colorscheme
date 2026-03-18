local ret = vim.deepcopy(require("lvim-colorscheme.colors.everforest_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light      = "#32393f",
    bg_soft_light = "#2d3439",
    bg            = "#292f33",
    bg_soft_dark  = "#252a2d",
    bg_dark       = "#202527",
    bg_highlight  = "#4b575c",
})
