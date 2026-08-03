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

local M = {}

local function rgb(hex)
    local r, g, b = ansi.rgb(hex)
    return string.format("{ rgb = { r = %d, g = %d, b = %d } }", r, g, b)
end

--- @param colors ColorScheme
function M.generate(colors)
    return table.concat({
        "[style.description]",
        "foreground = " .. rgb(colors.fg),
        "",
        "[style.command_name]",
        "foreground = " .. rgb(colors.blue),
        "bold = true",
        "",
        "[style.example_text]",
        "foreground = " .. rgb(colors.comment),
        "",
        "[style.example_code]",
        "foreground = " .. rgb(colors.green),
        "",
        "[style.example_variable]",
        "foreground = " .. rgb(colors.orange),
        "italic = true",
        "",
    }, "\n")
end

return M
