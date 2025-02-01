local Util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/mfussenegger/nvim-dap"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    DapStoppedLine = { bg = Util.blend_bg(c.warning, 0.1) }, -- Used for "Warning" diagnostic virtual text
  }
end

return M
