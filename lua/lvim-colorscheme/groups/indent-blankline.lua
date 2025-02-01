local Util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/lukas-reineke/indent-blankline.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    IndentBlanklineChar         = { fg = c.fg_dark,                           nocombine = true },
    IndentBlanklineContextChar  = { fg = Util.blend_bg(c.fg_soft_dark, 0.6),  nocombine = true },
    IndentBlanklineCurrentChar  = { fg = Util.blend_bg(c.fg_soft_dark, 0.6),  nocombine = true},
    IndentLine                  = { fg = c.fg_dark,                           nocombine = true},
    IndentLineCurrent           = { fg = Util.blend_bg(c.fg_soft_dark, 0.6),  nocombine = true },
  }
end

return M
