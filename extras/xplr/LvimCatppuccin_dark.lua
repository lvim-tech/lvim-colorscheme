-- Lvim Colorscheme CatppuccinDark
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 208, 127, 186 } }
    c.cursor.style.fg = { Rgb = { 103, 147, 218 } }
    c.default_ui.style.fg = { Rgb = { 178, 183, 199 } }
    c.focus_ui.style = { fg = { Rgb = { 17, 17, 27 } }, bg = { Rgb = { 103, 147, 218 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 132, 194, 127 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 17, 17, 27 } }, bg = { Rgb = { 132, 194, 127 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 108, 115, 147 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 178, 183, 199 } }
    c.table.tree[1].style.fg = { Rgb = { 52, 54, 68 } }
    c.table.tree[2].style.fg = { Rgb = { 52, 54, 68 } }
    c.table.tree[3].style.fg = { Rgb = { 52, 54, 68 } }
    c.panel_ui.default.style.fg = { Rgb = { 178, 183, 199 } }
    c.panel_ui.table.style.fg = { Rgb = { 178, 183, 199 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 178, 183, 199 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 178, 183, 199 } }
    c.panel_ui.selection.style.fg = { Rgb = { 132, 194, 127 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 216, 185, 115 } }
    c.logs.info.style.fg = { Rgb = { 103, 147, 218 } }
    c.logs.success.style.fg = { Rgb = { 132, 194, 127 } }
    c.logs.warning.style.fg = { Rgb = { 216, 185, 115 } }
    c.logs.error.style.fg = { Rgb = { 211, 109, 137 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 103, 147, 218 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 178, 183, 199 } } }
    n.symlink.style = { fg = { Rgb = { 113, 190, 204 } }, add_modifiers = { "Italic" } }
end

return M
