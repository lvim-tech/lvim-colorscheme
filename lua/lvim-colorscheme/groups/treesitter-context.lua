local M = {}

M.url = "https://github.com/nvim-treesitter/nvim-treesitter-context"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        TreesitterContext           = { bg = c.bg_dark },
        TreesitterContextLineNumber = { bg = c.bg_dark, fg = c.yellow_dark, bold = true },
    }
end

return M
