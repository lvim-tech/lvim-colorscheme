-- lvim-colorscheme.groups.quicker: highlight groups for quicker.nvim (https://github.com/stevearc/quicker.nvim).
--
---@module "lvim-colorscheme.groups.quicker"

local M = {}

M.url = "https://github.com/stevearc/quicker.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        QuickFixLineNr = { fg = c.yellow_dark, bold = true },
    }
end

return M
