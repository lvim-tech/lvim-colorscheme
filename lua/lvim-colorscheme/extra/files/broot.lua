-- lvim-colorscheme.extra.broot: generate a broot skin from the palette.
--
--     ln -sf .../extras/broot/LvimNord_dark.hjson ~/.config/broot/lvim-skin.hjson
--     # then in conf.hjson: imports: [ lvim-skin.hjson ]
--
-- Every value is quoted because '#' starts a comment in Hjson — an unquoted
-- hex colour silently becomes an empty entry.
--
-- Each entry is "fg bg [attrs] / fg bg [attrs]": the half after the slash is
-- how the panel looks when it does NOT have focus, which is the whole reason
-- broot's two-panel view stays readable.
--
---@module "lvim-colorscheme.extra.files.broot"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    -- broot's rows are drawn on FOUR surfaces, not one. `default` paints the panel `bg_dark`, and
    -- `selected_line` sets only a *background* — `bg_highlight` in the focused panel and `bg` in
    -- the other — so every row colour below is also drawn on those two; `bg_light` is the third
    -- thing a status flag lands on. A colour that clears whichever of the four it is NEAREST to
    -- clears the rest, which is what `util.hardest` picks; the walk is repeated because a colour
    -- that starts INSIDE that cluster (`parent`'s unfocused half is literally `bg_light`) moves
    -- past one surface onto the next, and one pass would leave it there.
    --
    -- Measured across the 48 styles before this existed, 2201 of broot's 3024 text pairs were
    -- under WCAG AA's 4.5:1 — the unfocused parent row at **1.02:1** on rosepine_darker, which is
    -- a directory name the same colour as the panel behind it.
    local function ui(hex)
        local v = hex
        for _ = 1, 4 do
            v = util.ensure_contrast(
                v,
                util.hardest(v, colors.bg_dark, colors.bg, colors.bg_highlight, colors.bg_light),
                4.5
            )
        end
        return v
    end

    -- The two places broot paints an accent and writes on it. The accent must not move far — a
    -- status bar that is no longer red has stopped saying "error" — so the text is chosen from the
    -- two the theme has and the accent gives a step of hsluv lightness only where that is still
    -- not enough. Same shape as `extra/desktop/qutebrowser.lua`'s message strips; the hue is held,
    -- so the bar stays red and the command mark stays green.
    local error_fg = util.readable_on(colors.red, colors.bg_dark)
    local error_bg = util.ensure_contrast(colors.red, error_fg, 4.5)
    local mark_fg = util.readable_on(colors.green, colors.bg_dark)
    local mark_bg = util.ensure_contrast(colors.green, mark_fg, 4.5)

    local t = setmetatable({
        -- Deliberately NOT floored, one line of reason each:
        -- `tree` draws the ├── glyphs, which are structure and not words, and it is `bg_light`
        -- precisely so the names stand in front of it — `extra/files/lsd.lua` leaves its
        -- `tree-edge` for the same reason. It needs no entry here: every `bg*` key is left alone.
        -- `scrollbar_thumb` is the bar beside the panel rather than something written on it, and
        -- its two halves are the only uses of `blue` and `comment` in this file that are not text.
        br_scroll_thumb = colors.blue,
        br_scroll_thumb_nf = colors.comment,
        -- `parent`'s unfocused half is `bg_light` used as TEXT, which is the one place a `bg*` key
        -- has to move: it is the path of the directory above, and it is read.
        br_parent_nf = ui(colors.bg_light),
        br_status_error_fg = error_fg,
        br_status_error_bg = error_bg,
        br_mode_mark_fg = mark_fg,
        br_mode_mark_bg = mark_bg,
    }, {
        __index = function(_, k)
            local v = colors[k]
            if type(v) == "string" and v:match("^#%x%x%x%x%x%x$") and not k:match("^bg") then
                return ui(v)
            end
            return v
        end,
    })

    return util.template(
        [[
# ${_style_name}
{
    skin: {
        default: "${fg} ${bg_dark} / ${comment} ${bg_dark}"
        tree: "${bg_light} none / ${bg_light} none"
        parent: "${comment} none / ${br_parent_nf} none"
        file: "${fg} none / ${comment} none"
        directory: "${blue} none bold / ${comment} none bold"
        exe: "${green} none"
        link: "${cyan} none"
        pruning: "${comment} none italic"
        perm__: "${comment} none"
        perm_r: "${yellow} none"
        perm_w: "${red} none"
        perm_x: "${green} none"
        owner: "${teal} none"
        group: "${teal_dark} none"
        count: "${purple} none"
        dates: "${comment} none"
        sparse: "${yellow} none"
        content_extract: "${green} none"
        content_match: "${green} none bold"
        git_branch: "${magenta} none"
        git_insertions: "${green} none"
        git_deletions: "${red} none"
        git_status_current: "${comment} none"
        git_status_modified: "${orange} none"
        git_status_new: "${green} none bold"
        git_status_ignored: "${comment} none"
        git_status_conflicted: "${magenta} none"
        git_status_other: "${red} none"
        selected_line: "none ${bg_highlight} / none ${bg}"
        char_match: "${green} none"
        file_error: "${red} none"
        flag_label: "${comment} none"
        flag_value: "${orange} none bold"
        input: "${fg} none / ${comment} none"
        status_error: "${br_status_error_fg} ${br_status_error_bg}"
        status_job: "${orange} ${bg_light}"
        status_normal: "${fg} ${bg}"
        status_italic: "${orange} ${bg}"
        status_bold: "${orange} ${bg} bold"
        status_ellipsis: "${fg} ${bg}"
        purpose_normal: "${fg} ${bg}"
        purpose_italic: "${magenta} ${bg}"
        purpose_bold: "${magenta} ${bg} bold"
        purpose_ellipsis: "${fg} ${bg}"
        scrollbar_track: "${bg_light} none / ${bg} none"
        scrollbar_thumb: "${br_scroll_thumb} none / ${br_scroll_thumb_nf} none"
        help_paragraph: "${fg} none"
        help_bold: "${orange} none bold"
        help_italic: "${magenta} none italic"
        help_code: "${green} ${bg}"
        help_headers: "${orange} none"
        help_table_border: "${bg_light} none"
        preview: "${fg} ${bg_dark}"
        preview_title: "${fg} ${bg}"
        preview_line_number: "${comment} ${bg}"
        preview_match: "${green} none bold"
        hex_null: "${comment} none"
        hex_ascii_graphic: "${blue} none"
        hex_ascii_whitespace: "${green} none"
        hex_ascii_other: "${orange} none"
        hex_non_ascii: "${red} none"
        staging_area_title: "${fg} ${bg}"
        mode_command_mark: "${br_mode_mark_fg} ${br_mode_mark_bg} bold"
    }
}
]],
        t
    )
end

return M
