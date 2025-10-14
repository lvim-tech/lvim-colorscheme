local M = {}

M.url = "https://github.com/HiPhish/rainbow-delimiters.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        -- rainbow-delimiters
        RainbowDelimiterRed    = { fg = c.red },
        RainbowDelimiterOrange = { fg = c.orange },
        RainbowDelimiterYellow = { fg = c.yellow },
        RainbowDelimiterGreen  = { fg = c.green },
        RainbowDelimiterBlue   = { fg = c.blue },
        RainbowDelimiterViolet = { fg = c.purple },
        RainbowDelimiterCyan   = { fg = c.cyan },
    }
end

return M
