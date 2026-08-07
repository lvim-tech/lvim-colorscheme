-- Lvim Colorscheme MaterialDarker
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 218, 101, 118 } }
    c.cursor.style.fg = { Rgb = { 97, 135, 214 } }
    c.default_ui.style.fg = { Rgb = { 178, 199, 199 } }
    c.focus_ui.style = { fg = { Rgb = { 24, 33, 37 } }, bg = { Rgb = { 97, 135, 214 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 144, 173, 104 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 24, 33, 37 } }, bg = { Rgb = { 144, 173, 104 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 120, 140, 150 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 178, 199, 199 } }
    c.table.tree[1].style.fg = { Rgb = { 32, 41, 45 } }
    c.table.tree[2].style.fg = { Rgb = { 32, 41, 45 } }
    c.table.tree[3].style.fg = { Rgb = { 32, 41, 45 } }
    c.panel_ui.default.style.fg = { Rgb = { 178, 199, 199 } }
    c.panel_ui.table.style.fg = { Rgb = { 178, 199, 199 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 178, 199, 199 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 178, 199, 199 } }
    c.panel_ui.selection.style.fg = { Rgb = { 144, 173, 104 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 207, 169, 106 } }
    c.logs.info.style.fg = { Rgb = { 97, 135, 214 } }
    c.logs.success.style.fg = { Rgb = { 144, 173, 104 } }
    c.logs.warning.style.fg = { Rgb = { 207, 169, 106 } }
    c.logs.error.style.fg = { Rgb = { 213, 105, 110 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 97, 135, 214 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 178, 199, 199 } } }
    n.symlink.style = { fg = { Rgb = { 101, 161, 189 } }, add_modifiers = { "Italic" } }
end

return M
