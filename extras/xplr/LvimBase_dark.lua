-- Lvim Colorscheme BaseDark
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 222, 104, 78 } }
    c.cursor.style.fg = { Rgb = { 62, 146, 197 } }
    c.default_ui.style.fg = { Rgb = { 98, 147, 147 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 68, 124, 162 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 126, 150, 90 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 28, 35, 39 } }, bg = { Rgb = { 126, 150, 90 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 101, 147, 149 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 98, 147, 147 } }
    c.table.tree[1].style.fg = { Rgb = { 36, 43, 47 } }
    c.table.tree[2].style.fg = { Rgb = { 36, 43, 47 } }
    c.table.tree[3].style.fg = { Rgb = { 36, 43, 47 } }
    c.panel_ui.default.style.fg = { Rgb = { 98, 147, 147 } }
    c.panel_ui.table.style.fg = { Rgb = { 98, 147, 147 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 98, 147, 147 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 98, 147, 147 } }
    c.panel_ui.selection.style.fg = { Rgb = { 126, 150, 90 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 216, 179, 111 } }
    c.logs.info.style.fg = { Rgb = { 62, 146, 197 } }
    c.logs.success.style.fg = { Rgb = { 126, 150, 90 } }
    c.logs.warning.style.fg = { Rgb = { 216, 179, 111 } }
    c.logs.error.style.fg = { Rgb = { 225, 101, 90 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 62, 146, 197 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 98, 147, 147 } } }
    n.symlink.style = { fg = { Rgb = { 64, 151, 170 } }, add_modifiers = { "Italic" } }
end

return M
