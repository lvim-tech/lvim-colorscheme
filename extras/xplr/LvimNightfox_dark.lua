-- Lvim Colorscheme NightfoxDark
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 155, 130, 175 } }
    c.cursor.style.fg = { Rgb = { 114, 146, 189 } }
    c.default_ui.style.fg = { Rgb = { 188, 189, 189 } }
    c.focus_ui.style = { fg = { Rgb = { 19, 26, 36 } }, bg = { Rgb = { 114, 146, 189 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 137, 170, 154 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 19, 26, 36 } }, bg = { Rgb = { 137, 170, 154 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 117, 130, 146 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 188, 189, 189 } }
    c.table.tree[1].style.fg = { Rgb = { 41, 57, 79 } }
    c.table.tree[2].style.fg = { Rgb = { 41, 57, 79 } }
    c.table.tree[3].style.fg = { Rgb = { 41, 57, 79 } }
    c.panel_ui.default.style.fg = { Rgb = { 188, 189, 189 } }
    c.panel_ui.table.style.fg = { Rgb = { 188, 189, 189 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 188, 189, 189 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 188, 189, 189 } }
    c.panel_ui.selection.style.fg = { Rgb = { 137, 170, 154 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 193, 172, 113 } }
    c.logs.info.style.fg = { Rgb = { 114, 146, 189 } }
    c.logs.success.style.fg = { Rgb = { 137, 170, 154 } }
    c.logs.warning.style.fg = { Rgb = { 193, 172, 113 } }
    c.logs.error.style.fg = { Rgb = { 180, 100, 120 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 114, 146, 189 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 188, 189, 189 } } }
    n.symlink.style = { fg = { Rgb = { 117, 187, 189 } }, add_modifiers = { "Italic" } }
end

return M
