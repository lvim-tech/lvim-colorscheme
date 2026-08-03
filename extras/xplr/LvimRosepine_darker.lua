-- Lvim Colorscheme RosepineDarker
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 144, 132, 162 } }
    c.cursor.style.fg = { Rgb = { 93, 109, 116 } }
    c.default_ui.style.fg = { Rgb = { 179, 175, 178 } }
    c.focus_ui.style = { fg = { Rgb = { 19, 17, 21 } }, bg = { Rgb = { 93, 109, 116 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 120, 139, 124 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 19, 17, 21 } }, bg = { Rgb = { 120, 139, 124 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 137, 104, 130 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 179, 175, 178 } }
    c.table.tree[1].style.fg = { Rgb = { 27, 25, 29 } }
    c.table.tree[2].style.fg = { Rgb = { 27, 25, 29 } }
    c.table.tree[3].style.fg = { Rgb = { 27, 25, 29 } }
    c.panel_ui.default.style.fg = { Rgb = { 179, 175, 178 } }
    c.panel_ui.table.style.fg = { Rgb = { 179, 175, 178 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 179, 175, 178 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 179, 175, 178 } }
    c.panel_ui.selection.style.fg = { Rgb = { 120, 139, 124 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 182, 161, 139 } }
    c.logs.info.style.fg = { Rgb = { 93, 109, 116 } }
    c.logs.success.style.fg = { Rgb = { 120, 139, 124 } }
    c.logs.warning.style.fg = { Rgb = { 182, 161, 139 } }
    c.logs.error.style.fg = { Rgb = { 160, 114, 124 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 93, 109, 116 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 179, 175, 178 } } }
    n.symlink.style = { fg = { Rgb = { 120, 135, 135 } }, add_modifiers = { "Italic" } }
end

return M
