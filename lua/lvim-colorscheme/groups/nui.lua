local M = {}

M.url = "https://github.com/MunifTanjim/nui.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    NuiBody = { bg = c.bg_statusline, fg = c.green },
    NuiBorder = { bg = c.bg_statusline, fg = c.red, bold = true },
  }
end

return M
