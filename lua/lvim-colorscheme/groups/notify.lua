local M = {}

M.url = "https://github.com/rcarriga/nvim-notify"

---@type lvim-colorscheme.HighlightsFn
function M.get(c, opts)
    local blend = c.blend
    -- stylua: ignore
    return {
        NotifyBackground  = { fg = c.fg, bg = c.bg },

        NotifyDEBUGBody   = { fg = c.fg, bg = opts.transparent and c.none or c.bg },
        NotifyDEBUGBorder = { fg = blend.debugHigh, bg = opts.transparent and c.none or c.bg },
        NotifyDEBUGIcon   = { fg = c.comment },
        NotifyDEBUGTitle  = { fg = c.comment },

        NotifyERRORBody   = { fg = c.fg, bg = opts.transparent and c.none or c.bg },
        NotifyERRORBorder = { fg = blend.erroHigh, bg = opts.transparent and c.none or c.bg },
        NotifyERRORIcon   = { fg = c.error },
        NotifyERRORTitle  = { fg = c.error },

        NotifyWARNBody    = { fg = c.fg, bg = opts.transparent and c.none or c.bg },
        NotifyWARNBorder  = { fg = blend.warningHigh, bg = opts.transparent and c.none or c.bg },
        NotifyWARNIcon    = { fg = c.warning },
        NotifyWARNTitle   = { fg = c.warning },

        NotifyINFOBody    = { fg = c.fg, bg = opts.transparent and c.none or c.bg },
        NotifyINFOBorder  = { fg = blend.infoHigh, bg = opts.transparent and c.none or c.bg },
        NotifyINFOIcon    = { fg = c.info },
        NotifyINFOTitle   = { fg = c.info },

        NotifyTRACEBody   = { fg = c.fg, bg = opts.transparent and c.none or c.bg },
        NotifyTRACEBorder = { fg = blend.hintHigh, bg = opts.transparent and c.none or c.bg },
        NotifyTRACEIcon   = { fg = c.purple },
        NotifyTRACETitle  = { fg = c.purple },
    }
end

return M
