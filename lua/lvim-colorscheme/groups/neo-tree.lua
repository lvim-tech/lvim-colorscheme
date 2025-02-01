local Util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/nvim-neo-tree/neo-tree.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c, opts)
    local dark = opts.styles.sidebars == "transparent" and c.none
        or Util.blend(c.bg_sidebar, 0.8, opts.style == "day" and c.fg or "#000000")
  -- stylua: ignore
  return {
    NeoTreeDimText              = { fg = c.comment },
    NeoTreeDiagMessage          = { fg = c.comment },
    NeoTreeMessage              = { fg = c.comment },
    NeoTreeDotfile              = { fg = c.comment },
    NeoTreeFileName             = { fg = c.fg_sidebar },
    NeoTreeGitModified          = { fg = c.orange },
    NeoTreeGitStaged            = { fg = c.teal_dark },
    NeoTreeGitUntracked         = { fg = c.magenta },
    NeoTreeNormal               = { fg = c.fg_sidebar, bg = c.bg_sidebar },
    NeoTreeNormalNC             = { fg = c.fg_sidebar, bg = c.bg_sidebar },
    NeoTreeTabActive            = { fg = c.green_dark, bg = c.bg_sidebar, bold = true },
    NeoTreeTabInactive          = { fg = c.comment, bg = dark },
    NeoTreeTabSeparatorActive   = { fg = c.green_dark, bg = c.bg_soft_dark },
    NeoTreeTabSeparatorInactive = { fg = c.bg, bg = dark },
  }
end

return M
