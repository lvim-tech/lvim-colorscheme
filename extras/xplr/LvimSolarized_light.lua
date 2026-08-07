-- Lvim Colorscheme SolarizedLight
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 146, 74, 108 } }
    c.cursor.style.fg = { Rgb = { 71, 102, 130 } }
    c.default_ui.style.fg = { Rgb = { 78, 103, 103 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 76, 121, 157 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 95, 103, 61 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 112, 121, 62 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 91, 100, 105 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 78, 103, 103 } }
    c.table.tree[1].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[2].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[3].style.fg = { Rgb = { 238, 238, 238 } }
    c.panel_ui.default.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.table.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 78, 103, 103 } }
    c.panel_ui.selection.style.fg = { Rgb = { 95, 103, 61 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 114, 95, 53 } }
    c.logs.info.style.fg = { Rgb = { 71, 102, 130 } }
    c.logs.success.style.fg = { Rgb = { 95, 103, 61 } }
    c.logs.warning.style.fg = { Rgb = { 114, 95, 53 } }
    c.logs.error.style.fg = { Rgb = { 153, 72, 71 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 71, 102, 130 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 78, 103, 103 } } }
    n.symlink.style = { fg = { Rgb = { 66, 104, 101 } }, add_modifiers = { "Italic" } }
end

return M
