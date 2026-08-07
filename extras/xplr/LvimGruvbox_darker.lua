-- Lvim Colorscheme GruvboxDarker
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 187, 117, 94 } }
    c.cursor.style.fg = { Rgb = { 76, 138, 170 } }
    c.default_ui.style.fg = { Rgb = { 146, 131, 115 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 73, 113, 136 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 132, 136, 70 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 117, 120, 69 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 152, 128, 107 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 146, 131, 115 } }
    c.table.tree[1].style.fg = { Rgb = { 34, 33, 32 } }
    c.table.tree[2].style.fg = { Rgb = { 34, 33, 32 } }
    c.table.tree[3].style.fg = { Rgb = { 34, 33, 32 } }
    c.panel_ui.default.style.fg = { Rgb = { 146, 131, 115 } }
    c.panel_ui.table.style.fg = { Rgb = { 146, 131, 115 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 146, 131, 115 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 146, 131, 115 } }
    c.panel_ui.selection.style.fg = { Rgb = { 132, 136, 70 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 175, 158, 107 } }
    c.logs.info.style.fg = { Rgb = { 76, 138, 170 } }
    c.logs.success.style.fg = { Rgb = { 132, 136, 70 } }
    c.logs.warning.style.fg = { Rgb = { 175, 158, 107 } }
    c.logs.error.style.fg = { Rgb = { 220, 90, 90 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 76, 138, 170 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 146, 131, 115 } } }
    n.symlink.style = { fg = { Rgb = { 90, 145, 98 } }, add_modifiers = { "Italic" } }
end

return M
