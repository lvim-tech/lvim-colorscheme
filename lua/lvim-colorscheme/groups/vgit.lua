-- lvim-colorscheme.groups.vgit: highlight groups for vgit.nvim (https://github.com/tanvirtin/vgit.nvim).
--
---@module "lvim-colorscheme.groups.vgit"

local util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/tanvirtin/vgit.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        GitAppBar       = { bg = util.blend_bg(c.bg_dark, 0.9) },
        GitFooter       = { bg = util.blend_bg(c.bg_dark, 0.9) },
        GitHeader       = { bg = util.blend_bg(c.bg_dark, 0.9) },
        -- GitSigns* are owned by groups/gitsigns.lua; vgit must not redefine them (it collided on Untracked,
        -- vgit's red vs gitsigns' blue winning by hash accident). vgit's own chrome is the Git* bar groups above.
    }
end

return M
