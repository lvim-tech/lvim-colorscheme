-- Lvim Colorscheme GruvboxDarker
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 187, 117, 94 } }
    c.cursor.style.fg = { Rgb = { 66, 114, 139 } }
    c.default_ui.style.fg = { Rgb = { 100, 92, 84 } }
    c.focus_ui.style = { fg = { Rgb = { 20, 19, 16 } }, bg = { Rgb = { 66, 114, 139 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 117, 120, 58 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 20, 19, 16 } }, bg = { Rgb = { 117, 120, 58 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 100, 88, 78 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 100, 92, 84 } }
    c.table.tree[1].style.fg = { Rgb = { 49, 46, 45 } }
    c.table.tree[2].style.fg = { Rgb = { 49, 46, 45 } }
    c.table.tree[3].style.fg = { Rgb = { 49, 46, 45 } }
    c.panel_ui.default.style.fg = { Rgb = { 100, 92, 84 } }
    c.panel_ui.table.style.fg = { Rgb = { 100, 92, 84 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 100, 92, 84 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 100, 92, 84 } }
    c.panel_ui.selection.style.fg = { Rgb = { 117, 120, 58 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 175, 158, 107 } }
    c.logs.info.style.fg = { Rgb = { 66, 114, 139 } }
    c.logs.success.style.fg = { Rgb = { 117, 120, 58 } }
    c.logs.warning.style.fg = { Rgb = { 175, 158, 107 } }
    c.logs.error.style.fg = { Rgb = { 203, 79, 79 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 66, 114, 139 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 100, 92, 84 } } }
    n.symlink.style = { fg = { Rgb = { 82, 122, 87 } }, add_modifiers = { "Italic" } }
end

return M
