local M = {}

M.url = "https://github.com/kosayoda/nvim-lightbulb"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        LightBulbSign                   = { fg = c.yellow_dark, bold = true },
        LightBulbVirtualText            = { fg = c.yellow_dark, bold = true },
        LightBulbSignLightBulbFloatWin  = { fg = c.yellow_dark, bold = true },
        LightBulbNumber                 = { fg = c.yellow_dark, bold = true },
        LightBulbLine                   = { fg = c.yellow_dark, bold = true },
    }
end

return M
