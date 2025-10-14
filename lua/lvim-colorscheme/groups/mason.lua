local M = {}

M.url = "https://github.com/williamboman/mason.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        MasonNormal = { bg = c.bg_float, fg = c.green_dark },
        MasonError = { fg = c.red },
        MasonHeader = { bg = c.bg_soft_light, fg = c.orange, bold = true },
        MasonHeaderSecondary = { bg = c.bg_soft_light, fg = c.orange, bold = true },
        MasonHeading = { fg = c.teal, bold = true },
        MasonHighlight = { fg = c.green },
        MasonHighlightBlock = { bg = c.orange, fg = c.bg_soft_light },
        MasonHighlightBlockBold = { bg = c.orange, fg = c.bg_soft_light, bold = true },
        MasonHighlightBlockBoldSecondary = { bg = c.orange, fg = c.bg_soft_light, bold = true },
        MasonHighlightBlockSecondary = { bg = c.orange, fg = c.bg_soft_light },
        MasonHighlightSecondary = { fg = c.orange },
        MasonLink = { bg = c.bg_soft_light, fg = c.orange, bold = true },
        MasonMuted = { fg = c.orange },
        MasonMutedBlock = { bg = c.bg_soft_light, fg = c.orange },
        MasonMutedBlockBold = { bg = c.bg_soft_light, fg = c.orange, bold = true },
    }
end

return M
