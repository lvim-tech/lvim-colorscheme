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
      "keys": "${blue}",
      "title": "${magenta}",
      "output": "${fg}",
      "separator": "${comment}"
    }
  }
}
]],
        colors
    )
end

return M
