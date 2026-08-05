-- lvim-colorscheme.extra.dunst: generate dunst's colours from the lvim-colorscheme palette.
--
-- EVERY colour dunst has, and only colours. The list is not guessed: `dunst.5.pod` documents four
-- per-urgency attributes that carry one — background, foreground, frame_color and highlight — plus
-- separator_color in the global section. Twelve values and one keyword, which is the whole surface.
-- Everything else a dunstrc holds is about this desktop rather than about a palette: where the
-- notifications sit, how long they stay, which font, what a duplicate does.
--
-- Written as a DROP-IN, not as a dunstrc. dunst reads its config file and then everything in
-- `<dunstrc>.d/` in alphabetical order, later winning — read from settings.c, where
-- config_files_add_drop_ins() appends that directory's entries after the base file. So this lands in
-- ~/.config/dunst/dunstrc.d/ and overrides the colours without the hand-written file being touched
-- or even mentioning it.
--
-- THE FRAME ESCALATES, and that is the palette matching a decision already made: the hand-written
-- config this joins used amber, orange and red for low, normal and critical. Those are the palette's
-- yellow, orange and red, so the intent survives the theme changing under it.
--
-- `highlight` is the progress bar's colour. It takes the urgency's own colour rather than one fixed
-- accent, so a bar counting down on a critical notification is red and one on a low is not — the
-- urgency is legible without reading a word.
--
-- `separator_color` is left as the keyword `frame` rather than a colour: dunst then draws the
-- separator in whatever the notification's own frame is, which follows the urgency for free. A fixed
-- value here would be one colour pretending to serve three.
--
-- Contrast is measured, not inherited. An editor palette's foreground is soft on purpose and reads
-- around 2:1 against its own background — right for hours of code, wrong for a message that appears
-- for five seconds. Text is floored at 4.5; frames and bars at 3, the threshold for something that
-- has to be SEEN rather than read.
--
---@module "lvim-colorscheme.extra.dunst"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    local bg = colors.bg

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
    foreground = "${dunst_fg}"
    frame_color = "${dunst_low}"
    highlight = "${dunst_low}"

[urgency_normal]
    background = "${dunst_bg}"
    foreground = "${dunst_fg}"
    frame_color = "${dunst_normal}"
    highlight = "${dunst_normal}"

[urgency_critical]
    background = "${dunst_bg}"
    foreground = "${dunst_fg}"
    frame_color = "${dunst_critical}"
    highlight = "${dunst_critical}"
]],
        vim.tbl_extend("force", colors, {
            dunst_bg = bg,
            dunst_fg = util.ensure_contrast(colors.fg, bg, 4.5),
            dunst_low = util.ensure_contrast(colors.yellow, bg, 3),
            dunst_normal = util.ensure_contrast(colors.orange, bg, 3),
            dunst_critical = util.ensure_contrast(colors.red, bg, 3),
        })
    )
end

return M
