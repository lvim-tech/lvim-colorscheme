-- Lvim Colorscheme EverforestLight
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 137, 86, 69 } }
    c.cursor.style.fg = { Rgb = { 71, 102, 119 } }
    c.default_ui.style.fg = { Rgb = { 78, 103, 103 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 78, 123, 147 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 98, 100, 60 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 118, 121, 61 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 94, 101, 90 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 78, 103, 103 } }
    c.table.tree[1].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[2].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[3].style.fg = { Rgb = { 238, 238, 238 } }
    c.panel_ui.default.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.table.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.selection.style.fg = { Rgb = { 98, 100, 60 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 105, 97, 73 } }
    c.logs.info.style.fg = { Rgb = { 71, 102, 119 } }
    c.logs.success.style.fg = { Rgb = { 98, 100, 60 } }
    c.logs.warning.style.fg = { Rgb = { 105, 97, 73 } }
    c.logs.error.style.fg = { Rgb = { 159, 70, 70 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 71, 102, 119 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 78, 103, 103 } } }
    n.symlink.style = { fg = { Rgb = { 77, 105, 80 } }, add_modifiers = { "Italic" } }
end

return M
