local M = {}

M.url = "https://github.com/TimUntersberger/neogit"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        NeogitBranch                = { fg = c.blue },
        NeogitDiffAddHighlight      = { bg = c.bg_highlight },
        NeogitDiffContextHighlight  = { bg = c.bg_highlight },
        NeogitDiffDeleteHighlight   = { bg = c.bg_highlight },
        NeogitHunkHeader            = { bg = c.bg, fg = c.cyan },
        NeogitHunkHeaderHighlight   = { bg = c.bg, fg = c.green },
        NeogitRemote                = { fg = c.fg },
        NeogitNotificationInfo      = { fg = c.info },
        NeogitNotificationWarning   = { fg = c.warning },
        NeogitNotificationError     = { fg = c.error },
        NeogitCommitViewDescription = { fg = c.teal },
        NeogitFilePath              = { fg = c.red },
        NeogitCommitViewHeader      = { fg = c.error },
        NeogitCommitMessage         = { fg = c.yellow },
        NeogitCommitView            = { fg = c.fg },
    }
end

return M
