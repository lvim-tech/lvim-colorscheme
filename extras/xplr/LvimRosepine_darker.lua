-- Lvim Colorscheme RosepineDarker
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 159, 128, 196 } }
    c.cursor.style.fg = { Rgb = { 65, 109, 127 } }
    c.default_ui.style.fg = { Rgb = { 180, 178, 199 } }
    c.focus_ui.style = { fg = { Rgb = { 10, 9, 16 } }, bg = { Rgb = { 65, 109, 127 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 131, 178, 186 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 10, 9, 16 } }, bg = { Rgb = { 131, 178, 186 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 116, 110, 145 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 180, 178, 199 } }
    c.table.tree[1].style.fg = { Rgb = { 47, 44, 60 } }
    c.table.tree[2].style.fg = { Rgb = { 47, 44, 60 } }
    c.table.tree[3].style.fg = { Rgb = { 47, 44, 60 } }
    c.panel_ui.default.style.fg = { Rgb = { 180, 178, 199 } }
    c.panel_ui.table.style.fg = { Rgb = { 180, 178, 199 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 180, 178, 199 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 180, 178, 199 } }
    c.panel_ui.selection.style.fg = { Rgb = { 131, 178, 186 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 214, 167, 101 } }
    c.logs.info.style.fg = { Rgb = { 65, 109, 127 } }
    c.logs.success.style.fg = { Rgb = { 131, 178, 186 } }
    c.logs.warning.style.fg = { Rgb = { 214, 167, 101 } }
    c.logs.error.style.fg = { Rgb = { 205, 105, 133 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 65, 109, 127 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 180, 178, 199 } } }
    n.symlink.style = { fg = { Rgb = { 131, 178, 186 } }, add_modifiers = { "Italic" } }
end

return M
