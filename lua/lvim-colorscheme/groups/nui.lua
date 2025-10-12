local util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/MunifTanjim/nui.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    NuiBody = { bg = c.bg_statusline, fg = c.blue_dark },
    NuiBorder = { bg = c.bg_statusline, fg = c.blue_dark, bold = true },
    LvimPopupNormal = { bg = c.bg_float },
    LvimPopupBorder = { bg = c.bg_float, fg = c.blue_dark, bold = true },
    LvimSelectTitle = { bg = util.blend_bg(c.blue_dark, 0.1), fg = c.blue_dark },
    LvimSelectNormal = { bg = c.bg_float, fg = c.blue_dark },
    LvimSelectBorder = { bg = c.bg_float, fg = c.blue_dark, bold = true },
    LvimInputNormal = { bg = c.bg_float, fg = c.blue_dark },
    LvimInputBorder = { bg = c.bg_float, fg = c.blue_dark, bold = true },
  }
end

return M
