-- Lvim Colorscheme DraculaDark
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 193, 114, 156 } }
    c.cursor.style.fg = { Rgb = { 104, 148, 160 } }
    c.default_ui.style.fg = { Rgb = { 199, 199, 179 } }
    c.focus_ui.style = { fg = { Rgb = { 32, 34, 44 } }, bg = { Rgb = { 103, 145, 156 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 99, 153, 111 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 32, 34, 44 } }, bg = { Rgb = { 98, 150, 109 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 132, 140, 170 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 199, 199, 179 } }
    c.table.tree[1].style.fg = { Rgb = { 40, 42, 52 } }
    c.table.tree[2].style.fg = { Rgb = { 40, 42, 52 } }
    c.table.tree[3].style.fg = { Rgb = { 40, 42, 52 } }
    c.panel_ui.default.style.fg = { Rgb = { 199, 199, 179 } }
    c.panel_ui.table.style.fg = { Rgb = { 199, 199, 179 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 199, 199, 179 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 199, 199, 179 } }
    c.panel_ui.selection.style.fg = { Rgb = { 99, 153, 111 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 173, 178, 126 } }
    c.logs.info.style.fg = { Rgb = { 104, 148, 160 } }
    c.logs.success.style.fg = { Rgb = { 99, 153, 111 } }
    c.logs.warning.style.fg = { Rgb = { 173, 178, 126 } }
    c.logs.error.style.fg = { Rgb = { 204, 117, 117 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 104, 148, 160 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 199, 199, 179 } } }
    n.symlink.style = { fg = { Rgb = { 103, 150, 141 } }, add_modifiers = { "Italic" } }
end

return M
