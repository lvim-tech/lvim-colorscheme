-- Lvim Colorscheme LvimSoft
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 198, 97, 77 } }
    c.cursor.style.fg = { Rgb = { 68, 124, 162 } }
    c.default_ui.style.fg = { Rgb = { 94, 136, 136 } }
    c.focus_ui.style = { fg = { Rgb = { 34, 41, 45 } }, bg = { Rgb = { 68, 124, 162 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 126, 150, 90 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 34, 41, 45 } }, bg = { Rgb = { 126, 150, 90 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 77, 98, 99 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 94, 136, 136 } }
    c.table.tree[1].style.fg = { Rgb = { 42, 49, 53 } }
    c.table.tree[2].style.fg = { Rgb = { 42, 49, 53 } }
    c.table.tree[3].style.fg = { Rgb = { 42, 49, 53 } }
    c.panel_ui.default.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.table.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.selection.style.fg = { Rgb = { 126, 150, 90 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 216, 179, 111 } }
    c.logs.info.style.fg = { Rgb = { 68, 124, 162 } }
    c.logs.success.style.fg = { Rgb = { 126, 150, 90 } }
    c.logs.warning.style.fg = { Rgb = { 216, 179, 111 } }
    c.logs.error.style.fg = { Rgb = { 215, 94, 82 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 68, 124, 162 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 94, 136, 136 } } }
    n.symlink.style = { fg = { Rgb = { 68, 133, 149 } }, add_modifiers = { "Italic" } }
end

return M
