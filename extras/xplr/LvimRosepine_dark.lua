-- Lvim Colorscheme RosepineDark
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 144, 132, 162 } }
    c.cursor.style.fg = { Rgb = { 111, 135, 146 } }
    c.default_ui.style.fg = { Rgb = { 179, 175, 178 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 93, 109, 116 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 120, 139, 124 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 25, 23, 27 } }, bg = { Rgb = { 120, 139, 124 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 161, 118, 153 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 179, 175, 178 } }
    c.table.tree[1].style.fg = { Rgb = { 33, 31, 35 } }
    c.table.tree[2].style.fg = { Rgb = { 33, 31, 35 } }
    c.table.tree[3].style.fg = { Rgb = { 33, 31, 35 } }
    c.panel_ui.default.style.fg = { Rgb = { 179, 175, 178 } }
    c.panel_ui.table.style.fg = { Rgb = { 179, 175, 178 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 179, 175, 178 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 179, 175, 178 } }
    c.panel_ui.selection.style.fg = { Rgb = { 120, 139, 124 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 182, 161, 139 } }
    c.logs.info.style.fg = { Rgb = { 111, 135, 146 } }
    c.logs.success.style.fg = { Rgb = { 120, 139, 124 } }
    c.logs.warning.style.fg = { Rgb = { 182, 161, 139 } }
    c.logs.error.style.fg = { Rgb = { 167, 118, 129 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 111, 135, 146 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 179, 175, 178 } } }
    n.symlink.style = { fg = { Rgb = { 120, 135, 135 } }, add_modifiers = { "Italic" } }
end

return M
