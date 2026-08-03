local ret = vim.deepcopy(require("lvim-colorscheme.colors.kanagawa_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#2a2b31",
    bg_soft_light = "#28292f",
    bg = "#26272d",
    bg_soft_dark = "#24252b",
    bg_dark = "#222329",
})
