-- lvim-colorscheme.extra.gdu: generate a gdu colour config from the
-- lvim-colorscheme palette.
--
-- gdu reads one YAML file, `~/.config/gdu/gdu.yaml`, so the generated files
-- are meant to be symlinked:
--
--     mkdir -p ~/.config/gdu
--     ln -sf .../extras/gdu/LvimNord_dark.yaml ~/.config/gdu/gdu.yaml
--
-- Only the `style:` block is written; every behaviour key gdu understands
-- (sorting, ignore paths, `no-cross`, ...) keeps its default, which is what a
-- colour scheme should do. `gdu --write-config` dumps the full set if you want
-- to keep settings alongside — merge them into a copy.
--
-- Colours are tcell values: W3C names or "#rrggbb", and the hex form MUST be
-- quoted or YAML reads it as a comment. gdu styles only about a dozen
-- elements; everything it does not name keeps the terminal's own colours, so
-- the result deliberately leans on the terminal palette rather than painting
-- every cell.
--
---@module "lvim-colorscheme.extra.gdu"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    return util.template(
        [[
style:
    selected-row:
        text-color: "${bg_dark}"
        background-color: "${blue}"
    marked:
        text-color: "${bg_dark}"
        background-color: "${orange}"
    footer:
        text-color: "${bg_dark}"
        background-color: "${green}"
        number-color: "${bg_dark}"
    header:
        text-color: "${bg_dark}"
        background-color: "${purple}"
        hidden: false
    result-row:
        number-color: "${yellow}"
        directory-color: "${blue}"
    progress-modal:
        border-color: "${blue}"
        text-color: "${fg}"
]],
        colors
    )
end

return M
