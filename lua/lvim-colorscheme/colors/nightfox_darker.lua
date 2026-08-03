local ret = vim.deepcopy(require("lvim-colorscheme.colors.nightfox_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#18202a",
    bg_soft_light = "#161e28",
    bg = "#141c26",
    bg_soft_dark = "#121a24",
    bg_dark = "#101822",
})
