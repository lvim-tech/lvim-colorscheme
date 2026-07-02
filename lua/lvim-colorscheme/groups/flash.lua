-- lvim-colorscheme.groups.flash: highlight groups for flash.nvim (https://github.com/folke/flash.nvim).
--
---@module "lvim-colorscheme.groups.flash"

local M = {}

M.url = "https://github.com/folke/flash.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        FlashBackdrop = { fg = c.comment },
        FlashCurrent  = { bg = c.bg_highlight, fg = c.red, bold = true },
        FlashLabel    = { bg = c.bg_highlight, fg = c.orange, bold = true },
    }
end

return M
