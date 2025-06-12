local util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/lvim-tech/lvim-space"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  local bg_blend = util.blend(c.blue, 0.2, c.bg)
    local main_color = c.blue_dark
  -- stylua: ignore
  return {
    LvimSpaceNormal = { bg = c.bg_float},
    LvimSpaceCursorLine = { bg = c.bg_float, fg = main_color, bold = true },
    LvimSpaceTitle = { bg = bg_blend, fg = main_color },
    LvimSpaceInfo = { bg = c.bg_float, fg = main_color, bold = true },
    LvimSpacePrompt = { bg = c.bg_float, fg = main_color, bold = true },
    LvimSpaceInput = { bg = bg_blend, fg = c.blue },
    LvimSpaceSign = { bg = c.bg_float, fg = main_color },
    LvimSpaceCursor = { bg = c.bg_float, fg = c.bg_float },
    LvimSpaceFuzzyPrimary = { fg = c.red_dark, bold = true },
    LvimSpaceFuzzySecondary = { fg = c.red, bold = true },
  }
end

return M
