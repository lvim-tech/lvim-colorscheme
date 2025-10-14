local M = {}

M.url = "https://github.com/mangelozzi/rgflow.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        RgFlowHead          = { bg = c.bg_float, fg = c.red, bold = true },
        RgFlowInputBg       = { bg = c.bg_float },
        RgFlowHeadLine      = { bg = c.bg_float },
        RgFlowInputFlags    = { fg = c.teal },
        RgFlowInputPattern  = { fg = c.green },
        RgFlowInputPath     = { fg = c.teal },
        RgFlowQfPattern     = { bg = c.bg_search },
    }
end

return M
