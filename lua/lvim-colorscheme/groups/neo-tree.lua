local util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/nvim-neo-tree/neo-tree.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c, opts)
    -- Tie the blend to the RESOLVED sidebar bg: blend only against a real hex; when the sidebar
    -- is transparent (bg_sidebar == NONE) keep NONE, avoiding util.blend("NONE", …) on nil.
    local dark = c.bg_sidebar == c.none and c.none
        or util.blend(c.bg_sidebar, 0.8, opts.style == "day" and c.fg or "#000000")
    -- stylua: ignore
    return {
        NeoTreeNormal               = { bg = c.bg_sidebar },
        NeoTreeNormalNC             = { bg = c.bg_sidebar },
        NeoTreeRootName             = { fg = c.blue_dark, bold = true },
        NeoTreeDimText              = { fg = c.comment },
        NeoTreeDiagMessage          = { fg = c.comment },
        NeoTreeMessage              = { fg = c.comment },
        NeoTreeDotfile              = { fg = c.comment },
        NeoTreeFileName             = { fg = c.fg_sidebar },
        NeoTreeGitModified          = { fg = c.orange },
        NeoTreeGitStaged            = { fg = c.teal_dark },
        NeoTreeGitUntracked         = { fg = c.magenta },
        NeoTreeTabActive            = { fg = c.green_dark, bg = c.bg_sidebar, bold = true },
        NeoTreeTabInactive          = { fg = c.comment, bg = dark },
        NeoTreeTabSeparatorActive   = { fg = c.green_dark, bg = c.bg_soft_dark },
        NeoTreeTabSeparatorInactive = { fg = c.bg, bg = dark },
    }
end

return M
