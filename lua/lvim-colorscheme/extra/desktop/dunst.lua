-- lvim-colorscheme.extra.dunst: generate dunst's colours from the lvim-colorscheme palette.
--
-- THE CARD IS THE THEME'S OWN BACKGROUND and carries no frame. The urgency is told by the TITLE,
-- which takes the palette's yellow, orange or red, while the body stays neutral — so the colour is
-- a word rather than a wall, and a stack of notifications reads as one surface.
--
-- A frame is not an option here even where it might suit: dunst's `frame_width` is a single number
-- for all four sides, and nothing in its settings table names a side — checked against
-- settings_data.h, which has frame_width, frame_color, corners and corner_radius, and no more.
-- A line under the notification alone cannot be asked for.
--
-- COLOURING THE TITLE APART FROM THE BODY takes a rule, not an urgency section. Urgency sections
-- accept only background, foreground, highlight, timeout, frame_color and icon; `format` is a rule
-- attribute, so each urgency gets a named rule matching on msg_urgency. And it has to be `format`:
-- markup there is parsed whatever `markup` is set to, while markup arriving inside a notification's
-- own text is subject to it and comes out as literal `<span …>` — measured, on this machine, before
-- this file was written.
--
-- The body takes the palette's own foreground on its own background — the pairing every other
-- window here already uses, so a notification reads as part of the desktop rather than apart from it.

--
-- Written as a DROP-IN. dunst reads its dunstrc and then every *.conf in dunstrc.d/ in alphabetical
-- order, the later winning — config_files_add_drop_ins() in settings.c, with is_drop_in() accepting
-- exactly the .conf suffix.
--
---@module "lvim-colorscheme.extra.dunst"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    local bg = colors.bg

    -- The body: the palette's own foreground on its own background, the pairing the rest of the
    -- desktop already uses.
    local body = colors.fg

    -- A title is text, so it is held to the text floor rather than to the 3:1 a coloured edge would
    -- have needed. The palette's own hue survives — ensure_contrast moves lightness in hsluv and
    -- leaves hue and saturation where the palette put them.
    local function title(color)
        return util.ensure_contrast(color, bg, 4.5)
    end

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
    background = "${dunst_bg}"
    foreground = "${dunst_body}"
    frame_color = "${dunst_bg}"
    highlight = "${dunst_low}"

[urgency_normal]
    background = "${dunst_bg}"
    foreground = "${dunst_body}"
    frame_color = "${dunst_bg}"
    highlight = "${dunst_normal}"

[urgency_critical]
    background = "${dunst_bg}"
    foreground = "${dunst_body}"
    frame_color = "${dunst_bg}"
    highlight = "${dunst_critical}"

# The title, coloured by urgency. These are rules rather than urgency sections because `format` is
# a rule attribute; the filter is what an urgency section would have had implied.

[lvim_title_low]
    msg_urgency = low
    format = "<span foreground='${dunst_low}'><b>%s</b></span>\n%b"

[lvim_title_normal]
    msg_urgency = normal
    format = "<span foreground='${dunst_normal}'><b>%s</b></span>\n%b"

[lvim_title_critical]
    msg_urgency = critical
    format = "<span foreground='${dunst_critical}'><b>%s</b></span>\n%b"
]],
        vim.tbl_extend("force", colors, {
            dunst_bg = bg,
            dunst_body = body,
            dunst_low = title(colors.yellow),
            dunst_normal = title(colors.orange),
            dunst_critical = title(colors.red),
        })
    )
end

return M
