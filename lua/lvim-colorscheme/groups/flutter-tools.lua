local util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/nvim-flutter/flutter-tools.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    FlutterInlineHint = { bg = util.blend_bg(c.blue_dark, 0.1), fg = c.blue_dark },
  }
end

return M
