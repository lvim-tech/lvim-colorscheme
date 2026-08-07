-- Lvim Colorscheme NordSoft
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 167, 139, 162 } }
    c.cursor.style.fg = { Rgb = { 124, 149, 175 } }
    c.default_ui.style.fg = { Rgb = { 179, 186, 198 } }
    c.focus_ui.style = { fg = { Rgb = { 36, 41, 52 } }, bg = { Rgb = { 122, 147, 172 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 135, 153, 120 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 36, 41, 52 } }, bg = { Rgb = { 135, 153, 120 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 130, 146, 178 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 179, 186, 198 } }
    c.table.tree[1].style.fg = { Rgb = { 44, 49, 60 } }
    c.table.tree[2].style.fg = { Rgb = { 44, 49, 60 } }
    c.table.tree[3].style.fg = { Rgb = { 44, 49, 60 } }
    c.panel_ui.default.style.fg = { Rgb = { 179, 186, 198 } }
    c.panel_ui.table.style.fg = { Rgb = { 179, 186, 198 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 179, 186, 198 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 179, 186, 198 } }
    c.panel_ui.selection.style.fg = { Rgb = { 135, 153, 120 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 195, 168, 112 } }
    c.logs.info.style.fg = { Rgb = { 124, 149, 175 } }
    c.logs.success.style.fg = { Rgb = { 135, 153, 120 } }
    c.logs.warning.style.fg = { Rgb = { 195, 168, 112 } }
    c.logs.error.style.fg = { Rgb = { 188, 133, 138 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 124, 149, 175 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 179, 186, 198 } } }
    n.symlink.style = { fg = { Rgb = { 113, 154, 166 } }, add_modifiers = { "Italic" } }
end

return M
