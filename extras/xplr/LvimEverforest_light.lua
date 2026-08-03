-- Lvim Colorscheme EverforestLight
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 145, 90, 71 } }
    c.cursor.style.fg = { Rgb = { 80, 137, 166 } }
    c.default_ui.style.fg = { Rgb = { 94, 136, 136 } }
    c.focus_ui.style = { fg = { Rgb = { 218, 218, 218 } }, bg = { Rgb = { 80, 137, 166 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 123, 126, 61 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 218, 218, 218 } }, bg = { Rgb = { 123, 126, 61 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 139, 154, 131 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 94, 136, 136 } }
    c.table.tree[1].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[2].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[3].style.fg = { Rgb = { 238, 238, 238 } }
    c.panel_ui.default.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.table.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.selection.style.fg = { Rgb = { 123, 126, 61 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 143, 129, 86 } }
    c.logs.info.style.fg = { Rgb = { 80, 137, 166 } }
    c.logs.success.style.fg = { Rgb = { 123, 126, 61 } }
    c.logs.warning.style.fg = { Rgb = { 143, 129, 86 } }
    c.logs.error.style.fg = { Rgb = { 199, 77, 77 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 80, 137, 166 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 94, 136, 136 } } }
    n.symlink.style = { fg = { Rgb = { 92, 136, 97 } }, add_modifiers = { "Italic" } }
end

return M
