local util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/nvim-flutter/pubspec-assist.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        PubspecDependencyUpToDate = { bg = util.blend_bg(c.blue_dark, 0.1), fg = c.blue_dark },
        PubspecDependencyOutdated = { bg = util.blend_bg(c.red_dark, 0.1), fg = c.red_dark },
        PubspecDependencyUnknown = { bg = util.blend_bg(c.orange_dark, 0.1), fg = c.orange_dark },
    }
end

return M
