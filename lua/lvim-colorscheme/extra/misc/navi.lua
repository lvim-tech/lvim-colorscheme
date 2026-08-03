-- lvim-colorscheme.extra.navi: generate a navi colour config from the palette.
--
--     mkdir -p ~/.config/navi
--     ln -sf .../extras/navi/LvimNord_dark.yaml ~/.config/navi/config.yaml
--
-- navi takes crossterm NAMES only — no hex, no 256 — so each colour is mapped
-- to the nearest of sixteen through extra/ansi.lua, by hue rather than by raw
-- distance (a pastel blue is numerically closest to grey, which would be the
-- wrong answer for an accent).
--
-- Only the three column colours are navi's own; its picker is fzf, so the
-- list, prompt and pointer come from FZF_DEFAULT_OPTS, which this palette
-- already themes through extras/fzf.
--
---@module "lvim-colorscheme.extra.misc.navi"

local ansi = require("lvim-colorscheme.extra.ansi")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    return table.concat({
        "# " .. (colors._style_name or "Lvim"),
        "style:",
        "  tag:",
        "    color: " .. ansi.to_name(colors.cyan),
        "  comment:",
        "    color: " .. ansi.to_name(colors.blue),
        "  snippet:",
        "    color: " .. ansi.to_name(colors.green),
        "",
    }, "\n")
end

return M
