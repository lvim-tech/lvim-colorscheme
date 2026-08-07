-- Lvim Colorscheme BaseDarker
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 213, 101, 78 } }
    c.cursor.style.fg = { Rgb = { 65, 141, 188 } }
    c.default_ui.style.fg = { Rgb = { 96, 142, 142 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 68, 124, 162 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 126, 150, 90 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 24, 30, 33 } }, bg = { Rgb = { 126, 150, 90 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 99, 142, 143 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 96, 142, 142 } }
    c.table.tree[1].style.fg = { Rgb = { 32, 38, 41 } }
    c.table.tree[2].style.fg = { Rgb = { 32, 38, 41 } }
    c.table.tree[3].style.fg = { Rgb = { 32, 38, 41 } }
    c.panel_ui.default.style.fg = { Rgb = { 96, 142, 142 } }
    c.panel_ui.table.style.fg = { Rgb = { 96, 142, 142 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 96, 142, 142 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 96, 142, 142 } }
    c.panel_ui.selection.style.fg = { Rgb = { 126, 150, 90 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 216, 179, 111 } }
    c.logs.info.style.fg = { Rgb = { 65, 141, 188 } }
    c.logs.success.style.fg = { Rgb = { 126, 150, 90 } }
    c.logs.warning.style.fg = { Rgb = { 216, 179, 111 } }
    c.logs.error.style.fg = { Rgb = { 220, 95, 82 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 65, 141, 188 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 96, 142, 142 } } }
    n.symlink.style = { fg = { Rgb = { 66, 145, 163 } }, add_modifiers = { "Italic" } }
end

return M
