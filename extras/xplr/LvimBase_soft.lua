-- Lvim Colorscheme BaseSoft
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 232, 107, 80 } }
    c.cursor.style.fg = { Rgb = { 57, 155, 211 } }
    c.default_ui.style.fg = { Rgb = { 101, 156, 156 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 68, 124, 162 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 128, 153, 91 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 34, 41, 45 } }, bg = { Rgb = { 128, 153, 91 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 104, 153, 155 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 101, 156, 156 } }
    c.table.tree[1].style.fg = { Rgb = { 42, 49, 53 } }
    c.table.tree[2].style.fg = { Rgb = { 42, 49, 53 } }
    c.table.tree[3].style.fg = { Rgb = { 42, 49, 53 } }
    c.panel_ui.default.style.fg = { Rgb = { 101, 156, 156 } }
    c.panel_ui.table.style.fg = { Rgb = { 101, 156, 156 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 101, 156, 156 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 101, 156, 156 } }
    c.panel_ui.selection.style.fg = { Rgb = { 128, 153, 91 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 216, 179, 111 } }
    c.logs.info.style.fg = { Rgb = { 57, 155, 211 } }
    c.logs.success.style.fg = { Rgb = { 128, 153, 91 } }
    c.logs.warning.style.fg = { Rgb = { 216, 179, 111 } }
    c.logs.error.style.fg = { Rgb = { 228, 109, 98 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 57, 155, 211 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 101, 156, 156 } } }
    n.symlink.style = { fg = { Rgb = { 62, 157, 177 } }, add_modifiers = { "Italic" } }
end

return M
