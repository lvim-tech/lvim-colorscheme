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
    -- Text here lands on the TERMINAL's background, which this project themes from the same
    -- palette -- so `terminal.background` is the honest surface rather than a guess. The palette's
    -- own `terminal.*` entries are never re-floored: ANSI 0-15 is a measured hierarchy of its own
    -- in `colors/init.lua` and a second floor on top would undo it.
    --
    -- `push_gauge_fg`/`push_gauge_bg` are left verbatim: a progress gauge is a filled bar with no
    -- words on it. `cmdbar_bg`, `selection_bg` and `bg_light` are surfaces, not text.
    local function text(hex, bg)
        return util.ensure_contrast(hex, bg or colors.terminal.background, 4.5)
    end
    local t = vim.tbl_extend("force", colors, {
        gu_tab = text(colors.blue),
        -- The command bar and the selected row paint their own backgrounds.
        gu_command = text(colors.fg, colors.bg_dark),
        gu_selection = text(colors.fg_light, colors.bg_highlight),
        gu_disabled = text(colors.comment),
        gu_green = text(colors.green), gu_red = text(colors.red),
        gu_purple = text(colors.purple), gu_orange = text(colors.orange),
        gu_yellow = text(colors.yellow), gu_teal = text(colors.teal),
        gu_magenta = text(colors.magenta),
    })
    return util.template(
        [[
// ${_style_name}
(
    selected_tab: Some("${gu_tab}"),
    command_fg: Some("${gu_command}"),
    selection_bg: Some("${bg_highlight}"),
    selection_fg: Some("${gu_selection}"),
    use_selection_fg: Some(true),
    cmdbar_bg: Some("${bg_dark}"),
    cmdbar_extra_lines_bg: Some("${bg_dark}"),
    disabled_fg: Some("${gu_disabled}"),
    diff_line_add: Some("${gu_green}"),
    diff_line_delete: Some("${gu_red}"),
    diff_file_added: Some("${gu_green}"),
    diff_file_removed: Some("${gu_red}"),
    diff_file_moved: Some("${gu_purple}"),
    diff_file_modified: Some("${gu_orange}"),
    commit_hash: Some("${gu_purple}"),
    commit_time: Some("${gu_yellow}"),
    commit_author: Some("${gu_teal}"),
    danger_fg: Some("${gu_red}"),
    push_gauge_bg: Some("${bg_light}"),
    push_gauge_fg: Some("${green}"),
    tag_fg: Some("${gu_orange}"),
    branch_fg: Some("${gu_magenta}"),
    block_title_focused: Some("${gu_tab}"),
)
]],
        t
    )
end

return M
