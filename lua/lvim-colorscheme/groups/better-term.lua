local M = {}

M.url = "https://github.com/CRAG666/betterTerm.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
local ret = {
  BetterTermActive    = { bg = c.green,     fg = c.bg_float },
  BetterTermInactive  = { bg = c.bg_float,  fg = c.green },
  BetterTermAdd       = { bg = c.yellow,    fg = c.bg_float },
}

    require("lvim-colorscheme.groups.kinds").kinds(ret, "BlinkCmpKind%s")
    return ret
end

return M
