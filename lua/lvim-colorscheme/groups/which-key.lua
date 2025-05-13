local util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/folke/which-key.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    WhichKey          = { fg = c.cyan },
    WhichKeyGroup     = { fg = c.green },
    WhichKeyDesc      = { fg = c.magenta },
    WhichKeySeparator = { fg = c.comment },
    WhichKeyNormal    = { bg = c.bg_sidebar },
    WhichKeyTitle     = { bg = util.blend(c.red, 0.1, c.bg), fg = c.red },
    WhichKeyValue     = { fg = c.comment },
  }
end

return M
