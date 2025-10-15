local M = {}

M.url = "https://github.com/DNLHC/glance.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    local blend = c.blend
    -- stylua: ignore
    return {
        GlancePreviewNormal       = { bg = c.bg_statusline },
        GlancePreviewMatch        = { bg = blend.blueHigh, fg = c.blue },
        GlancePreviewCursorLine   = { bg = c.bg_soft_dark },
        GlancePreviewSignColumn   = { bg = c.bg_sidebar },
        GlancePreviewEndOfBuffer  = { bg = c.bg_statusline },
        GlancePreviewLineNr       = { bg = c.bg_statusline, fg = c.fg_dark },
        GlancePreviewBorderBottom = { bg = c.bg_statusline },
        GlanceWinBarFilename      = { bg = c.bg_statusline, fg = c.green, bold = true },
        GlanceWinBarFilepath      = { bg = c.bg_statusline, fg = c.blue },
        GlanceWinBarTitle         = { bg = c.bg_statusline, fg = c.red, bold = true },
        GlanceListNormal          = { bg = c.bg_statusline, fg = c.fg },
        GlanceListFilename        = { fg = c.green, bold = true },
        GlanceListFilepath        = { fg = c.cyan },
        GlanceListCount           = { fg = c.red, bold = true },
        GlanceListMatch           = { bg = blend.blueHigh, fg = c.blue },
        GlanceListCursorLine      = { bg = c.bg },
        GlanceListEndOfBuffer     = { fg = c.green },
        GlanceListBorderBottom    = { bg = c.bg_statusline },
        GlanceFoldIcon            = { fg = c.orange },
        GlanceIndent              = { fg = c.bg_soft_dark },
        GlanceBorderTop           = { bg = c.bg_statusline },
    }
end

return M
