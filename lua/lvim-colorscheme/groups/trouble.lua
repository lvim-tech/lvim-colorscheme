local M = {}

M.url = "https://github.com/folke/trouble.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        TroubleNormal           = { fg = c.fg, bg = c.bg_sidebar },
        TroubleText             = { fg = c.fg_soft_dark },
        TroubleCount            = { fg = c.fg_soft_dark },
        TroublePos              = { fg = c.fg_soft_dark },
        TroubleError            = { bg = c.error },
        TroubleTextError        = { fg = c.error },
        TroubleTextWarning      = { fg = c.warning },
        TroubleWarning          = { bg = c.warning },
        TroubleInformation      = { bg = c.info },
        TroubleTextInformation  = { fg = c.info },
        TroubleHint             = { bg = c.hint },
        TroubleTextHint         = { fg = c.hint },
    }
end

return M
