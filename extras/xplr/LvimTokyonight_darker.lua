-- Lvim Colorscheme TokyonightDarker
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 148, 112, 213 } }
    c.cursor.style.fg = { Rgb = { 101, 137, 215 } }
    c.default_ui.style.fg = { Rgb = { 178, 182, 199 } }
    c.focus_ui.style = { fg = { Rgb = { 13, 13, 17 } }, bg = { Rgb = { 101, 137, 215 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 157, 189, 123 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 13, 13, 17 } }, bg = { Rgb = { 157, 189, 123 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 97, 103, 132 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 178, 182, 199 } }
    c.table.tree[1].style.fg = { Rgb = { 35, 39, 57 } }
    c.table.tree[2].style.fg = { Rgb = { 35, 39, 57 } }
    c.table.tree[3].style.fg = { Rgb = { 35, 39, 57 } }
    c.panel_ui.default.style.fg = { Rgb = { 178, 182, 199 } }
    c.panel_ui.table.style.fg = { Rgb = { 178, 182, 199 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 178, 182, 199 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 178, 182, 199 } }
    c.panel_ui.selection.style.fg = { Rgb = { 157, 189, 123 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 197, 160, 107 } }
    c.logs.info.style.fg = { Rgb = { 101, 137, 215 } }
    c.logs.success.style.fg = { Rgb = { 157, 189, 123 } }
    c.logs.warning.style.fg = { Rgb = { 197, 160, 107 } }
    c.logs.error.style.fg = { Rgb = { 215, 100, 121 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 101, 137, 215 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 178, 182, 199 } } }
    n.symlink.style = { fg = { Rgb = { 96, 176, 222 } }, add_modifiers = { "Italic" } }
end

return M
