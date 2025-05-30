local M = {}

M.url = "https://github.com/j-hui/fidget.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    FidgetWindow = { bg = c.bg_float, fg = c.blue },
    FidgetGroup = { fg = c.green, bold = true },
    FidgetIcon = {fg = c.red_dark},
    FidgetProgress = { fg = c.green },
    FidgetDone = { fg = c.orange_dark, bold = true },

  }
end

return M
