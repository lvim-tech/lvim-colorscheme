-- lvim-colorscheme.groups.diffview: highlight groups for diffview.nvim (https://github.com/sindrets/diffview.nvim).
--
---@module "lvim-colorscheme.groups.diffview"

local M = {}

M.url = "https://github.com/sindrets/diffview.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(_)
    -- diffview.nvim renders its hunks with the CORE Diff* groups, which are owned by groups/base.lua (incl.
    -- the readable DiffText). This module must NOT redefine them — doing so collided non-deterministically at
    -- merge and, for DiffText, overrode base's fix with an invisible/odd bg. No diffview-specific groups today.
    return {}
end

return M
