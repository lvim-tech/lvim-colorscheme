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

    -- The terminal palette is NOT the editor palette, so `foreground` and ANSI 8 are DERIVED here rather
    -- than reused from the editor colours. Both floors are config (`config.terminal`), not constants.
    --
    -- `foreground`: the editor `fg` is tuned against one background under syntax highlighting, and several
    -- palettes here keep it deliberately muted (Kanagawa's reads 2.32:1 on its own background) — fine for
    -- code, unusable as a terminal default.
    --
    -- `black_bright` (ANSI 8, "bright black"): a DIM NEUTRAL, never an accent. `terminal_bg` used to be
    -- handed straight through, which is a full teal in the Kanagawa palettes (#1c7060) and a warm brown in
    -- Gruvbox (#63584f) — that is what painted an unreadable coloured block wherever a TUI uses ANSI 8 as a
    -- BACKGROUND. But ANSI 8 is also dim TEXT (a shell autosuggestion), and those two jobs pull opposite
    -- ways: tuned for one, the other becomes unreadable. They only both fit when the foreground sits far
    -- enough away to leave room in between. Measured over the 37 distinct backgrounds in this set, a 9:1
    -- foreground puts both at ~3:1; at 4.5:1 there is no room and the block side collapses to 1.44:1.
    local tcfg = opts.terminal or {}
    local term_bg = colors.bg_soft_dark or colors.bg_dark or colors.bg
    local term_fg = util.ensure_contrast(colors.fg, term_bg, tcfg.contrast or 6)
    local black_bright = util.ensure_contrast(util.blend(term_fg, 0.1, term_bg), term_bg, tcfg.dim_contrast or 1.08)
    -- ANSI 15 a touch below the terminal foreground: it is what lands ON a coloured block, and at the full
    -- foreground brightness that reads hot. Never allowed to reach `white` (ANSI 7), which sits under it.
    local white = util.ensure_contrast(colors.fg_soft_dark, term_bg, (tcfg.contrast or 6) * 0.75)
    local white_bright = term_fg
    do
        local hsluv = require("lvim-colorscheme.hsluv")
        local h = hsluv.hex_to_hsluv(term_fg)
        local l0 = h[3]
        h[3] = h[3] - (tcfg.bright_dim or 3)
        if h[3] > 0 and l0 > 0 then
            h[2] = math.min(h[2] * (h[3] / l0), 100)
            local cand = hsluv.hsluv_to_hex(h)
            if util.contrast(cand, term_bg) > util.contrast(white, term_bg) then
                white_bright = cand
            end
        end
    end

    -- ANSI 7/15 ("white" / "bright white") were the editor's `fg_soft_dark` / `fg` verbatim — muted values
    -- that read at ~2:1 on their own background. That is what actually made Claude Code's prompt block
    -- unreadable: it writes that block in ANSI 15, so the block's text was the muted editor grey no matter
    -- what ANSI 8 underneath it did. Chasing it through ANSI 8 could never have fixed it. Both now clear a
    -- floor like every other derived terminal entry — 15 IS the terminal foreground, 7 a step below it.
    -- stylua: ignore
    --- @class TerminalColors
    colors.terminal = {
        background     = term_bg,
        foreground     = term_fg,
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
        white          = white,
        white_bright   = white_bright,
    }

    opts.on_colors(colors)

    return colors, opts
end

return M
