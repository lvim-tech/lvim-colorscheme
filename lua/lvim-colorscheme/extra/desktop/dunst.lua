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
-- So each urgency colour is walked away from white until white has room on it, and white is then
-- the text. Both requirements pull the same way: further from white is also further from the
-- window, so the card stays distinct while becoming legible.
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

--- The card's own colour: the palette's, darkened only as far as a white label requires.
local function card(color)
    return util.ensure_contrast(color, "#ffffff", 4.5)
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
    foreground = "#ffffff"
    frame_color = "${dunst_low}"
    highlight = "#ffffff"

[urgency_normal]
    background = "${dunst_normal}"
    foreground = "#ffffff"
    frame_color = "${dunst_normal}"
    highlight = "#ffffff"

[urgency_critical]
    background = "${dunst_critical}"
    foreground = "#ffffff"
    frame_color = "${dunst_critical}"
    highlight = "#ffffff"
]],
        vim.tbl_extend("force", colors, {
            dunst_low = card(colors.yellow),
            dunst_normal = card(colors.orange),
            dunst_critical = card(colors.red),
        })
    )
end

return M
