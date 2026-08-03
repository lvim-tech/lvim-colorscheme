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
    return util.template(
        [[
# ${_style_name}
{
    skin: {
        default: "${fg} ${bg_dark} / ${comment} ${bg_dark}"
        tree: "${bg_light} none / ${bg_light} none"
        parent: "${comment} none / ${bg_light} none"
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
        status_error: "${bg_dark} ${red}"
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
        scrollbar_thumb: "${blue} none / ${comment} none"
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
        mode_command_mark: "${bg_dark} ${green} bold"
    }
}
]],
        colors
    )
end

return M
