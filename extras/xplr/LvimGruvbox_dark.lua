-- Lvim Colorscheme GruvboxDark
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 187, 117, 94 } }
    c.cursor.style.fg = { Rgb = { 76, 144, 178 } }
    c.default_ui.style.fg = { Rgb = { 149, 133, 117 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 73, 113, 136 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 135, 139, 70 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 117, 120, 69 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 155, 131, 109 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 149, 133, 117 } }
    c.table.tree[1].style.fg = { Rgb = { 38, 37, 36 } }
    c.table.tree[2].style.fg = { Rgb = { 38, 37, 36 } }
    c.table.tree[3].style.fg = { Rgb = { 38, 37, 36 } }
    c.panel_ui.default.style.fg = { Rgb = { 149, 133, 117 } }
    c.panel_ui.table.style.fg = { Rgb = { 149, 133, 117 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 149, 133, 117 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 149, 133, 117 } }
    c.panel_ui.selection.style.fg = { Rgb = { 135, 139, 70 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 175, 158, 107 } }
    c.logs.info.style.fg = { Rgb = { 76, 144, 178 } }
    c.logs.success.style.fg = { Rgb = { 135, 139, 70 } }
    c.logs.warning.style.fg = { Rgb = { 175, 158, 107 } }
    c.logs.error.style.fg = { Rgb = { 222, 94, 94 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 76, 144, 178 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 149, 133, 117 } } }
    n.symlink.style = { fg = { Rgb = { 91, 148, 99 } }, add_modifiers = { "Italic" } }
end

return M
