-- lvim-colorscheme.extra.rofi: generate a rofi colour file from the lvim-colorscheme palette.
--
-- FOUR COLOURS, and nothing else. rofi themes in the wild are written as a `*` block that names a
-- few semantic colours and a pile of layout rules that reference them — `@bg`, `@fg` and so on. Only
-- the first half changes with a palette; widths, padding, which widgets exist and how many columns a
-- listview has are decisions about a person's desktop, not about a colour scheme. So this file emits
-- the colours under exactly those names, and the theme that imports it keeps everything else:
--
--     @import "~/.config/rofi/colors.rasi"
--     * { background-color: @bg; text-color: @fg; }
--     element selected { background-color: @selected-bg; text-color: @selected-fg; }
--
-- Alpha is written out (the `ff` suffix) because rofi themes conventionally carry it and a file that
-- mixes #rrggbb with #rrggbbaa reads as though the difference means something.
--
-- NOTHING IS COPIED FROM THE PALETTE UNCHANGED, and the first draft proved why. It set `fg` to the
-- palette's own foreground — soft, made for reading code for hours — which MEASURED 2.03:1 against
-- the window on Kanagawa soft, and a selection of `bg_visual` on `bg` came out at 1.02:1: a
-- highlight invisible on all 48 palettes. A launcher is read in a glance, so every colour here is
-- walked to a floor: text 4.5, the selection's label 4.5, the selection itself 3 against the window.
--
---@module "lvim-colorscheme.extra.rofi"

local util = require("lvim-colorscheme.util")

local M = {}

--- Render #rrggbb as #rrggbbff, the form rofi themes are written in.
local function opaque(hex)
    return hex .. "ff"
end

--- @param colors ColorScheme
function M.generate(colors)
    local bg = colors.bg

    -- The selection has two jobs: stand off the window, and carry a label.
    --
    -- Green: the palette's own, and the same family lvim-gtk draws its accent from, so a selected
    -- row in the launcher and a selected row in a file manager are one colour rather than two
    -- opinions about what "selected" looks like.
    local sel_bg = util.ensure_contrast(colors.green, bg, 3)

    -- The label is WHITE, always, and the fill is derived to deserve it.
    --
    -- Standing off the window is only the first requirement and it leaves the fill wherever it
    -- lands, which for `green` is often pale: MEASURED across the 48, white on it fell under the
    -- floor 34 times. Letting the label pick its own side instead — black where black measures
    -- better — makes it readable and inconsistent, a launcher whose selected row is dark-on-green
    -- in one palette and light-on-green in the next.
    --
    -- So the fill is walked away from white until white has room, which also carries it further
    -- from a light window and no further from a dark one than it already had to be. The
    -- hand-written everforest theme this file is modelled on arrived at the same place by eye:
    -- #527A57 carries white at 4.7:1. That agreement is the check that this is a property of the
    -- colour rather than a preference about it.
    sel_bg = util.ensure_contrast(sel_bg, "#ffffff", 4.5)

    return util.template(
        [[
/* lvim-colorscheme — colours only.
 *
 * Import this from your own theme and keep the layout there:
 *
 *     @import "~/.config/rofi/colors.rasi"
 */

* {
    bg:           ${rofi_bg};
    fg:           ${rofi_fg};
    selected-bg:  ${rofi_sel_bg};
    selected-fg:  ${rofi_sel_fg};
}
]],
        vim.tbl_extend("force", colors, {
            rofi_bg = opaque(bg),
            rofi_fg = opaque(util.ensure_contrast(colors.fg, bg, 4.5)),
            rofi_sel_bg = opaque(sel_bg),
            rofi_sel_fg = opaque("#ffffff"),
        })
    )
end

return M
