local M = {}

M.url = "https://github.com/SmiteshP/nvim-navic"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  local ret = {
    NavicSeparator = { fg = c.fg, bg = c.none },
    NavicText      = { fg = c.fg, bg = c.none },
  }
    require("lvim-colorscheme.groups.kinds").kinds(ret, "NavicIcons%s")
    return ret
end

return M
