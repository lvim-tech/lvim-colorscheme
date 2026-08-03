local ret = vim.deepcopy(require("lvim-colorscheme.colors.rosepine_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#27252a",
    bg_soft_light = "#252328",
    bg = "#232126",
    bg_soft_dark = "#211f24",
    bg_dark = "#1f1d22",
})
