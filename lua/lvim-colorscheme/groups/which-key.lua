local M = {}

M.url = "https://github.com/folke/which-key.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    local blend = c.blend
    -- stylua: ignore
    return {
        WhichKey          = { fg = c.cyan },
        WhichKeyGroup     = { fg = c.green },
        WhichKeyDesc      = { fg = c.magenta },
        WhichKeySeparator = { fg = c.comment },
        WhichKeyNormal    = { bg = c.bg_sidebar },
        WhichKeyTitle     = { bg = blend.redHigh, fg = c.red },
        WhichKeyValue     = { fg = c.comment },
    }
end

return M
