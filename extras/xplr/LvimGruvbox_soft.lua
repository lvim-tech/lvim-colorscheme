-- Lvim Colorscheme GruvboxSoft
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 195, 121, 96 } }
    c.cursor.style.fg = { Rgb = { 75, 149, 186 } }
    c.default_ui.style.fg = { Rgb = { 155, 138, 121 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 73, 113, 136 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 140, 144, 69 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 117, 120, 69 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 161, 135, 112 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 155, 138, 121 } }
    c.table.tree[1].style.fg = { Rgb = { 44, 43, 42 } }
    c.table.tree[2].style.fg = { Rgb = { 44, 43, 42 } }
    c.table.tree[3].style.fg = { Rgb = { 44, 43, 42 } }
    c.panel_ui.default.style.fg = { Rgb = { 155, 138, 121 } }
    c.panel_ui.table.style.fg = { Rgb = { 155, 138, 121 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 155, 138, 121 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 155, 138, 121 } }
    c.panel_ui.selection.style.fg = { Rgb = { 140, 144, 69 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 175, 158, 107 } }
    c.logs.info.style.fg = { Rgb = { 75, 149, 186 } }
    c.logs.success.style.fg = { Rgb = { 140, 144, 69 } }
    c.logs.warning.style.fg = { Rgb = { 175, 158, 107 } }
    c.logs.error.style.fg = { Rgb = { 225, 102, 102 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 75, 149, 186 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 155, 138, 121 } } }
    n.symlink.style = { fg = { Rgb = { 93, 154, 101 } }, add_modifiers = { "Italic" } }
end

return M
