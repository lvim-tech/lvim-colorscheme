local M = {}

M.url = "https://github.com/nvim-flutter/flutter-tools.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        FlutterInlineHint = { bg = c.blend.blueHigh, fg = c.blue_dark },
    }
end

return M
