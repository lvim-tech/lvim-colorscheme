local Util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/lukas-reineke/indent-blankline.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    IndentBlanklineChar         = { fg = c.fg_dark,                           nocombine = true },
    IndentBlanklineContextChar  = { fg = c.yellow,  nocombine = true },
    IndentBlanklineCurrentChar  = { fg = c.yellow,  nocombine = true},
    IndentLine                  = { fg = c.fg_dark,                           nocombine = true},
    IndentLineCurrent           = { fg = c.yellow,  nocombine = true },
  }
end

return M
