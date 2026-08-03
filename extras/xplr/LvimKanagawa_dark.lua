-- Lvim Colorscheme KanagawaDark
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 196, 114, 108 } }
    c.cursor.style.fg = { Rgb = { 78, 106, 156 } }
    c.default_ui.style.fg = { Rgb = { 84, 84, 109 } }
    c.focus_ui.style = { fg = { Rgb = { 28, 29, 35 } }, bg = { Rgb = { 78, 106, 156 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 108, 127, 84 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 28, 29, 35 } }, bg = { Rgb = { 108, 127, 84 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 78, 78, 115 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 84, 84, 109 } }
    c.table.tree[1].style.fg = { Rgb = { 36, 37, 43 } }
    c.table.tree[2].style.fg = { Rgb = { 36, 37, 43 } }
    c.table.tree[3].style.fg = { Rgb = { 36, 37, 43 } }
    c.panel_ui.default.style.fg = { Rgb = { 84, 84, 109 } }
    c.panel_ui.table.style.fg = { Rgb = { 84, 84, 109 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 84, 84, 109 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 84, 84, 109 } }
    c.panel_ui.selection.style.fg = { Rgb = { 108, 127, 84 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 209, 181, 124 } }
    c.logs.info.style.fg = { Rgb = { 78, 106, 156 } }
    c.logs.success.style.fg = { Rgb = { 108, 127, 84 } }
    c.logs.warning.style.fg = { Rgb = { 209, 181, 124 } }
    c.logs.error.style.fg = { Rgb = { 186, 84, 84 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 78, 106, 156 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 84, 84, 109 } } }
    n.symlink.style = { fg = { Rgb = { 88, 122, 116 } }, add_modifiers = { "Italic" } }
end

return M
