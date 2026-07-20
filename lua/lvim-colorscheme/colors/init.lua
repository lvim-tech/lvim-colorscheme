-- lvim-colorscheme.colors: assemble the full derived ColorScheme for a style.
-- Loads the style's base palette (lazily, by name), then computes every derived colour the
-- groups need: diffs, borders, sidebar/float/statusline backgrounds (honouring transparent +
-- the authoritative styles.sidebars/floats), the dark_active bg, blends, rainbow and terminal
-- ANSI sets. `styles` is a lazy map of style name → palette table (or light-invert function).
--
---@module "lvim-colorscheme.colors"

local util = require("lvim-colorscheme.util")

local M = {}

---@type table<string, Palette|fun(opts:lvim-colorscheme.Config):Palette>
M.styles = setmetatable({}, {
    __index = function(_, style)
        return vim.deepcopy(util.mod("lvim-colorscheme.colors." .. style))
    end,
})

--- Build the full derived ColorScheme for `opts.style` (overlaid on the live config).
---@param opts? lvim-colorscheme.Config
---@return ColorScheme colors, lvim-colorscheme.Config opts
function M.setup(opts)
    opts = require("lvim-colorscheme.config").extend(opts)

    util.day_brightness = opts.day_brightness

    local palette = M.styles[opts.style]
    if type(palette) == "function" then
        palette = palette(opts) --[[@as Palette]]
    end

    -- Color Palette
    ---@class ColorScheme: Palette
    local colors = palette

    util.bg = colors.bg
    util.fg = colors.fg

    colors.none = "NONE"

    colors.diff = {
        add = util.blend_bg(colors.git.add, 0.08),
        change = util.blend_bg(colors.git.change, 0.08),
        delete = util.blend_bg(colors.git.delete, 0.08),
        changeDelete = util.blend_bg(colors.git.change_delete, 0.08),
        untracked = util.blend_bg(colors.git.untracked, 0.08),
        -- a STRONGER change tint (0.25) so the changed span reads inside a DiffChange line — NOT colors.fg,
        -- which made DiffText fg-on-fg (invisible) in diff mode.
        text = util.blend_bg(colors.git.change, 0.25),
    }

    colors.git.ignore = colors.bg_soft_light
    colors.black = util.blend_bg(colors.bg, 0.8, "#000000")
    colors.border_highlight = util.blend_bg(colors.green_dark, 0.8)
    colors.border = colors.bg_soft_dark

    -- Popups and statusline always get a dark background
    colors.bg_popup = colors.bg_soft_dark
    -- `transparent` makes the statusline and floats drop their background too, so a
    -- translucent terminal shows through the panels as well as the editor body. (Sidebars
    -- are left as configured: some groups blend against bg_sidebar, which must stay a hex.)
    colors.bg_statusline = opts.transparent and colors.none or colors.bg_soft_dark

    -- The theme's opaque "dark panel" shade (falls back to bg_dark when the palette has no
    -- dedicated bg_sidebar). Captured before bg_sidebar is overwritten below.
    local dark_panel = colors.bg_sidebar or colors.bg_dark

    -- `styles.sidebars` / `styles.floats` are AUTHORITATIVE: an explicit value decides on its
    -- own (so e.g. `transparent = true` + `sidebars = "normal"` keeps an OPAQUE sidebar). Only
    -- when the style is unset (nil) does the global `transparent` decide.
    -- Three DISTINCT styles: "normal" = the editor bg (`c.bg`), "dark" = a darker panel
    -- (`dark_panel`), "transparent" = none. Unset follows the global `transparent`.
    -- A "transparent" panel only goes NONE while the GLOBAL `transparent` is on; otherwise NONE
    -- would just inherit the (opaque) global Normal — which `dark_active` darkens — so the panel
    -- would wrongly take the focused-window darkening. With global transparent off we therefore
    -- render it as an explicit "normal" (c.bg): opaque, independent of Normal/dark_active.
    colors.bg_sidebar = opts.styles.sidebars == "transparent" and (opts.transparent and colors.none or colors.bg)
        or opts.styles.sidebars == "dark" and dark_panel
        or opts.styles.sidebars == "normal" and colors.bg
        or (opts.transparent and colors.none or colors.bg_dark)

    colors.bg_float = opts.styles.floats == "transparent" and (opts.transparent and colors.none or colors.bg)
        or opts.styles.floats == "dark" and dark_panel
        or opts.styles.floats == "normal" and colors.bg
        or (opts.transparent and colors.none or colors.bg_dark)

    -- `dark_active` darkens the FOCUSED window's background toward black by `dark_active_amount`
    -- (a 0..1 fraction; 0 = no change). Independent of `dim_inactive`. base.lua's Normal uses it.
    colors.bg_active = opts.dark_active and util.blend("#000000", opts.dark_active_amount or 0.2, colors.bg)
        or colors.bg

    local bg_blend = util.blend_bg(colors.bg_light, 0.5)
    colors.bg_visual = bg_blend
    colors.bg_search = bg_blend
    colors.bg_highlight = bg_blend
    colors.fg_sidebar = colors.fg_soft_dark
    colors.fg_float = colors.fg

    colors.error = colors.red_dark
    colors.todo = colors.green_dark
    colors.warning = colors.orange_dark
    colors.info = colors.blue_dark
    colors.hint = colors.teal_dark
    colors.debug = colors.blue_dark

    colors.rainbow = {
        colors.green_dark,
        colors.yellow,
        colors.green,
        colors.teal,
        colors.magenta,
        colors.purple,
        colors.orange,
        colors.red,
    }

    colors.blend = {}
    for _, name in ipairs({
        "blue",
        "green",
        "orange",
        "red",
        "cyan",
        "purple",
        "yellow",
        "error",
        "warning",
        "info",
        "hint",
        "debug",
    }) do
        colors.blend[name .. "High"] = util.blend(colors[name], 0.1, colors.bg)
        colors.blend[name .. "Low"] = util.blend(colors[name], 0.3, colors.bg)
    end

    -- The terminal palette is NOT the editor palette. Two entries have to be derived rather than reused:
    --
    -- `black_bright` (ANSI 8) is "bright black" — a DIM NEUTRAL, brighter than ANSI 0 but still clearly a
    -- background shade. TUIs spend it on dim text AND as a subtle block BACKGROUND, so a saturated accent
    -- there paints solid coloured blocks: `terminal_bg` is a full teal in the Kanagawa palettes (#1c7060)
    -- and a warm brown in Gruvbox (#63584f), which is what made Claude Code's prompt block unreadable.
    -- Derived instead as a small step from the terminal background toward the foreground — neutral by
    -- construction, and close enough to `bg` that anything legible on `bg` stays legible on it.
    --
    -- `foreground` is the terminal's DEFAULT text colour. The editor `fg` is tuned against one background
    -- under syntax highlighting; several palettes here keep it deliberately muted (Kanagawa #54546d reads
    -- at 2.32:1 on its own background), which is fine for code and unusable as a terminal default. Lifted
    -- to a WCAG AA floor against the exported background, so every export inherits a readable default.
    local term_bg = colors.bg_soft_dark or colors.bg_dark or colors.bg
    local black_bright = util.blend(colors.fg, 0.25, term_bg)

    -- stylua: ignore
    --- @class TerminalColors
    colors.terminal = {
        background     = term_bg,
        foreground     = util.ensure_contrast(colors.fg, term_bg, 4.5),
        black          = colors.black,
        black_bright   = black_bright,
        red            = colors.red,
        red_bright     = util.brighten(colors.red),
        green          = colors.green,
        green_bright   = util.brighten(colors.green),
        yellow         = colors.yellow,
        yellow_bright  = util.brighten(colors.yellow),
        blue           = colors.blue_dark,
        blue_bright    = util.brighten(colors.blue_dark),
        magenta        = colors.magenta,
        magenta_bright = util.brighten(colors.magenta),
        cyan           = colors.cyan,
        cyan_bright    = util.brighten(colors.cyan),
        white          = colors.fg_soft_dark,
        white_bright   = colors.fg,
    }

    opts.on_colors(colors)

    return colors, opts
end

return M
