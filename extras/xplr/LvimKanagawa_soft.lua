-- Lvim Colorscheme KanagawaSoft
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 199, 121, 115 } }
    c.cursor.style.fg = { Rgb = { 87, 142, 224 } }
    c.default_ui.style.fg = { Rgb = { 138, 138, 169 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 78, 106, 156 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 124, 149, 91 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 106, 124, 83 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 137, 137, 185 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 138, 138, 169 } }
    c.table.tree[1].style.fg = { Rgb = { 42, 43, 49 } }
    c.table.tree[2].style.fg = { Rgb = { 42, 43, 49 } }
    c.table.tree[3].style.fg = { Rgb = { 42, 43, 49 } }
    c.panel_ui.default.style.fg = { Rgb = { 138, 138, 169 } }
    c.panel_ui.table.style.fg = { Rgb = { 138, 138, 169 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 138, 138, 169 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 138, 138, 169 } }
    c.panel_ui.selection.style.fg = { Rgb = { 124, 149, 91 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 209, 181, 124 } }
    c.logs.info.style.fg = { Rgb = { 87, 142, 224 } }
    c.logs.success.style.fg = { Rgb = { 124, 149, 91 } }
    c.logs.warning.style.fg = { Rgb = { 209, 181, 124 } }
    c.logs.error.style.fg = { Rgb = { 217, 109, 109 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 87, 142, 224 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 138, 138, 169 } } }
    n.symlink.style = { fg = { Rgb = { 100, 150, 142 } }, add_modifiers = { "Italic" } }
end

return M
