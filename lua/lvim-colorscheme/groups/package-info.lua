local M = {}

M.url = "https://github.com/vuki656/package-info.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    local blend = c.blend
    -- stylua: ignore
    return {
        PackageInfoUpToDateVersion  = { bg = blend.blueHigh, fg = c.blue_dark },
        PackageInfoOutdatedVersion  = { bg = blend.redHigh, fg = c.red_dark },
    }
end

return M
