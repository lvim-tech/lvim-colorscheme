-- lvim-colorscheme.extra.tealdeer: generate a tealdeer colour config from the
-- lvim-colorscheme palette.
--
--     mkdir -p ~/.config/tealdeer
--     ln -sf .../extras/tealdeer/LvimNord_dark.toml ~/.config/tealdeer/config.toml
--
-- Only `[style.*]` blocks are written. tealdeer's other sections (`[display]`,
-- `[updates]`, `[directories]`) keep their defaults — run `tldr
-- --seed-config` first and merge if you want them.
--
-- Colours go in as `{ rgb = { r, g, b } }`, supported since 1.5.0; the named
-- and `{ ansi = n }` forms exist but would throw away the palette.
--
---@module "lvim-colorscheme.extra.tealdeer"

local ansi = require("lvim-colorscheme.extra.ansi")
local util = require("lvim-colorscheme.util")

local M = {}

local function rgb(hex)
    local r, g, b = ansi.rgb(hex)
    return string.format("{ rgb = { r = %d, g = %d, b = %d } }", r, g, b)
end

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
    -- Every one of the five styles below is text on a man page: a description, a command name, an
    -- example line, a snippet and a variable inside it. There is nothing here that is not read.
    local function text(hex)
        return util.ensure_contrast(hex, colors.terminal.background, 4.5)
    end
    return table.concat({
        "[style.description]",
        "foreground = " .. rgb(text(colors.fg)),
        "",
        "[style.command_name]",
        "foreground = " .. rgb(text(colors.blue)),
        "bold = true",
        "",
        "[style.example_text]",
        "foreground = " .. rgb(text(colors.comment)),
        "",
        "[style.example_code]",
        "foreground = " .. rgb(text(colors.green)),
        "",
        "[style.example_variable]",
        "foreground = " .. rgb(text(colors.orange)),
        "italic = true",
        "",
    }, "\n")
end

return M
