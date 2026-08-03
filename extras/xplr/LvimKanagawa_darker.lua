-- Lvim Colorscheme KanagawaDarker
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 196, 116, 110 } }
    c.cursor.style.fg = { Rgb = { 77, 105, 155 } }
    c.default_ui.style.fg = { Rgb = { 84, 84, 109 } }
    c.focus_ui.style = { fg = { Rgb = { 19, 20, 24 } }, bg = { Rgb = { 77, 105, 155 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 110, 129, 86 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 19, 20, 24 } }, bg = { Rgb = { 110, 129, 86 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 78, 78, 115 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 84, 84, 109 } }
    c.table.tree[1].style.fg = { Rgb = { 37, 38, 46 } }
    c.table.tree[2].style.fg = { Rgb = { 37, 38, 46 } }
    c.table.tree[3].style.fg = { Rgb = { 37, 38, 46 } }
    c.panel_ui.default.style.fg = { Rgb = { 84, 84, 109 } }
    c.panel_ui.table.style.fg = { Rgb = { 84, 84, 109 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 84, 84, 109 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 84, 84, 109 } }
    c.panel_ui.selection.style.fg = { Rgb = { 110, 129, 86 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 224, 194, 134 } }
    c.logs.info.style.fg = { Rgb = { 77, 105, 155 } }
    c.logs.success.style.fg = { Rgb = { 110, 129, 86 } }
    c.logs.warning.style.fg = { Rgb = { 224, 194, 134 } }
    c.logs.error.style.fg = { Rgb = { 182, 82, 82 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 77, 105, 155 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 84, 84, 109 } } }
    n.symlink.style = { fg = { Rgb = { 89, 123, 117 } }, add_modifiers = { "Italic" } }
end

return M
