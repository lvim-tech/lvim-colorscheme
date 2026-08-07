-- Lvim Colorscheme KanagawaLight
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 140, 81, 76 } }
    c.cursor.style.fg = { Rgb = { 80, 98, 133 } }
    c.default_ui.style.fg = { Rgb = { 78, 103, 103 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 92, 118, 167 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 89, 102, 72 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 105, 123, 81 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 96, 96, 119 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 78, 103, 103 } }
    c.table.tree[1].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[2].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[3].style.fg = { Rgb = { 238, 238, 238 } }
    c.panel_ui.default.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.table.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.selection.style.fg = { Rgb = { 89, 102, 72 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 111, 97, 69 } }
    c.logs.info.style.fg = { Rgb = { 80, 98, 133 } }
    c.logs.success.style.fg = { Rgb = { 89, 102, 72 } }
    c.logs.warning.style.fg = { Rgb = { 111, 97, 69 } }
    c.logs.error.style.fg = { Rgb = { 148, 76, 76 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 80, 98, 133 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 78, 103, 103 } } }
    n.symlink.style = { fg = { Rgb = { 80, 103, 98 } }, add_modifiers = { "Italic" } }
end

return M
