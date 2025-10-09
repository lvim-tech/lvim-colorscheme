local util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/lvim-tech/lvim-control-center"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  local bg_blend = util.blend(c.blue, 0.2, c.bg)
  -- stylua: ignore
  local main_color = c.blue_dark

  -- stylua: ignore
  return {
    LvimControlCenterPanel = { bg = c.bg_float },
    LvimControlCenterSeparator = { fg = bg_blend},
		LvimControlCenterTabActive = { fg = c.blue, bg = bg_blend, bold = true },
		LvimControlCenterTabInactive = { fg = main_color, bg = c.bg_float },
		LvimControlCenterTabIconActive = { fg = c.red_dark },
		LvimControlCenterTabIconInactive = { fg = c.red },
		LvimControlCenterStatusLine = { fg = c.blue },
		LvimControlCenterBorder = { fg = main_color, bg = c.bg_float },
		LvimControlCenterFloat = { fg = main_color, bg = c.bg_float },
		LvimControlCenterTitle = { fg = c.blue, bg = bg_blend, bold = true },
		LvimControlCenterLineActive = { fg = c.blue, bg = bg_blend, bold = true },
		LvimControlCenterLineInactive = { fg = main_color, bg = c.bg_float },
		LvimControlCenterIconActive = { fg = c.red_dark },
		LvimControlCenterIconInactive = { fg = c.red },
  }
end

return M
