-- Lvim Colorscheme SolarizedDark
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 183, 82, 131 } }
    c.cursor.style.fg = { Rgb = { 67, 134, 181 } }
    c.default_ui.style.fg = { Rgb = { 157, 164, 164 } }
    c.focus_ui.style = { fg = { Rgb = { 0, 31, 39 } }, bg = { Rgb = { 67, 134, 181 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 114, 127, 26 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 0, 31, 39 } }, bg = { Rgb = { 114, 127, 26 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 93, 106, 111 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 157, 164, 164 } }
    c.table.tree[1].style.fg = { Rgb = { 14, 75, 89 } }
    c.table.tree[2].style.fg = { Rgb = { 14, 75, 89 } }
    c.table.tree[3].style.fg = { Rgb = { 14, 75, 89 } }
    c.panel_ui.default.style.fg = { Rgb = { 157, 164, 164 } }
    c.panel_ui.table.style.fg = { Rgb = { 157, 164, 164 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 157, 164, 164 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 157, 164, 164 } }
    c.panel_ui.selection.style.fg = { Rgb = { 114, 127, 26 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 150, 121, 31 } }
    c.logs.info.style.fg = { Rgb = { 67, 134, 181 } }
    c.logs.success.style.fg = { Rgb = { 114, 127, 26 } }
    c.logs.warning.style.fg = { Rgb = { 150, 121, 31 } }
    c.logs.error.style.fg = { Rgb = { 191, 78, 76 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 67, 134, 181 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 157, 164, 164 } } }
    n.symlink.style = { fg = { Rgb = { 62, 141, 135 } }, add_modifiers = { "Italic" } }
end

return M
