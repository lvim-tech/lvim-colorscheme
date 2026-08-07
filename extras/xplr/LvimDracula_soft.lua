-- Lvim Colorscheme DraculaSoft
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 197, 120, 161 } }
    c.cursor.style.fg = { Rgb = { 105, 151, 163 } }
    c.default_ui.style.fg = { Rgb = { 199, 199, 179 } }
    c.focus_ui.style = { fg = { Rgb = { 37, 39, 50 } }, bg = { Rgb = { 105, 151, 163 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 101, 159, 114 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 37, 39, 50 } }, bg = { Rgb = { 100, 156, 112 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 135, 143, 173 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 199, 199, 179 } }
    c.table.tree[1].style.fg = { Rgb = { 45, 47, 58 } }
    c.table.tree[2].style.fg = { Rgb = { 45, 47, 58 } }
    c.table.tree[3].style.fg = { Rgb = { 45, 47, 58 } }
    c.panel_ui.default.style.fg = { Rgb = { 199, 199, 179 } }
    c.panel_ui.table.style.fg = { Rgb = { 199, 199, 179 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 199, 199, 179 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 199, 199, 179 } }
    c.panel_ui.selection.style.fg = { Rgb = { 101, 159, 114 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 173, 178, 126 } }
    c.logs.info.style.fg = { Rgb = { 105, 151, 163 } }
    c.logs.success.style.fg = { Rgb = { 101, 159, 114 } }
    c.logs.warning.style.fg = { Rgb = { 173, 178, 126 } }
    c.logs.error.style.fg = { Rgb = { 205, 120, 120 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 105, 151, 163 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 199, 199, 179 } } }
    n.symlink.style = { fg = { Rgb = { 104, 153, 143 } }, add_modifiers = { "Italic" } }
end

return M
