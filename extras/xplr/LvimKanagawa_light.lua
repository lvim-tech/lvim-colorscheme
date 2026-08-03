-- Lvim Colorscheme KanagawaLight
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 146, 83, 78 } }
    c.cursor.style.fg = { Rgb = { 99, 134, 196 } }
    c.default_ui.style.fg = { Rgb = { 94, 136, 136 } }
    c.focus_ui.style = { fg = { Rgb = { 218, 218, 218 } }, bg = { Rgb = { 99, 134, 196 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 103, 121, 81 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 218, 218, 218 } }, bg = { Rgb = { 103, 121, 81 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 157, 157, 181 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 94, 136, 136 } }
    c.table.tree[1].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[2].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[3].style.fg = { Rgb = { 238, 238, 238 } }
    c.panel_ui.default.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.table.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.selection.style.fg = { Rgb = { 103, 121, 81 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 119, 103, 69 } }
    c.logs.info.style.fg = { Rgb = { 99, 134, 196 } }
    c.logs.success.style.fg = { Rgb = { 103, 121, 81 } }
    c.logs.warning.style.fg = { Rgb = { 119, 103, 69 } }
    c.logs.error.style.fg = { Rgb = { 200, 91, 91 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 99, 134, 196 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 94, 136, 136 } } }
    n.symlink.style = { fg = { Rgb = { 93, 128, 122 } }, add_modifiers = { "Italic" } }
end

return M
