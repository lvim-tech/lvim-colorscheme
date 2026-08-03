-- lvim-colorscheme.extra.xplr: generate an xplr colour module from the
-- palette.
--
--     mkdir -p ~/.config/xplr/plugins/lvim
--     ln -sf .../extras/xplr/LvimNord_dark.lua ~/.config/xplr/plugins/lvim/init.lua
--     # then in init.lua: require("lvim").setup()
--
-- xplr's config IS Lua, and its style values take no "#rrggbb" form at all —
-- only { Rgb = { r, g, b } } — so the palette is expanded to triples here.
--
---@module "lvim-colorscheme.extra.files.xplr"

local ansi = require("lvim-colorscheme.extra.ansi")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    local function rgb(hex)
        local r, g, b = ansi.rgb(hex)
        return string.format("{ Rgb = { %d, %d, %d } }", r, g, b)
    end

    local lines = {
        "-- " .. (colors._style_name or "Lvim"),
        "local M = {}",
        "",
        "function M.setup()",
        "    local xplr = xplr",
        "    local c = xplr.config.general",
        "",
        "    c.prompt.style.fg = " .. rgb(colors.magenta),
        "    c.cursor.style.fg = " .. rgb(colors.blue),
        "    c.default_ui.style.fg = " .. rgb(colors.fg),
        "    c.focus_ui.style = { fg = " .. rgb(colors.bg_dark) .. ", bg = " .. rgb(colors.blue) .. ', add_modifiers = { "Bold" } }',
        "    c.selection_ui.style = { fg = " .. rgb(colors.green) .. ', add_modifiers = { "Bold" } }',
        "    c.focus_selection_ui.style = { fg = " .. rgb(colors.bg_dark) .. ", bg = " .. rgb(colors.green) .. ' , add_modifiers = { "Bold" } }',
        "    c.table.header.style = { fg = " .. rgb(colors.comment) .. ', add_modifiers = { "Bold" } }',
        "    c.table.row.style.fg = " .. rgb(colors.fg),
        "    c.table.tree[1].style.fg = " .. rgb(colors.bg_light),
        "    c.table.tree[2].style.fg = " .. rgb(colors.bg_light),
        "    c.table.tree[3].style.fg = " .. rgb(colors.bg_light),
        "    c.panel_ui.default.style.fg = " .. rgb(colors.fg),
        "    c.panel_ui.table.style.fg = " .. rgb(colors.fg),
        "    c.panel_ui.help_menu.style.fg = " .. rgb(colors.fg),
        "    c.panel_ui.input_and_logs.style.fg = " .. rgb(colors.fg),
        "    c.panel_ui.selection.style.fg = " .. rgb(colors.green),
        "    c.panel_ui.sort_and_filter.style.fg = " .. rgb(colors.yellow),
        "    c.logs.info.style.fg = " .. rgb(colors.blue),
        "    c.logs.success.style.fg = " .. rgb(colors.green),
        "    c.logs.warning.style.fg = " .. rgb(colors.yellow),
        "    c.logs.error.style.fg = " .. rgb(colors.red),
        "",
        "    local n = xplr.config.node_types",
        "    n.directory.style = { fg = " .. rgb(colors.blue) .. ', add_modifiers = { "Bold" } }',
        "    n.file.style = { fg = " .. rgb(colors.fg) .. " }",
        "    n.symlink.style = { fg = " .. rgb(colors.cyan) .. ', add_modifiers = { "Italic" } }',
        "end",
        "",
        "return M",
        "",
    }
    return table.concat(lines, "\n")
end

return M
