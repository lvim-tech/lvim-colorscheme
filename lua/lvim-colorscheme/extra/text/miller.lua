-- lvim-colorscheme.extra.miller: generate the Miller colour exports from the
-- lvim-colorscheme palette.
--
--     source .../extras/miller/LvimNord_dark.sh
--
-- Miller has no colour config file; it reads MLR_*_COLOR environment
-- variables (a .mlrrc can hold the equivalent flags instead).
--
-- The values are xterm-256 INDICES, not hex — Miller has no truecolor path —
-- so every palette colour is rounded to its nearest index. That rounding is
-- shared with procs through extra/ansi.lua, so the same colour lands on the
-- same index in both.
--
---@module "lvim-colorscheme.extra.miller"

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
    -- index this emits IS a colour and not a slot the terminal gets to reinterpret. Flooring before
    -- the rounding is therefore what decides what lands on screen.
    local function text(hex)
        return util.ensure_contrast(hex, colors.terminal.background, 4.5)
    end
    return table.concat({
        "export MLR_KEY_COLOR=bold-" .. ansi.to_256(text(colors.blue)),
        "export MLR_VALUE_COLOR=" .. ansi.to_256(text(colors.fg)),
        "export MLR_PASS_COLOR=" .. ansi.to_256(text(colors.green)),
        "export MLR_FAIL_COLOR=" .. ansi.to_256(text(colors.red)),
        "export MLR_HELP_COLOR=" .. ansi.to_256(text(colors.yellow)),
        "export MLR_REPL_PS1_COLOR=" .. ansi.to_256(text(colors.purple)),
        "export MLR_REPL_PS2_COLOR=" .. ansi.to_256(text(colors.comment)),
        "",
    }, "\n")
end

return M
