local M = {}

M.url = "https://github.com/kevinhwang91/nvim-hlslens"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    local blend = c.blend
    -- stylua: ignore
    return {
        HlSearchNear      = { bg = blend.blueLow, fg = c.none, bold = true },
        HlSearchLens      = { bg = blend.blueHigh, fg = c.blue_dark },
        HlSearchLensNear  = { bg = blend.blueHigh, fg = c.blue_dark, bold = true },
    }
end

return M
