-- lvim-colorscheme.extra.gitui: generate a gitui theme from the palette.
--
--     mkdir -p ~/.config/gitui
--     ln -sf .../extras/gitui/LvimNord_dark.ron ~/.config/gitui/theme.ron
--     # or keep several and pick one: gitui -t LvimNord_dark.ron
--
-- RON, and every value must be wrapped in Some(...) — gitui merges partial
-- themes, so an unwrapped value is a parse error rather than a default.
--
-- `syntax` names a syntect theme for the blame/file view. It is left at the
-- bundled base16 default: bat's tmTheme from this same palette cannot be
-- referenced by name here, only by dropping the file next to theme.ron.
--
---@module "lvim-colorscheme.extra.git.gitui"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    return util.template(
        [[
// ${_style_name}
(
    selected_tab: Some("${blue}"),
    command_fg: Some("${fg}"),
    selection_bg: Some("${bg_highlight}"),
    selection_fg: Some("${fg_light}"),
    use_selection_fg: Some(true),
    cmdbar_bg: Some("${bg_dark}"),
    cmdbar_extra_lines_bg: Some("${bg_dark}"),
    disabled_fg: Some("${comment}"),
    diff_line_add: Some("${green}"),
    diff_line_delete: Some("${red}"),
    diff_file_added: Some("${green}"),
    diff_file_removed: Some("${red}"),
    diff_file_moved: Some("${purple}"),
    diff_file_modified: Some("${orange}"),
    commit_hash: Some("${purple}"),
    commit_time: Some("${yellow}"),
    commit_author: Some("${teal}"),
    danger_fg: Some("${red}"),
    push_gauge_bg: Some("${bg_light}"),
    push_gauge_fg: Some("${green}"),
    tag_fg: Some("${orange}"),
    branch_fg: Some("${magenta}"),
    block_title_focused: Some("${blue}"),
)
]],
        colors
    )
end

return M
