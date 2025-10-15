local M = {}

M.url = "https://github.com/lvim-tech/lvim-control-center"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    local blend = c.blend
    local main_color = c.blue_dark
  -- stylua: ignore
  return {
      LvimControlCenterPanel =            { bg = c.bg_float },
      LvimControlCenterSeparator =        { fg = blend.blueHigh},
      LvimControlCenterTabActive =        { fg = c.blue, bg = blend.blueHigh, bold = true },
      LvimControlCenterTabInactive =      { fg = main_color, bg = c.bg_float },
      LvimControlCenterTabIconActive =    { fg = c.red_dark },
      LvimControlCenterTabIconInactive =  { fg = c.red },
      LvimControlCenterStatusLine =       { fg = c.blue },
      LvimControlCenterBorder =           { fg = main_color, bg = c.bg_float },
      LvimControlCenterFloat =            { fg = main_color, bg = c.bg_float },
      LvimControlCenterTitle =            { fg = c.blue, bg = blend.blueHigh, bold = true },
      LvimControlCenterLineActive =       { fg = c.blue, bg = blend.blueHigh, bold = true },
      LvimControlCenterLineInactive =     { fg = main_color, bg = c.bg_float },
      LvimControlCenterIconActive =       { fg = c.red_dark },
      LvimControlCenterIconInactive =     { fg = c.red },
  }
end

return M
