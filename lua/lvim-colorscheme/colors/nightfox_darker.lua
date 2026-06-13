local ret = vim.deepcopy(require("lvim-colorscheme.colors.nightfox_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#243245",
    bg_soft_light = "#1c2735",
    bg = "#141c26",
    bg_soft_dark = "#10161e",
    bg_dark = "#0e131a",
    bg_highlight = "#263447",
})
