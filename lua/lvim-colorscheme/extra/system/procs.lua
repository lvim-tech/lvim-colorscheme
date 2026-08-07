-- lvim-colorscheme.extra.procs: generate the [style] block of a procs config
-- from the palette.
--
--     mkdir -p ~/.config/procs
--     ln -sf .../extras/procs/LvimNord_dark.toml ~/.config/procs/config.toml
--
-- procs takes 16 names or an xterm-256 INDEX — no hex — so every colour is
-- rounded through extra/ansi.lua, the same rounding miller uses.
--
-- [[columns]] is NOT written on purpose: supplying that array replaces the
-- whole default column set, so a colour scheme that emitted it would also be
-- deciding which columns you see.
--
---@module "lvim-colorscheme.extra.system.procs"

local ansi = require("lvim-colorscheme.extra.ansi")
local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    -- This target writes no background of its own, so its text lands on the TERMINAL's — which
    -- this project themes from the same palette, making `terminal.background` the honest surface
    -- rather than a guess. Measured across the 48 palettes before this existed, 763 of the 1008
    -- accent-and-foreground values in this scheme read under WCAG AA's 4.5:1 when used that way.
    --
    -- The palette's own `terminal.*` entries are NOT touched anywhere: ANSI 0-15 is a measured
    -- hierarchy of its own in `colors/init.lua` (foreground at 6:1, ANSI 8 doing double duty as dim
    -- text and as a block background at ~3:1, 7 derived a step under 15), and a second floor on top
    -- of it would undo that.
    --
    -- `ansi.to_256` rounds into the fixed 6x6x6 cube (indices 16-231), never into ANSI 0-15, so the
    -- index emitted IS a colour rather than a slot the terminal reinterprets.
    --
    -- `tree` is left verbatim: it draws the process tree's ├── glyphs, which are structure, and it
    -- is `bg_light` so the process names stand in front of them.
    local function c(hex)
        return tostring(ansi.to_256(util.ensure_contrast(hex, colors.terminal.background, 4.5)))
    end
    local function glyph(hex)
        return tostring(ansi.to_256(hex))
    end
    return table.concat({
        "[style]",
        'header = "' .. c(colors.blue) .. '"',
        'unit = "' .. c(colors.comment) .. '"',
        'tree = "' .. glyph(colors.bg_light) .. '"',
        "",
        "[style.by_percentage]",
        'color_000 = "' .. c(colors.blue) .. '"',
        'color_025 = "' .. c(colors.green) .. '"',
        'color_050 = "' .. c(colors.yellow) .. '"',
        'color_075 = "' .. c(colors.orange) .. '"',
        'color_100 = "' .. c(colors.red) .. '"',
        "",
        "[style.by_state]",
        'color_d = "' .. c(colors.red) .. '"',
        'color_r = "' .. c(colors.green) .. '"',
        'color_s = "' .. c(colors.blue) .. '"',
        'color_t = "' .. c(colors.yellow) .. '"',
        'color_z = "' .. c(colors.magenta) .. '"',
        'color_x = "' .. c(colors.comment) .. '"',
        "",
        "[style.by_unit]",
        'color_k = "' .. c(colors.blue) .. '"',
        'color_m = "' .. c(colors.green) .. '"',
        'color_g = "' .. c(colors.yellow) .. '"',
        'color_t = "' .. c(colors.orange) .. '"',
        'color_p = "' .. c(colors.red) .. '"',
        'color_x = "' .. c(colors.comment) .. '"',
        "",
    }, "\n")
end

return M
