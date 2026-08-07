-- Lvim Colorscheme BaseLight
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 152, 78, 64 } }
    c.cursor.style.fg = { Rgb = { 66, 101, 127 } }
    c.default_ui.style.fg = { Rgb = { 78, 103, 103 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 69, 122, 159 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 85, 103, 60 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 85, 103, 60 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 87, 102, 103 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 78, 103, 103 } }
    c.table.tree[1].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[2].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[3].style.fg = { Rgb = { 238, 238, 238 } }
    c.panel_ui.default.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.table.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.selection.style.fg = { Rgb = { 85, 103, 60 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 114, 96, 63 } }
    c.logs.info.style.fg = { Rgb = { 66, 101, 127 } }
    c.logs.success.style.fg = { Rgb = { 85, 103, 60 } }
    c.logs.warning.style.fg = { Rgb = { 114, 96, 63 } }
    c.logs.error.style.fg = { Rgb = { 159, 72, 63 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 66, 101, 127 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 78, 103, 103 } } }
    n.symlink.style = { fg = { Rgb = { 62, 105, 117 } }, add_modifiers = { "Italic" } }
end

return M
