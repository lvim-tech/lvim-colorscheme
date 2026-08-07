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
    -- Every styled element in gdu is an accent BACKGROUND with words on it, so the text is chosen
    -- from the two the theme has and the accent gives a step of hsluv lightness only where that
    -- still cannot reach 4.5:1 — the hue is held, so the selected row stays blue and the header
    -- stays purple. Measured beforehand, `bg_dark` on `green` read at 3.31:1 in the footer.
    --
    -- `result-row` and `progress-modal` are the exception: gdu paints no background for those, so
    -- they sit on the terminal's, which this project themes from the same palette.
    -- `border-color` is not floored — a frame is drawn, not read.
    local term = colors.terminal.background
    local function on(accent)
        return util.readable_on(accent, colors.bg_dark)
    end
    local function strip(accent)
        return util.ensure_contrast(accent, on(accent), 4.5)
    end
    local t = vim.tbl_extend("force", colors, {
        g_on_blue = on(colors.blue), g_blue = strip(colors.blue),
        g_on_orange = on(colors.orange), g_orange = strip(colors.orange),
        g_on_green = on(colors.green), g_green = strip(colors.green),
        g_on_purple = on(colors.purple), g_purple = strip(colors.purple),
        g_number = util.ensure_contrast(colors.yellow, term, 4.5),
        g_directory = util.ensure_contrast(colors.blue, term, 4.5),
        g_modal_text = util.ensure_contrast(colors.fg, term, 4.5),
    })
    return util.template(
        [[
style:
    selected-row:
        text-color: "${g_on_blue}"
        background-color: "${g_blue}"
    marked:
        text-color: "${g_on_orange}"
        background-color: "${g_orange}"
    footer:
        text-color: "${g_on_green}"
        background-color: "${g_green}"
        number-color: "${g_on_green}"
    header:
        text-color: "${g_on_purple}"
        background-color: "${g_purple}"
        hidden: false
    result-row:
        number-color: "${g_number}"
        directory-color: "${g_directory}"
    progress-modal:
        border-color: "${blue}"
        text-color: "${g_modal_text}"
]],
        t
    )
end

return M
