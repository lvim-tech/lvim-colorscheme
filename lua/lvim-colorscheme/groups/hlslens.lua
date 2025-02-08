local util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/kevinhwang91/nvim-hlslens"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    HlSearchNear      = { bg = util.blend_bg(c.blue_dark, 0.3), fg = c.none, bold = true },
    HlSearchLens      = { bg = util.blend_bg(c.blue_dark, 0.1), fg = c.blue_dark },
    HlSearchLensNear  = { bg = util.blend_bg(c.blue_dark, 0.1), fg = c.blue_dark, bold = true },
  }
end

return M
