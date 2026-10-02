-- lvim-colorscheme.extra.lode: generate a lode theme file from the lvim-colorscheme palette.
--
-- lode is the desktop database client (https://github.com/lvim-tech/lode). It reads a flat TOML of
-- named roles from `~/.config/lode/themes/<name>.toml` and copies them into its toolkit's style:
--
--     mkdir -p ~/.config/lode/themes
--     cp extras/lode/*.toml ~/.config/lode/themes/
--
-- Then pick one in the application's Theme menu (or set `$LODE_THEME` to the file's stem).
--
-- ── WHY THIS TARGET DERIVES ITS SURFACES INSTEAD OF COPYING THE PALETTE ──────────────────────────
--
-- This is the same problem bru ran into on a web page, and the measurement holds here: the
-- palette's own surface tiers are made for an EDITOR, where the chrome must not shout at the code.
-- On base dark, `bg` is `#20272b` and `bg_light`, the next tier up, is `#242b2f` — four pixels per
-- channel, about **1.06:1**. In a database client the side panel, the grid body and a selected row
-- are three different PLACES and a user has to see which one they are in; 1.06:1 is not a place, it
-- is a rounding error. So the four surfaces are walked out of `bg` to measured ratios, in hsluv,
-- holding the L:S ratio so a step stays this palette's colour rather than drifting to grey.
--
-- Direction comes from the palette (`bg_light` says which way "up" is) but cannot be taken on
-- faith: on all twelve LIGHT styles `bg` is `#E4E4E4` and walking up runs straight into white, so
-- the direction is chosen by which side has room for the LARGEST step and every tier takes it.
-- Both tiers on the same side matters — "more raised" that crosses to the other side of the window
-- is not a further step, it is a different idea.
--
-- ── WHAT IS GROUNDED, AND AGAINST WHAT ──────────────────────────────────────────────────────────
--
-- Every ink is floored against the surface it is ACTUALLY drawn on, picked by `util.hardest` (the
-- nearest in luminance of the candidates — which surface is the hard one depends on the palette,
-- and assuming it costs a measurement). The sets differ because the surfaces differ:
--
--   * interface text (primary, muted)  → panel, base, raised, overlay, header_bg, status, hover
--     (all seven: a label in the side panel, a cell in the grid, a column name in the header strip,
--     a field in a dialog, the message in the status strip, a row under the pointer)
--   * accents                          → panel, base, raised, status  (chips, borders, state dots,
--     and the warning / error line the status strip prints)
--   * syntax                           → base only  (the editor body is the one surface it has)
--   * header_fg                        → header_bg
--   * selection_fg                     → selection_bg
--   * null_fg                          → base, row_alt and hover  (every background a cell gets)
--
-- ── WHAT IS DELIBERATELY LEFT UNCORRECTED ───────────────────────────────────────────────────────
--
--   1. `[palette]` — the raw lvim-colorscheme keys, verbatim. Nothing in lode draws text with
--      these; they are there so a person reading the file (or a future panel) can see what the
--      derived roles came from. Correcting them would make the section a lie about the palette.
--   2. The accents are floored to **3.0, not 4.5**. They are chips, borders, state dots and icon
--      strokes — UI components, where 3.0 is the right standard — and never body text. Flooring
--      them to 4.5 would push every theme's accents toward the same few lightnesses and the twelve
--      families would stop looking like twelve families.
--   3. `row_alt` — the grid's alternating stripe — is held at a deliberately LOW ratio to `base`
--      (1.07). It is a surface, not an ink, and its whole job is to be just visible enough to track
--      one row across the width. A "readable" stripe is a second background, and a grid with two
--      backgrounds is a grid nobody can read a column down.
--   4. Corner radii, spacing and font sizes are not in the file at all. They are not what a palette
--      is for, and a theme that changed the metrics would make switching palettes a layout change.
--   5. A tier that cannot be reached in either direction comes back as far as the walk got — a flat
--      window rather than a wrong one. No palette is special-cased.
--
---@module "lvim-colorscheme.extra.lode"

local util = require("lvim-colorscheme.util")

local M = {}

--- Walk a surface out of `bg` until it is `ratio` away, in hsluv, holding the L:S ratio so the step
--- keeps the palette's hue and character. `toward` is read for its DIRECTION only; the side with
--- room for `probe` (the largest step any tier wants) is chosen once, and every tier uses it.
---@param bg string
---@param toward string  the palette's own neighbouring tier — direction only
---@param ratio number  the contrast ratio to reach against `bg`
---@param probe number  the largest ratio any tier needs, used to pick the side with room
---@return string
local function step(bg, toward, ratio, probe)
    local hsluv = require("lvim-colorscheme.hsluv")
    local base = hsluv.hex_to_hsluv(bg)
    local l0, s0 = base[3], base[2]

    local function walk(dir, target)
        local hsl = { base[1], base[2], base[3] }
        local out = bg
        for _ = 1, 100 do
            hsl[3] = hsl[3] + dir
            if hsl[3] > 100 or hsl[3] < 0 then
                return out, false
            end
            if l0 > 0 then
                hsl[2] = math.min(s0 * (hsl[3] / l0), 100)
            end
            out = hsluv.hsluv_to_hex(hsl)
            if util.contrast(out, bg) >= target then
                return out, true
            end
        end
        return out, false
    end

    local up = hsluv.hex_to_hsluv(toward)[3] >= base[3] and 1 or -1
    local _, room = walk(up, probe)
    local dir = room and up or -up
    return (walk(dir, ratio))
end

--- @param colors ColorScheme
--- @param _ table  highlight groups, unused: lode maps from the palette
--- @param opts table
function M.generate(colors, _, opts)
    local bg = colors.bg

    -- The four surfaces. `probe` is the largest ratio any of them asks for, so the side with room
    -- for the overlay is the side all four take.
    local OVERLAY_RATIO = 1.42
    local raised = step(bg, colors.bg_light, 1.22, OVERLAY_RATIO)
    local overlay = step(bg, colors.bg_light, OVERLAY_RATIO, OVERLAY_RATIO)
    -- The side panel goes the OTHER way from the raised tiers, toward `bg_dark`: a panel reads as
    -- recessed, a card as raised, and putting both on the same side of the page makes the window
    -- look like one surface with two accidents on it.
    local panel = step(bg, colors.bg_dark, 1.14, 1.14)
    -- The status strip goes DEEPER than the panel: it is the window's bottom
    -- edge, and an edge that sits at the same depth as a panel reads as one more
    -- panel. 1.30 is the first step where it stops being ambiguous.
    local status = step(bg, colors.bg_dark, 1.30, 1.30)
    -- The row under the pointer. It has to land BETWEEN the stripe (1.07) and a
    -- card (1.22): below the stripe it is invisible against an odd row, at a card's
    -- depth every pass of the mouse looks like something opening.
    local hover = step(bg, colors.bg_light, 1.12, 1.12)
    local header_bg = raised
    -- The stripe: see note 3 — deliberately small, and NOT grounded as an ink.
    local row_alt = step(bg, colors.bg_light, 1.07, 1.07)
    -- A border has to be found, not read: 2.0 against the page is visible without becoming a line
    -- the eye follows instead of the data.
    local border = util.ensure_contrast(colors.comment, bg, 2.0)

    -- Interface text, grounded on every surface it actually lands on.
    local function ground(color, min, surfaces)
        return util.ensure_contrast(color, util.hardest(color, surfaces[1], select(2, unpack(surfaces))), min)
    end
    local ink_surfaces = { panel, bg, raised, overlay, header_bg, status, hover }
    local text_primary = ground(colors.terminal.foreground, 4.5, ink_surfaces)
    local text_muted = ground(colors.comment, 3.2, ink_surfaces)
    -- The ink drawn ON an accent. `util.title_fg` is the ONE value the whole badge-painting family
    -- shares (clipack, configer, themer, ql, secmon, keyforge, mailforge), judged once per theme on
    -- every surface that family paints a chip on. lode's primary accent is the same floored blue, so
    -- using the shared ink means a chip in the database client and a chip in the mail client carry
    -- byte-identical text — which is the entire point of the shared value.
    local text_inverted = util.title_fg(colors)

    -- Accents: 3.0, not 4.5 — see note 2. `status` is in the set because the
    -- status strip is where a warning or an error line is actually printed.
    local accent_surfaces = { panel, bg, raised, status }
    local function accent(color)
        return ground(color, 3.0, accent_surfaces)
    end
    local accent_primary = accent(colors.blue)
    local accent_secondary = accent(colors.teal)
    local accent_success = accent(colors.green)
    local accent_warning = accent(colors.yellow)
    local accent_error = accent(colors.red)
    local accent_info = accent(colors.cyan)

    -- Syntax: the editor body is `base` and only `base`, so that is the whole surface set.
    local function syn(color)
        return util.ensure_contrast(color, bg, 4.5)
    end

    -- The grid's selection. The accent blended a third of the way into the page keeps the theme's
    -- hue while staying a SURFACE rather than a block of pure accent.
    --
    -- The ink on it cannot simply be floored, and the 12 light styles are what proved it: the
    -- selection there lands around `#adb7c3`, whose luminance is just under 0.5, so
    -- `ensure_contrast` reads the surface as "dark", walks white UPWARDS, runs off the top of the
    -- scale in one step and hands back the white it was given — **2.03:1**, measured on
    -- nightfox light. A floor that cannot move its colour is not a floor.
    --
    -- So the rule `util.readable_on` documents applies: pick the better of the two poles, and then
    -- **the surface gives as well** — feed the result back with the selection as the colour and the
    -- ink as the background, exactly as extra/desktop/bru.lua does for a chip it cannot satisfy.
    -- hsluv holds the hue, so the selection stays this palette's blue and only its lightness moves.
    -- The ink is NOT re-picked afterwards: contrast is symmetric, so moving the surface away from
    -- the chosen ink is already the guarantee, and re-picking could choose the other pole and throw
    -- the guarantee away.
    local selection_bg = util.blend(accent_primary, 0.38, bg)
    local selection_fg = util.readable_on(selection_bg, text_inverted)
    selection_bg = util.ensure_contrast(selection_bg, selection_fg, 4.5)
    local header_fg = util.ensure_contrast(colors.terminal.foreground, header_bg, 4.5)
    -- A NULL must read as present-but-absent. 3.0 against both surfaces the grid stripes between:
    -- quieter than a value, never a blank cell. It is a different COLOUR from the body ink, because
    -- a NULL and a string reading "NULL" are different values and must not look alike.
    local null_fg = ground(colors.comment, 3.0, { bg, row_alt, hover })

    colors.lode_name = "Lvim" .. (opts.style:gsub("^%l", string.upper))
    colors.lode_style = opts.style
    colors.lode_dark = tostring(not opts.style:match("_light$"))
    colors.lode_base = bg
    colors.lode_panel = panel
    colors.lode_raised = raised
    colors.lode_overlay = overlay
    colors.lode_status = status
    colors.lode_hover = hover
    colors.lode_border = border
    colors.lode_text = text_primary
    colors.lode_muted = text_muted
    colors.lode_inverted = text_inverted
    colors.lode_accent = accent_primary
    colors.lode_accent_alt = accent_secondary
    colors.lode_success = accent_success
    colors.lode_warning = accent_warning
    colors.lode_error = accent_error
    colors.lode_info = accent_info
    colors.lode_kw = syn(colors.purple)
    colors.lode_str = syn(colors.green)
    colors.lode_num = syn(colors.orange)
    colors.lode_comment = util.ensure_contrast(colors.comment, bg, 3.2)
    colors.lode_fn = syn(colors.blue)
    colors.lode_op = syn(colors.fg)
    colors.lode_ident = text_primary
    colors.lode_header_bg = header_bg
    colors.lode_header_fg = header_fg
    colors.lode_row_alt = row_alt
    colors.lode_sel_bg = selection_bg
    colors.lode_sel_fg = selection_fg
    colors.lode_null = null_fg

    return util.template(
        [[# ${lode_name}
# Generated by lvim-colorscheme for lode — https://github.com/lvim-tech/lode
#
# Install:
#   mkdir -p ~/.config/lode/themes
#   cp extras/lode/*.toml ~/.config/lode/themes/
#
# Then pick it in the Theme menu, or set LODE_THEME=${lode_name}.
#
# The surfaces are DERIVED, not copied: the palette's own tiers sit about 1.06:1 apart, which an
# editor wants and a windowed application cannot use — a side panel, the grid and a selected row
# have to look like three different places. Every foreground below is floored for contrast against
# the surface it is actually drawn on. The [palette] block at the end is the raw palette, carried
# for reference only — nothing draws text with it.

name = "${lode_name}"
style = "${lode_style}"
dark = ${lode_dark}

# The places the application paints. `base` is the grid and the editor, `panel` the side panel
# (recessed), `raised` a card / the grid header (raised), `overlay` a dialog above everything,
# `status` the strip along the bottom edge (deeper than a panel, so it reads as an edge and not as
# one more panel), `hover` the row under the pointer (between the grid's stripe and a card: shallower
# and it vanishes against an odd row, deeper and every pass of the mouse looks like something opening).
[surface]
base    = "${lode_base}"
panel   = "${lode_panel}"
raised  = "${lode_raised}"
overlay = "${lode_overlay}"
status  = "${lode_status}"
hover   = "${lode_hover}"
border  = "${lode_border}"

# Interface text, grounded on the hardest of panel / base / raised / overlay / header.
# `inverted` is the ink drawn ON an accent — the shared badge ink of the whole lvim tool family.
[text]
primary  = "${lode_text}"
muted    = "${lode_muted}"
inverted = "${lode_inverted}"

# Floored to 3.0, not 4.5: these are chips, borders and state dots — UI components, never body text.
[accent]
primary   = "${lode_accent}"
secondary = "${lode_accent_alt}"
success   = "${lode_success}"
warning   = "${lode_warning}"
error     = "${lode_error}"
info      = "${lode_info}"

# The query editor. Grounded on `base` alone, which is the only surface it is drawn on.
[syntax]
keyword    = "${lode_kw}"
string     = "${lode_str}"
number     = "${lode_num}"
comment    = "${lode_comment}"
function   = "${lode_fn}"
operator   = "${lode_op}"
identifier = "${lode_ident}"

# The result grid. `row_alt` is the alternating stripe and is deliberately a SMALL step off `base`:
# it exists to track one row across the width, and a stripe loud enough to "read" would be a second
# background. `null_fg` is a SQL NULL — quieter than a value and a different colour from the body
# ink, because a NULL and a string reading "NULL" are different values.
[grid]
header_bg    = "${lode_header_bg}"
header_fg    = "${lode_header_fg}"
row_alt      = "${lode_row_alt}"
selection_bg = "${lode_sel_bg}"
selection_fg = "${lode_sel_fg}"
null_fg      = "${lode_null}"

# The raw palette, verbatim and NOT contrast-corrected. Reference only.
[palette]
bg            = "${bg}"
bg_light      = "${bg_light}"
bg_soft_light = "${bg_soft_light}"
bg_soft_dark  = "${bg_soft_dark}"
bg_dark       = "${bg_dark}"
fg            = "${fg}"
comment       = "${comment}"
red           = "${red}"
orange        = "${orange}"
yellow        = "${yellow}"
green         = "${green}"
teal          = "${teal}"
cyan          = "${cyan}"
blue          = "${blue}"
purple        = "${purple}"
magenta       = "${magenta}"
]],
        colors
    )
end

return M
