-- Lvim Colorscheme KanagawaDarker
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 196, 114, 108 } }
    c.cursor.style.fg = { Rgb = { 85, 131, 205 } }
    c.default_ui.style.fg = { Rgb = { 128, 128, 159 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 78, 106, 156 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 116, 138, 88 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 106, 124, 83 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 129, 129, 178 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 128, 128, 159 } }
    c.table.tree[1].style.fg = { Rgb = { 32, 33, 39 } }
    c.table.tree[2].style.fg = { Rgb = { 32, 33, 39 } }
    c.table.tree[3].style.fg = { Rgb = { 32, 33, 39 } }
    c.panel_ui.default.style.fg = { Rgb = { 128, 128, 159 } }
    c.panel_ui.table.style.fg = { Rgb = { 128, 128, 159 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 128, 128, 159 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 128, 128, 159 } }
    c.panel_ui.selection.style.fg = { Rgb = { 116, 138, 88 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 209, 181, 124 } }
    c.logs.info.style.fg = { Rgb = { 85, 131, 205 } }
    c.logs.success.style.fg = { Rgb = { 116, 138, 88 } }
    c.logs.warning.style.fg = { Rgb = { 209, 181, 124 } }
    c.logs.error.style.fg = { Rgb = { 211, 95, 95 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 85, 131, 205 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 128, 128, 159 } } }
    n.symlink.style = { fg = { Rgb = { 95, 139, 131 } }, add_modifiers = { "Italic" } }
end

return M
