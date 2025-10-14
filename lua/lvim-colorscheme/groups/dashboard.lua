local M = {}

M.url = "https://github.com/nvimdev/dashboard-nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        -- General
        DashboardHeader           = { fg = c.green_dark },
        DashboardFooter           = { fg = c.red_dark },
        -- Hyper theme
        DashboardProjectTitle     = { fg = c.cyan },
        DashboardProjectTitleIcon = { fg = c.orange },
        DashboardProjectIcon      = { fg = c.yellow },
        DashboardMruTitle         = { fg = c.cyan },
        DashboardMruIcon          = { fg = c.purple },
        DashboardFiles            = { fg = c.green_dark },
        DashboardShortCutIcon     = { fg = c.magenta },
        -- Doome theme
        DashboardDesc             = { fg = c.cyan },
        DashboardKey              = { fg = c.orange },
        DashboardIcon             = { fg = c.cyan },
        DashboardShortCut         = { fg = c.cyan },
    }
end

return M
