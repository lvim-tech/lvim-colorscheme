local M = {}

M.url = "https://github.com/echasnovski/mini.cursorword"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        MiniCursorword        = { bg = c.bg_search },
        MiniCursorwordCurrent = { bg = c.bg_search },
    }
end

return M
