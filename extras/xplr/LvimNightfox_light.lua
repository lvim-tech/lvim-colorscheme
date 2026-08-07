-- Lvim Colorscheme NightfoxLight
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 114, 88, 132 } }
    c.cursor.style.fg = { Rgb = { 78, 99, 127 } }
    c.default_ui.style.fg = { Rgb = { 78, 103, 103 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 84, 109, 142 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 87, 102, 94 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 101, 123, 112 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 90, 98, 110 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 78, 103, 103 } }
    c.table.tree[1].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[2].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[3].style.fg = { Rgb = { 238, 238, 238 } }
    c.panel_ui.default.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.table.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.selection.style.fg = { Rgb = { 87, 102, 94 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 108, 97, 71 } }
    c.logs.info.style.fg = { Rgb = { 78, 99, 127 } }
    c.logs.success.style.fg = { Rgb = { 87, 102, 94 } }
    c.logs.warning.style.fg = { Rgb = { 108, 97, 71 } }
    c.logs.error.style.fg = { Rgb = { 137, 82, 96 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 78, 99, 127 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 78, 103, 103 } } }
    n.symlink.style = { fg = { Rgb = { 76, 103, 104 } }, add_modifiers = { "Italic" } }
end

return M
