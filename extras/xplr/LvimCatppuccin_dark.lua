-- Lvim Colorscheme CatppuccinDark
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 185, 118, 167 } }
    c.cursor.style.fg = { Rgb = { 105, 133, 186 } }
    c.default_ui.style.fg = { Rgb = { 178, 183, 199 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 96, 118, 160 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 107, 141, 105 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 25, 26, 35 } }, bg = { Rgb = { 107, 141, 105 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 126, 133, 166 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 178, 183, 199 } }
    c.table.tree[1].style.fg = { Rgb = { 33, 34, 43 } }
    c.table.tree[2].style.fg = { Rgb = { 33, 34, 43 } }
    c.table.tree[3].style.fg = { Rgb = { 33, 34, 43 } }
    c.panel_ui.default.style.fg = { Rgb = { 178, 183, 199 } }
    c.panel_ui.table.style.fg = { Rgb = { 178, 183, 199 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 178, 183, 199 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 178, 183, 199 } }
    c.panel_ui.selection.style.fg = { Rgb = { 107, 141, 105 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 184, 164, 126 } }
    c.logs.info.style.fg = { Rgb = { 105, 133, 186 } }
    c.logs.success.style.fg = { Rgb = { 107, 141, 105 } }
    c.logs.warning.style.fg = { Rgb = { 184, 164, 126 } }
    c.logs.error.style.fg = { Rgb = { 194, 107, 129 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 105, 133, 186 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 178, 183, 199 } } }
    n.symlink.style = { fg = { Rgb = { 102, 138, 145 } }, add_modifiers = { "Italic" } }
end

return M
