-- lvim-colorscheme.extra.jq: generate the JQ_COLORS export from the
-- lvim-colorscheme palette.
--
--     source .../extras/jq/LvimNord_dark.sh
--
-- jq takes its colours from ONE environment variable — no config file — as
-- eight colon-separated SGR bodies, in this order: null, false, true,
-- numbers, strings, arrays, objects, object keys.
--
-- The manual only documents "two numbers separated by a semi-colon", but
-- jq_set_colors accepts any run of digits and semicolons, so the truecolor
-- form 38;2;r;g;b works and the palette lands exactly. On a terminal without
-- truecolor jq still starts — the sequence is simply ignored.
--
---@module "lvim-colorscheme.extra.jq"

local ansi = require("lvim-colorscheme.extra.ansi")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    local fields = {
        "0;" .. ansi.sgr(colors.comment), -- null
        "0;" .. ansi.sgr(colors.red), -- false
        "0;" .. ansi.sgr(colors.green), -- true
        "0;" .. ansi.sgr(colors.orange), -- numbers
        "0;" .. ansi.sgr(colors.yellow), -- strings
        "1;" .. ansi.sgr(colors.fg), -- arrays
        "1;" .. ansi.sgr(colors.fg), -- objects
        "1;" .. ansi.sgr(colors.blue), -- object keys
    }
    return 'export JQ_COLORS="' .. table.concat(fields, ":") .. '"\n'
end

return M
