-- Lvim Colorscheme SolarizedSoft
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 224, 111, 165 } }
    c.cursor.style.fg = { Rgb = { 79, 157, 210 } }
    c.default_ui.style.fg = { Rgb = { 157, 164, 164 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 78, 123, 159 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 143, 157, 51 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 112, 121, 62 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 128, 154, 164 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 157, 164, 164 } }
    c.table.tree[1].style.fg = { Rgb = { 4, 56, 69 } }
    c.table.tree[2].style.fg = { Rgb = { 4, 56, 69 } }
    c.table.tree[3].style.fg = { Rgb = { 4, 56, 69 } }
    c.panel_ui.default.style.fg = { Rgb = { 157, 164, 164 } }
    c.panel_ui.table.style.fg = { Rgb = { 157, 164, 164 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 157, 164, 164 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 157, 164, 164 } }
    c.panel_ui.selection.style.fg = { Rgb = { 143, 157, 51 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 176, 145, 72 } }
    c.logs.info.style.fg = { Rgb = { 79, 157, 210 } }
    c.logs.success.style.fg = { Rgb = { 143, 157, 51 } }
    c.logs.warning.style.fg = { Rgb = { 176, 145, 72 } }
    c.logs.error.style.fg = { Rgb = { 231, 115, 113 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 79, 157, 210 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 157, 164, 164 } } }
    n.symlink.style = { fg = { Rgb = { 74, 163, 156 } }, add_modifiers = { "Italic" } }
end

return M
