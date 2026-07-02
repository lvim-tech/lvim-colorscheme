-- lvim-colorscheme.groups.gitsigns: highlight groups for gitsigns.nvim (https://github.com/lewis6991/gitsigns.nvim).
--
---@module "lvim-colorscheme.groups.gitsigns"

local M = {}

M.url = "https://github.com/lewis6991/gitsigns.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        GitSignsAdd           = { fg = c.git.add },
        GitSignsChange        = { fg = c.git.change },
        GitSignsDelete        = { fg = c.git.delete },
        GitSignsTopDelete     = { fg = c.git.delete },
        GitSignsChangeDelete  = { fg = c.git.change_delete },
        GitSignsUntracked     = { fg = c.git.untracked },
    }
end

return M
