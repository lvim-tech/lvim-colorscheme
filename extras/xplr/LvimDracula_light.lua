-- Lvim Colorscheme DraculaLight
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 136, 79, 110 } }
    c.cursor.style.fg = { Rgb = { 76, 101, 109 } }
    c.default_ui.style.fg = { Rgb = { 78, 103, 103 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 81, 112, 121 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 69, 106, 77 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 70, 109, 78 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 92, 97, 119 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 78, 103, 103 } }
    c.table.tree[1].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[2].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[3].style.fg = { Rgb = { 238, 238, 238 } }
    c.panel_ui.default.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.table.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.selection.style.fg = { Rgb = { 69, 106, 77 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 97, 100, 75 } }
    c.logs.info.style.fg = { Rgb = { 76, 101, 109 } }
    c.logs.success.style.fg = { Rgb = { 69, 106, 77 } }
    c.logs.warning.style.fg = { Rgb = { 97, 100, 75 } }
    c.logs.error.style.fg = { Rgb = { 144, 79, 79 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 76, 101, 109 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 78, 103, 103 } } }
    n.symlink.style = { fg = { Rgb = { 72, 104, 98 } }, add_modifiers = { "Italic" } }
end

return M
