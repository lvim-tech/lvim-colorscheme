-- Lvim Colorscheme NordLight
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 110, 90, 107 } }
    c.cursor.style.fg = { Rgb = { 89, 106, 124 } }
    c.default_ui.style.fg = { Rgb = { 94, 136, 136 } }
    c.focus_ui.style = { fg = { Rgb = { 218, 218, 218 } }, bg = { Rgb = { 89, 106, 124 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 126, 143, 112 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 218, 218, 218 } }, bg = { Rgb = { 126, 143, 112 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 115, 125, 149 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 94, 136, 136 } }
    c.table.tree[1].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[2].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[3].style.fg = { Rgb = { 238, 238, 238 } }
    c.panel_ui.default.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.table.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.selection.style.fg = { Rgb = { 126, 143, 112 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 139, 119, 78 } }
    c.logs.info.style.fg = { Rgb = { 89, 106, 124 } }
    c.logs.success.style.fg = { Rgb = { 126, 143, 112 } }
    c.logs.warning.style.fg = { Rgb = { 139, 119, 78 } }
    c.logs.error.style.fg = { Rgb = { 151, 96, 101 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 89, 106, 124 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 94, 136, 136 } } }
    n.symlink.style = { fg = { Rgb = { 108, 145, 157 } }, add_modifiers = { "Italic" } }
end

return M
