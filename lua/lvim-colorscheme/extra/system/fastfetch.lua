-- lvim-colorscheme.extra.fastfetch: generate a fastfetch colour config from the
-- lvim-colorscheme palette.
--
-- fastfetch reads one JSONC file, `~/.config/fastfetch/config.jsonc`, so the
-- generated files are meant to be symlinked:
--
--     mkdir -p ~/.config/fastfetch
--     ln -sf .../extras/fastfetch/LvimNord_dark.jsonc ~/.config/fastfetch/config.jsonc
--
-- Only `logo.color` and `display.color` are written, and no `modules` array:
-- omitting it keeps fastfetch's own module selection, which is the part a
-- colour scheme has no business freezing. Anything else you configure has to
-- live in a copy of the generated file.
--
-- Hex is accepted since fastfetch 2.42 and needs a truecolor terminal; on an
-- older build or a 16-colour terminal these keys are ignored rather than
-- fatal, so the file stays valid either way.
--
---@module "lvim-colorscheme.extra.fastfetch"

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
    -- Only `display.color` is floored. `logo.color` paints the ASCII art beside the output — a
    -- picture drawn out of characters, not a label anyone reads — and lifting its six colours to a
    -- text floor would flatten the distinction the logo is made of.
    local function text(hex)
        return util.ensure_contrast(hex, colors.terminal.background, 4.5)
    end
    local t = vim.tbl_extend("force", colors, {
        ff_keys = text(colors.blue),
        ff_title = text(colors.magenta),
        ff_output = text(colors.fg),
        ff_separator = text(colors.comment),
    })
    return util.template(
        [[
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "color": {
      "1": "${blue}",
      "2": "${purple}",
      "3": "${green}",
      "4": "${yellow}",
      "5": "${red}",
      "6": "${teal}"
    }
  },
  "display": {
    "color": {
      "keys": "${ff_keys}",
      "title": "${ff_title}",
      "output": "${ff_output}",
      "separator": "${ff_separator}"
    }
  }
}
]],
        t
    )
end

return M
