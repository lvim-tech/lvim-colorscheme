-- lvim-colorscheme.extra.ripgrep: generate a ripgrep config from the palette.
--
--     export RIPGREP_CONFIG_PATH=.../extras/ripgrep/LvimNord_dark.conf
--
-- ripgrep has no config-file discovery of its own: the file is whatever
-- RIPGREP_CONFIG_PATH points at, one CLI flag per line. Only --colors lines
-- are written, so pointing the variable here does not silently change your
-- search behaviour.
--
-- Colours go in as decimal r,g,b (24-bit); `intense` is deliberately unused
-- because ripgrep ignores it as soon as extended colours are in play.
--
---@module "lvim-colorscheme.extra.files.ripgrep"

local ansi = require("lvim-colorscheme.extra.ansi")
local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    -- Text here lands on the TERMINAL's background, which this project themes from the same
    -- palette -- so `terminal.background` is the honest surface rather than a guess. The palette's
    -- own `terminal.*` entries are never re-floored: ANSI 0-15 is a measured hierarchy of its own
    -- in `colors/init.lua` and a second floor on top would undo it.
    --
    -- `match` is the exception: ripgrep paints a background for it, so its text is chosen from the
    -- two the theme has and the yellow gives a step of lightness only where that cannot reach the
    -- floor. `path`, `line` and `column` are written straight onto the terminal.
    local function text(hex)
        return util.ensure_contrast(hex, colors.terminal.background, 4.5)
    end
    local match_fg = util.readable_on(colors.yellow, colors.bg_dark)
    local match_bg = util.ensure_contrast(colors.yellow, match_fg, 4.5)
    local d = ansi.decimal
    return table.concat({
        "# " .. (colors._style_name or "Lvim"),
        "--colors=path:fg:" .. d(text(colors.blue)),
        "--colors=path:style:bold",
        "--colors=line:fg:" .. d(text(colors.comment)),
        "--colors=column:fg:" .. d(text(colors.comment)),
        "--colors=match:fg:" .. d(match_fg),
        "--colors=match:bg:" .. d(match_bg),
        "--colors=match:style:nobold",
        "",
    }, "\n")
end

return M
