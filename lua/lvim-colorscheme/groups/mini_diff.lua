local M = {}

M.url = "https://github.com/echasnovski/mini.files"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        MiniDiffSignAdd= { fg = c.git.add },
        MiniDiffSignChange= { fg = c.git.change },
        MiniDiffSignDelete= { fg = c.git.delete },
    }
end

return M
