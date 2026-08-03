-- Lvim Colorscheme SolarizedDarker
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 192, 87, 138 } }
    c.cursor.style.fg = { Rgb = { 79, 126, 163 } }
    c.default_ui.style.fg = { Rgb = { 157, 164, 164 } }
    c.focus_ui.style = { fg = { Rgb = { 0, 27, 35 } }, bg = { Rgb = { 79, 126, 163 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 114, 124, 62 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 0, 27, 35 } }, bg = { Rgb = { 114, 124, 62 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 93, 106, 111 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 157, 164, 164 } }
    c.table.tree[1].style.fg = { Rgb = { 4, 35, 43 } }
    c.table.tree[2].style.fg = { Rgb = { 4, 35, 43 } }
    c.table.tree[3].style.fg = { Rgb = { 4, 35, 43 } }
    c.panel_ui.default.style.fg = { Rgb = { 157, 164, 164 } }
    c.panel_ui.table.style.fg = { Rgb = { 157, 164, 164 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 157, 164, 164 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 157, 164, 164 } }
    c.panel_ui.selection.style.fg = { Rgb = { 114, 124, 62 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 159, 133, 73 } }
    c.logs.info.style.fg = { Rgb = { 79, 126, 163 } }
    c.logs.success.style.fg = { Rgb = { 114, 124, 62 } }
    c.logs.warning.style.fg = { Rgb = { 159, 133, 73 } }
    c.logs.error.style.fg = { Rgb = { 194, 79, 77 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 79, 126, 163 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 157, 164, 164 } } }
    n.symlink.style = { fg = { Rgb = { 75, 133, 128 } }, add_modifiers = { "Italic" } }
end

return M
