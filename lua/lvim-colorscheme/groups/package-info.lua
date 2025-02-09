local util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/vuki656/package-info.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    PackageInfoUpToDateVersion  = { bg = util.blend_bg(c.blue_dark, 0.1), fg = c.blue_dark },
    PackageInfoOutdatedVersion  = { bg = util.blend_bg(c.red_dark, 0.1), fg = c.red_dark },
  }
end

return M
