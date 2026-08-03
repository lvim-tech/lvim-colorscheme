local ret = vim.deepcopy(require("lvim-colorscheme.colors.solarized_dark"))

---@type Palette
return vim.tbl_deep_extend("force", ret, {
    bg_light = "#043845",
    bg_soft_light = "#023643",
    bg = "#003441",
    bg_soft_dark = "#00323f",
    bg_dark = "#00303d",
})
