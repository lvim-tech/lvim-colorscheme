local M = {}

M.url = "https://github.com/stevearc/overseer.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        OverseerPENDING = { fg = c.cyan_dark },
        OverseerRUNNING = { fg = c.blue_dark },
        OverseerSUCCESS = { fg = c.green_dark },
        OverseerCANCELED = { fg = c.orange_dark },
        OverseerFAILURE = { fg = c.red_dark },
    }
end

return M
