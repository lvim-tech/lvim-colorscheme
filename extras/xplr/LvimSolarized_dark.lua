-- Lvim Colorscheme SolarizedDark
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 219, 100, 158 } }
    c.cursor.style.fg = { Rgb = { 80, 145, 193 } }
    c.default_ui.style.fg = { Rgb = { 157, 164, 164 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 78, 123, 159 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 133, 146, 57 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 112, 121, 62 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 120, 143, 151 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 157, 164, 164 } }
    c.table.tree[1].style.fg = { Rgb = { 4, 47, 58 } }
    c.table.tree[2].style.fg = { Rgb = { 4, 47, 58 } }
    c.table.tree[3].style.fg = { Rgb = { 4, 47, 58 } }
    c.panel_ui.default.style.fg = { Rgb = { 157, 164, 164 } }
    c.panel_ui.table.style.fg = { Rgb = { 157, 164, 164 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 157, 164, 164 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 157, 164, 164 } }
    c.panel_ui.selection.style.fg = { Rgb = { 133, 146, 57 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 166, 138, 73 } }
    c.logs.info.style.fg = { Rgb = { 80, 145, 193 } }
    c.logs.success.style.fg = { Rgb = { 133, 146, 57 } }
    c.logs.warning.style.fg = { Rgb = { 166, 138, 73 } }
    c.logs.error.style.fg = { Rgb = { 226, 99, 97 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 80, 145, 193 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 157, 164, 164 } } }
    n.symlink.style = { fg = { Rgb = { 75, 154, 147 } }, add_modifiers = { "Italic" } }
end

return M
