-- Lvim Colorscheme EverforestSoft
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 204, 125, 98 } }
    c.cursor.style.fg = { Rgb = { 55, 154, 195 } }
    c.default_ui.style.fg = { Rgb = { 134, 150, 130 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 66, 114, 139 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 146, 150, 45 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 117, 120, 58 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 128, 152, 115 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 134, 150, 130 } }
    c.table.tree[1].style.fg = { Rgb = { 50, 57, 63 } }
    c.table.tree[2].style.fg = { Rgb = { 50, 57, 63 } }
    c.table.tree[3].style.fg = { Rgb = { 50, 57, 63 } }
    c.panel_ui.default.style.fg = { Rgb = { 134, 150, 130 } }
    c.panel_ui.table.style.fg = { Rgb = { 134, 150, 130 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 134, 150, 130 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 134, 150, 130 } }
    c.panel_ui.selection.style.fg = { Rgb = { 146, 150, 45 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 175, 158, 107 } }
    c.logs.info.style.fg = { Rgb = { 55, 154, 195 } }
    c.logs.success.style.fg = { Rgb = { 146, 150, 45 } }
    c.logs.warning.style.fg = { Rgb = { 175, 158, 107 } }
    c.logs.error.style.fg = { Rgb = { 227, 106, 106 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 55, 154, 195 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 134, 150, 130 } } }
    n.symlink.style = { fg = { Rgb = { 94, 160, 103 } }, add_modifiers = { "Italic" } }
end

return M
