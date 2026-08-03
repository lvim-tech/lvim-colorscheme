-- Lvim Colorscheme LvimDarker
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 199, 89, 64 } }
    c.cursor.style.fg = { Rgb = { 10, 133, 185 } }
    c.default_ui.style.fg = { Rgb = { 94, 136, 136 } }
    c.focus_ui.style = { fg = { Rgb = { 20, 24, 25 } }, bg = { Rgb = { 10, 133, 185 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 138, 165, 95 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 20, 24, 25 } }, bg = { Rgb = { 138, 165, 95 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 77, 98, 99 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 94, 136, 136 } }
    c.table.tree[1].style.fg = { Rgb = { 50, 60, 67 } }
    c.table.tree[2].style.fg = { Rgb = { 50, 60, 67 } }
    c.table.tree[3].style.fg = { Rgb = { 50, 60, 67 } }
    c.panel_ui.default.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.table.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.selection.style.fg = { Rgb = { 138, 165, 95 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 237, 192, 96 } }
    c.logs.info.style.fg = { Rgb = { 10, 133, 185 } }
    c.logs.success.style.fg = { Rgb = { 138, 165, 95 } }
    c.logs.warning.style.fg = { Rgb = { 237, 192, 96 } }
    c.logs.error.style.fg = { Rgb = { 230, 94, 79 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 10, 133, 185 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 94, 136, 136 } } }
    n.symlink.style = { fg = { Rgb = { 1, 143, 166 } }, add_modifiers = { "Italic" } }
end

return M
