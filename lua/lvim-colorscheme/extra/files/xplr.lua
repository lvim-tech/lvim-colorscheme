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
local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    local function rgb(hex)
        local r, g, b = ansi.rgb(hex)
        return string.format("{ Rgb = { %d, %d, %d } }", r, g, b)
    end

    -- Text here lands on the TERMINAL's background, which this project themes from the same
    -- palette -- so `terminal.background` is the honest surface rather than a guess. The palette's
    -- own `terminal.*` entries are never re-floored: ANSI 0-15 is a measured hierarchy of its own
    -- in `colors/init.lua` and a second floor on top would undo it.
    --
    -- `c.table.tree[1..3]` are left verbatim: they draw the tree's connector glyphs, which are
    -- structure and not words, and they are `bg_light` so the file names stand in front of them.
    -- The three `*_ui.style` entries that name both a fg and a bg are paired the other way -- the
    -- text is chosen from the two the theme has and the accent gives a step of lightness only where
    -- that cannot reach the floor -- so a focused row stays blue and a selected one stays green.
    local function text(hex)
        return util.ensure_contrast(hex, colors.terminal.background, 4.5)
    end
    local function on(accent)
        return util.readable_on(accent, colors.bg_dark)
    end
    local function strip(accent)
        return util.ensure_contrast(accent, on(accent), 4.5)
    end

    -- stylua: ignore
    -- One entry per LINE OF THE GENERATED FILE, so the table reads as the file it produces. Past
    -- column_width stylua breaks the `..` chains across five lines each, and that correspondence —
    -- the only reason to write it this way — is gone.
    local lines = {
        "-- " .. (colors._style_name or "Lvim"),
        "local M = {}",
        "",
        "function M.setup()",
        "    local xplr = xplr",
        "    local c = xplr.config.general",
        "",
        "    c.prompt.style.fg = " .. rgb(text(colors.magenta)),
        "    c.cursor.style.fg = " .. rgb(text(colors.blue)),
        "    c.default_ui.style.fg = " .. rgb(text(colors.fg)),
        "    c.focus_ui.style = { fg = " .. rgb(on(colors.blue)) .. ", bg = " .. rgb(strip(colors.blue)) .. ', add_modifiers = { "Bold" } }',
        "    c.selection_ui.style = { fg = " .. rgb(text(colors.green)) .. ', add_modifiers = { "Bold" } }',
        "    c.focus_selection_ui.style = { fg = " .. rgb(on(colors.green)) .. ", bg = " .. rgb(strip(colors.green)) .. ' , add_modifiers = { "Bold" } }',
        "    c.table.header.style = { fg = " .. rgb(text(colors.comment)) .. ', add_modifiers = { "Bold" } }',
        "    c.table.row.style.fg = " .. rgb(text(colors.fg)),
        "    c.table.tree[1].style.fg = " .. rgb(colors.bg_light),
        "    c.table.tree[2].style.fg = " .. rgb(colors.bg_light),
        "    c.table.tree[3].style.fg = " .. rgb(colors.bg_light),
        "    c.panel_ui.default.style.fg = " .. rgb(text(colors.fg)),
        "    c.panel_ui.table.style.fg = " .. rgb(text(colors.fg)),
        "    c.panel_ui.help_menu.style.fg = " .. rgb(text(colors.fg)),
        "    c.panel_ui.input_and_logs.style.fg = " .. rgb(text(colors.fg)),
        "    c.panel_ui.selection.style.fg = " .. rgb(text(colors.green)),
        "    c.panel_ui.sort_and_filter.style.fg = " .. rgb(text(colors.yellow)),
        "    c.logs.info.style.fg = " .. rgb(text(colors.blue)),
        "    c.logs.success.style.fg = " .. rgb(text(colors.green)),
        "    c.logs.warning.style.fg = " .. rgb(text(colors.yellow)),
        "    c.logs.error.style.fg = " .. rgb(text(colors.red)),
        "",
        "    local n = xplr.config.node_types",
        "    n.directory.style = { fg = " .. rgb(text(colors.blue)) .. ', add_modifiers = { "Bold" } }',
        "    n.file.style = { fg = " .. rgb(text(colors.fg)) .. " }",
        "    n.symlink.style = { fg = " .. rgb(text(colors.cyan)) .. ', add_modifiers = { "Italic" } }',
        "end",
        "",
        "return M",
        "",
    }
    return table.concat(lines, "\n")
end

return M
