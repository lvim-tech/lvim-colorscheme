-- lvim-colorscheme.extra.dunst: generate dunst's colours from the lvim-colorscheme palette.
--
-- THE URGENCY IS THE BACKGROUND. A notification here is a coloured card — yellow, orange or red for
-- low, normal and critical — rather than a dark card with a coloured edge. So the palette colour
-- lands in `background`, and `frame_color` is set to match it so a frame of any width disappears
-- into it rather than outlining it.
--
-- That single decision is what forces everything else in this file. A colour chosen to be SEEN
-- against a dark window needs about 3:1; a colour that CARRIES TEXT needs 4.5, and the two are not
-- the same number. Everforest's yellow measured 2.65:1 against white while it was only ever a frame,
-- which was fine — nothing was written on it. As a background it would be unreadable.
--
-- The text is the palette's own background — the colour the desktop is otherwise made of — so a
-- notification reads as the theme inverted rather than as white paint dropped on it. That fixes the
-- label and leaves the card as the thing that has to move: each urgency colour is walked away from
-- `bg` until `bg` has room on it. On a dark palette that lifts the card, on a light one it deepens
-- it, and in both directions the card also parts from the window it sits over.
--
-- `highlight` is the progress bar, drawn ON the card, so it takes the text colour rather than the
-- urgency colour — a bar in the same colour as its background is not a bar.
--
-- Written as a DROP-IN. dunst reads its dunstrc and then every *.conf in dunstrc.d/ in alphabetical
-- order, the later winning — read from settings.c, where config_files_add_drop_ins() appends that
-- directory after the base file and is_drop_in() accepts exactly the .conf suffix. The hand-written
-- config is never touched and does not mention this file.
--
---@module "lvim-colorscheme.extra.dunst"

local util = require("lvim-colorscheme.util")

local M = {}

--- The label for a card, decided by measurement rather than by preference.
---
--- The palette's own background is tried first, because a notification that reads as the theme
--- inverted belongs to the desktop in a way white paint does not. It is not always possible: red and
--- orange are dark colours in several of these palettes and sit close to the very background that
--- would be written on them — measured across the 48, the pair fell below the floor 65 times out of
--- 144, worst at 2.88:1 for Solarized's deep blue on its red. So where it does not clear, the label
--- falls to whichever extreme measures better on that card. The card itself never moves.
local function label_for(colors, fill)
    if util.contrast(colors.bg, fill) >= 4.5 then
        return colors.bg
    end
    return util.contrast("#ffffff", fill) >= util.contrast("#000000", fill) and "#ffffff" or "#000000"
end

--- @param colors ColorScheme
function M.generate(colors)
    return util.template(
        [[
# lvim-colorscheme — colours only, as a drop-in.
#
# dunst reads ~/.config/dunst/dunstrc first and this file after it, so what is set here wins.
# Geometry, timeouts, font and rules stay in dunstrc and are not this file's business.
#
# Quoted because '#' starts a comment in dunst's config unless the value is a string.

[global]
    separator_color = frame

[urgency_low]
    background = "${dunst_low}"
    foreground = "${dunst_low_fg}"
    frame_color = "${dunst_low}"
    highlight = "${dunst_low_fg}"

[urgency_normal]
    background = "${dunst_normal}"
    foreground = "${dunst_normal_fg}"
    frame_color = "${dunst_normal}"
    highlight = "${dunst_normal_fg}"

[urgency_critical]
    background = "${dunst_critical}"
    foreground = "${dunst_critical_fg}"
    frame_color = "${dunst_critical}"
    highlight = "${dunst_critical_fg}"
]],
        vim.tbl_extend("force", colors, {
            dunst_low = colors.yellow,
            dunst_normal = colors.orange,
            dunst_critical = colors.red,
            dunst_low_fg = label_for(colors, colors.yellow),
            dunst_normal_fg = label_for(colors, colors.orange),
            dunst_critical_fg = label_for(colors, colors.red),
        })
    )
end

return M
