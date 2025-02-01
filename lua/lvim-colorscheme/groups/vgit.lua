local util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/tanvirtin/vgit.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    GitAppBar = {bg = util.blend_bg(c.bg_dark, 0.9)},
    GitFooter = {bg = util.blend_bg(c.bg_dark, 0.9)},
    GitHeader = {bg = util.blend_bg(c.bg_dark, 0.9)},
  }
end

return M
