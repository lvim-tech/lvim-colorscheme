local M = {}

M.url = "https://github.com/folke/noice.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  local ret = {
    NoiceBody                       = {bg = c.bg_float},
    NoiceCmdlineIconInput           = { fg = c.yellow },
    NoiceCmdlineIconLua             = { fg = c.red_dark },
    NoiceCmdlinePopupBorderInput    = { fg = c.yellow },
    NoiceCmdlinePopupBorderLua      = { fg = c.red_dark },
    NoiceCmdlinePopupTitleInput     = { fg = c.yellow },
    NoiceCmdlinePopupTitleLua       = { fg = c.red_dark },
    NoiceCompletionItemKindDefault  = { fg = c.fg_soft_dark, bg = c.none },
  }
    require("lvim-colorscheme.groups.kinds").kinds(ret, "NoiceCompletionItemKind%s")
    return ret
end

return M
