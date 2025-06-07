local M = {}

M.url = "https://github.com/lvim-tech/lvim-ui-config"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    LvimPopupNormal = { bg = c.bg_float },
    LvimPopupBorder = { bg = c.bg_float, fg = c.red_dark, bold = true },
    LvimSelectNormal = { bg = c.bg_float, fg = c.green_dark },
    LvimSelectBorder = { bg = c.bg_float, fg = c.red_dark, bold = true },
    LvimInputNormal = { bg = c.bg_float, fg = c.green_dark },
    LvimInputBorder = { bg = c.bg_float, fg = c.red_dark, bold = true },
  }
end

return M
