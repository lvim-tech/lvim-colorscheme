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

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    return table.concat({
        "export MLR_KEY_COLOR=bold-" .. ansi.to_256(colors.blue),
        "export MLR_VALUE_COLOR=" .. ansi.to_256(colors.fg),
        "export MLR_PASS_COLOR=" .. ansi.to_256(colors.green),
        "export MLR_FAIL_COLOR=" .. ansi.to_256(colors.red),
        "export MLR_HELP_COLOR=" .. ansi.to_256(colors.yellow),
        "export MLR_REPL_PS1_COLOR=" .. ansi.to_256(colors.purple),
        "export MLR_REPL_PS2_COLOR=" .. ansi.to_256(colors.comment),
        "",
    }, "\n")
end

return M
