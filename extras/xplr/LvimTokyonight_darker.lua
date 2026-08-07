-- Lvim Colorscheme TokyonightDarker
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 144, 123, 186 } }
    c.cursor.style.fg = { Rgb = { 105, 130, 191 } }
    c.default_ui.style.fg = { Rgb = { 178, 182, 199 } }
    c.focus_ui.style = { fg = { Rgb = { 255, 255, 255 } }, bg = { Rgb = { 96, 115, 164 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 120, 138, 103 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 20, 23, 30 } }, bg = { Rgb = { 120, 138, 103 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 120, 128, 164 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 178, 182, 199 } }
    c.table.tree[1].style.fg = { Rgb = { 28, 31, 38 } }
    c.table.tree[2].style.fg = { Rgb = { 28, 31, 38 } }
    c.table.tree[3].style.fg = { Rgb = { 28, 31, 38 } }
    c.panel_ui.default.style.fg = { Rgb = { 178, 182, 199 } }
    c.panel_ui.table.style.fg = { Rgb = { 178, 182, 199 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 178, 182, 199 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 178, 182, 199 } }
    c.panel_ui.selection.style.fg = { Rgb = { 120, 138, 103 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 183, 157, 123 } }
    c.logs.info.style.fg = { Rgb = { 105, 130, 191 } }
    c.logs.success.style.fg = { Rgb = { 120, 138, 103 } }
    c.logs.warning.style.fg = { Rgb = { 183, 157, 123 } }
    c.logs.error.style.fg = { Rgb = { 196, 100, 117 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 105, 130, 191 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 178, 182, 199 } } }
    n.symlink.style = { fg = { Rgb = { 101, 133, 157 } }, add_modifiers = { "Italic" } }
end

return M
