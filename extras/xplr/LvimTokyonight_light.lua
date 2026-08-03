-- Lvim Colorscheme TokyonightLight
local M = {}

function M.setup()
    local xplr = xplr
    local c = xplr.config.general

    c.prompt.style.fg = { Rgb = { 128, 81, 201 } }
    c.cursor.style.fg = { Rgb = { 67, 99, 163 } }
    c.default_ui.style.fg = { Rgb = { 94, 136, 136 } }
    c.focus_ui.style = { fg = { Rgb = { 218, 218, 218 } }, bg = { Rgb = { 67, 99, 163 } }, add_modifiers = { "Bold" } }
    c.selection_ui.style = { fg = { Rgb = { 102, 123, 79 } }, add_modifiers = { "Bold" } }
    c.focus_selection_ui.style = { fg = { Rgb = { 218, 218, 218 } }, bg = { Rgb = { 102, 123, 79 } } , add_modifiers = { "Bold" } }
    c.table.header.style = { fg = { Rgb = { 128, 133, 162 } }, add_modifiers = { "Bold" } }
    c.table.row.style.fg = { Rgb = { 94, 136, 136 } }
    c.table.tree[1].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[2].style.fg = { Rgb = { 238, 238, 238 } }
    c.table.tree[3].style.fg = { Rgb = { 238, 238, 238 } }
    c.panel_ui.default.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.table.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.help_menu.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.input_and_logs.style.fg = { Rgb = { 94, 136, 136 } }
    c.panel_ui.selection.style.fg = { Rgb = { 102, 123, 79 } }
    c.panel_ui.sort_and_filter.style.fg = { Rgb = { 149, 120, 79 } }
    c.logs.info.style.fg = { Rgb = { 67, 99, 163 } }
    c.logs.success.style.fg = { Rgb = { 102, 123, 79 } }
    c.logs.warning.style.fg = { Rgb = { 149, 120, 79 } }
    c.logs.error.style.fg = { Rgb = { 169, 67, 87 } }

    local n = xplr.config.node_types
    n.directory.style = { fg = { Rgb = { 67, 99, 163 } }, add_modifiers = { "Bold" } }
    n.file.style = { fg = { Rgb = { 94, 136, 136 } } }
    n.symlink.style = { fg = { Rgb = { 70, 130, 165 } }, add_modifiers = { "Italic" } }
end

return M
