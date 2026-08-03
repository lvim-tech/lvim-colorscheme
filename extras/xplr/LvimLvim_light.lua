-- Lvim Colorscheme LvimLight
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 188, 83, 60 } }
    c.cursor.style.fg = { Rgb = { 8, 121, 169 } }
    c.default_ui.style.fg = { Rgb = { 94, 136, 136 } }
    c.focus_ui.style = { fg = { Rgb = { 218, 218, 218 } }, bg = { Rgb = { 8, 121, 169 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 116, 140, 80 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 218, 218, 218 } }, bg = { Rgb = { 116, 140, 80 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 120, 150, 152 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 94, 136, 136 } }
    c.table.tree[1].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[2].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[3].style.fg = { Rgb = { 238, 238, 238 } }
    c.panel_ui.default.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.table.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.selection.style.fg = { Rgb = { 116, 140, 80 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 126, 101, 47 } }
    c.logs.info.style.fg = { Rgb = { 8, 121, 169 } }
    c.logs.success.style.fg = { Rgb = { 116, 140, 80 } }
    c.logs.warning.style.fg = { Rgb = { 126, 101, 47 } }
    c.logs.error.style.fg = { Rgb = { 172, 65, 53 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 8, 121, 169 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 94, 136, 136 } } }
    n.symlink.style = { fg = { Rgb = { 1, 119, 138 } }, add_modifiers = { "Italic" } }
end

return M
