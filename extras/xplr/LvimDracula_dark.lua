-- Lvim Colorscheme DraculaDark
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 220, 97, 168 } }
    c.cursor.style.fg = { Rgb = { 101, 200, 221 } }
    c.default_ui.style.fg = { Rgb = { 199, 199, 179 } }
    c.focus_ui.style = { fg = { Rgb = { 27, 29, 37 } }, bg = { Rgb = { 101, 200, 221 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 88, 216, 121 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 27, 29, 37 } }, bg = { Rgb = { 88, 216, 121 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 114, 122, 152 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 199, 199, 179 } }
    c.table.tree[1].style.fg = { Rgb = { 52, 54, 68 } }
    c.table.tree[2].style.fg = { Rgb = { 52, 54, 68 } }
    c.table.tree[3].style.fg = { Rgb = { 52, 54, 68 } }
    c.panel_ui.default.style.fg = { Rgb = { 199, 199, 179 } }
    c.panel_ui.table.style.fg = { Rgb = { 199, 199, 179 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 199, 199, 179 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 199, 199, 179 } }
    c.panel_ui.selection.style.fg = { Rgb = { 88, 216, 121 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 208, 218, 104 } }
    c.logs.info.style.fg = { Rgb = { 101, 200, 221 } }
    c.logs.success.style.fg = { Rgb = { 88, 216, 121 } }
    c.logs.warning.style.fg = { Rgb = { 208, 218, 104 } }
    c.logs.error.style.fg = { Rgb = { 221, 87, 87 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 101, 200, 221 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 199, 199, 179 } } }
    n.symlink.style = { fg = { Rgb = { 97, 223, 202 } }, add_modifiers = { "Italic" } }
end

return M
