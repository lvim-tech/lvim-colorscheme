-- Lvim Colorscheme NordDarker
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 165, 138, 160 } }
    c.cursor.style.fg = { Rgb = { 128, 151, 175 } }
    c.default_ui.style.fg = { Rgb = { 179, 186, 198 } }
    c.focus_ui.style = { fg = { Rgb = { 20, 23, 28 } }, bg = { Rgb = { 128, 151, 175 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 151, 171, 134 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 20, 23, 28 } }, bg = { Rgb = { 151, 171, 134 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 103, 113, 133 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 179, 186, 198 } }
    c.table.tree[1].style.fg = { Rgb = { 44, 50, 61 } }
    c.table.tree[2].style.fg = { Rgb = { 44, 50, 61 } }
    c.table.tree[3].style.fg = { Rgb = { 44, 50, 61 } }
    c.panel_ui.default.style.fg = { Rgb = { 179, 186, 198 } }
    c.panel_ui.table.style.fg = { Rgb = { 179, 186, 198 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 179, 186, 198 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 179, 186, 198 } }
    c.panel_ui.selection.style.fg = { Rgb = { 151, 171, 134 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 203, 174, 114 } }
    c.logs.info.style.fg = { Rgb = { 128, 151, 175 } }
    c.logs.success.style.fg = { Rgb = { 151, 171, 134 } }
    c.logs.warning.style.fg = { Rgb = { 203, 174, 114 } }
    c.logs.error.style.fg = { Rgb = { 175, 113, 119 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 128, 151, 175 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 179, 186, 198 } } }
    n.symlink.style = { fg = { Rgb = { 126, 170, 183 } }, add_modifiers = { "Italic" } }
end

return M
