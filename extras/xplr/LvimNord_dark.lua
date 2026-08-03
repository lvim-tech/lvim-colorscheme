-- Lvim Colorscheme NordDark
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 162, 134, 157 } }
    c.cursor.style.fg = { Rgb = { 115, 136, 158 } }
    c.default_ui.style.fg = { Rgb = { 179, 186, 198 } }
    c.focus_ui.style = { fg = { Rgb = { 31, 36, 45 } }, bg = { Rgb = { 115, 136, 158 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 135, 153, 120 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 31, 36, 45 } }, bg = { Rgb = { 135, 153, 120 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 103, 113, 133 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 179, 186, 198 } }
    c.table.tree[1].style.fg = { Rgb = { 39, 44, 53 } }
    c.table.tree[2].style.fg = { Rgb = { 39, 44, 53 } }
    c.table.tree[3].style.fg = { Rgb = { 39, 44, 53 } }
    c.panel_ui.default.style.fg = { Rgb = { 179, 186, 198 } }
    c.panel_ui.table.style.fg = { Rgb = { 179, 186, 198 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 179, 186, 198 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 179, 186, 198 } }
    c.panel_ui.selection.style.fg = { Rgb = { 135, 153, 120 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 195, 168, 112 } }
    c.logs.info.style.fg = { Rgb = { 115, 136, 158 } }
    c.logs.success.style.fg = { Rgb = { 135, 153, 120 } }
    c.logs.warning.style.fg = { Rgb = { 195, 168, 112 } }
    c.logs.error.style.fg = { Rgb = { 172, 110, 116 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 115, 136, 158 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 179, 186, 198 } } }
    n.symlink.style = { fg = { Rgb = { 112, 151, 163 } }, add_modifiers = { "Italic" } }
end

return M
