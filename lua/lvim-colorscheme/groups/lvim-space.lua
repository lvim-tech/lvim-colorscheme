local M = {}

M.url = "https://github.com/lvim-tech/lvim-space"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    local blend = c.blend
    local main_color = c.blue_dark
    -- stylua: ignore
    return {
        LvimSpaceNormal = { bg = c.bg_float},
        LvimSpaceCursorLine = { bg = c.bg_float, fg = main_color, bold = true },
        LvimSpaceTitle = { bg = blend.blueHigh, fg = main_color, bold = true },
        LvimSpaceInfo = { bg = c.bg_float, fg = main_color, bold = true },
        LvimSpacePrompt = { bg = c.bg_float, fg = main_color, bold = true },
        LvimSpaceInput = { bg = blend.blueHigh, fg = c.blue },
        LvimSpaceSign = { bg = c.bg_float, fg = main_color },
        LvimSpaceCursor = { bg = c.bg_float, fg = c.bg_float },
        LvimSpaceFuzzyPrimary = { bg = blend.blueHigh, fg = c.blue, bold = true },
        LvimSpaceFuzzySecondary = { bg = blend.blueHigh, fg = c.blue_dark, bold = true },
    }
end

return M
