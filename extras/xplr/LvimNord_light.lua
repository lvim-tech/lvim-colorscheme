-- Lvim Colorscheme NordLight
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 110, 90, 107 } }
    c.cursor.style.fg = { Rgb = { 84, 98, 114 } }
    c.default_ui.style.fg = { Rgb = { 78, 103, 103 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 89, 106, 124 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 91, 100, 84 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 109, 121, 98 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 91, 98, 113 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 78, 103, 103 } }
    c.table.tree[1].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[2].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[3].style.fg = { Rgb = { 238, 238, 238 } }
    c.panel_ui.default.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.table.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.selection.style.fg = { Rgb = { 91, 100, 84 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 111, 97, 70 } }
    c.logs.info.style.fg = { Rgb = { 84, 98, 114 } }
    c.logs.success.style.fg = { Rgb = { 91, 100, 84 } }
    c.logs.warning.style.fg = { Rgb = { 111, 97, 70 } }
    c.logs.error.style.fg = { Rgb = { 132, 87, 91 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 84, 98, 114 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 78, 103, 103 } } }
    n.symlink.style = { fg = { Rgb = { 83, 102, 109 } }, add_modifiers = { "Italic" } }
end

return M
