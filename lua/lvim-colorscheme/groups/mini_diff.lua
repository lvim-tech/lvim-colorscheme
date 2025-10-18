local M = {}

M.url = "https://github.com/echasnovski/mini.files"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    local blend = c.blend
    -- stylua: ignore
    return {
        MiniDiffSignAdd= { fg = c.git.add },
        MiniDiffSignChange= { fg = c.git.change },
        MiniDiffSignDelete= { fg = c.git.delete },
        MiniDiffOverChangeBuf = { bg = blend.blueLow },
        MiniDiffOverContext = { bg = blend.blueHigh },
        MiniDiffOverContextBuf = { bg = c.black }
    }
end

return M
