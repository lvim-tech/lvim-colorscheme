-- Lvim Colorscheme MaterialDark
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 218, 89, 110 } }
    c.cursor.style.fg = { Rgb = { 97, 138, 223 } }
    c.default_ui.style.fg = { Rgb = { 178, 199, 199 } }
    c.focus_ui.style = { fg = { Rgb = { 26, 34, 38 } }, bg = { Rgb = { 97, 138, 223 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 166, 201, 116 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 26, 34, 38 } }, bg = { Rgb = { 166, 201, 116 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 94, 106, 112 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 178, 199, 199 } }
    c.table.tree[1].style.fg = { Rgb = { 49, 64, 71 } }
    c.table.tree[2].style.fg = { Rgb = { 49, 64, 71 } }
    c.table.tree[3].style.fg = { Rgb = { 49, 64, 71 } }
    c.panel_ui.default.style.fg = { Rgb = { 178, 199, 199 } }
    c.panel_ui.table.style.fg = { Rgb = { 178, 199, 199 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 178, 199, 199 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 178, 199, 199 } }
    c.panel_ui.selection.style.fg = { Rgb = { 166, 201, 116 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 222, 176, 92 } }
    c.logs.info.style.fg = { Rgb = { 97, 138, 223 } }
    c.logs.success.style.fg = { Rgb = { 166, 201, 116 } }
    c.logs.warning.style.fg = { Rgb = { 222, 176, 92 } }
    c.logs.error.style.fg = { Rgb = { 209, 103, 108 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 97, 138, 223 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 178, 199, 199 } } }
    n.symlink.style = { fg = { Rgb = { 99, 187, 223 } }, add_modifiers = { "Italic" } }
end

return M
