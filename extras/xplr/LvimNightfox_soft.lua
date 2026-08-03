-- Lvim Colorscheme NightfoxSoft
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 154, 128, 174 } }
    c.cursor.style.fg = { Rgb = { 104, 133, 173 } }
    c.default_ui.style.fg = { Rgb = { 188, 189, 189 } }
    c.focus_ui.style = { fg = { Rgb = { 25, 36, 51 } }, bg = { Rgb = { 104, 133, 173 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 123, 153, 138 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 25, 36, 51 } }, bg = { Rgb = { 123, 153, 138 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 117, 130, 146 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 188, 189, 189 } }
    c.table.tree[1].style.fg = { Rgb = { 33, 44, 59 } }
    c.table.tree[2].style.fg = { Rgb = { 33, 44, 59 } }
    c.table.tree[3].style.fg = { Rgb = { 33, 44, 59 } }
    c.panel_ui.default.style.fg = { Rgb = { 188, 189, 189 } }
    c.panel_ui.table.style.fg = { Rgb = { 188, 189, 189 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 188, 189, 189 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 188, 189, 189 } }
    c.panel_ui.selection.style.fg = { Rgb = { 123, 153, 138 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 187, 167, 111 } }
    c.logs.info.style.fg = { Rgb = { 104, 133, 173 } }
    c.logs.success.style.fg = { Rgb = { 123, 153, 138 } }
    c.logs.warning.style.fg = { Rgb = { 187, 167, 111 } }
    c.logs.error.style.fg = { Rgb = { 178, 99, 119 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 104, 133, 173 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 188, 189, 189 } } }
    n.symlink.style = { fg = { Rgb = { 105, 163, 164 } }, add_modifiers = { "Italic" } }
end

return M
