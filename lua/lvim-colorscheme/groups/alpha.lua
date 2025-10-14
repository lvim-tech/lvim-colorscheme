local M = {}

M.url = "https://github.com/goolord/alpha-nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        AlphaShortcut    = { fg = c.orange },
        AlphaHeader      = { fg = c.green_dark },
        AlphaHeaderLabel = { fg = c.orange },
        AlphaFooter      = { fg = c.red_dark },
        AlphaButtons     = { fg = c.cyan },
    }
end

return M
