-- lvim-colorscheme.extra.lode: generate a lode theme file from the RESOLVED HIGHLIGHT GROUPS.
--
-- lode is the desktop database client (https://github.com/lvim-tech/lode). It reads a flat TOML of
-- named roles from `~/.config/lode/themes/<name>.toml` and copies them into its toolkit's style:
--
--     mkdir -p ~/.config/lode/themes
--     cp extras/lode/*.toml ~/.config/lode/themes/
--
-- Then pick one in the application's Theme menu (or set `$LODE_THEME` to the file's stem).
--
-- ══ THIS TARGET IS DELIBERATELY DIFFERENT FROM EVERY OTHER ONE HERE ═════════════════════════════
--
-- **It does no contrast work at all.** No `ensure_contrast`, no `readable_on`, no `title_fg`, no
-- derived surfaces. Every value is a colour the editor is ALREADY drawing, taken from the resolved
-- highlight groups and written out unchanged — even where the pair measures below 4.5:1.
--
-- That is a conscious exception to the rule the rest of `extra/` follows, and it was made for a
-- reason that the first version of this file proves. That version did what the family does: it read
-- the raw palette and floored each foreground against the surface it lands on. The output was
-- CORRECT — on base dark it emitted `bg #20272b` and `bg_light #242b2f`, matching the palette
-- exactly — and it did not look like lvim. The body text had gone from `#5e8888`, which is what
-- `Normal.fg` actually is (3.86:1, and deliberately so: an editor's body text under syntax
-- highlighting is not a web page's), to `#6cbaba` at 6.76:1. A sixth of the way up the lightness
-- scale is the entire difference between "our theme" and "a theme built from our colours".
--
-- A client sitting beside the editor all day has to be the same colour as the editor. So the SOURCE
-- changed rather than the mathematics being deleted: the generator now reads `groups/`, which is the
-- one place that already knows what every one of these surfaces and inks is, and copies it.
--
-- **Do not "fix" this in a later audit.** A sweep that adds `ensure_contrast` here will silently
-- undo the only thing this file is for. `extras/lode/check.py` MEASURES the result and prints every
-- pair below 4.5:1 — and exits 0, because those pairs are the editor's own and are not faults.
--
-- ══ THE MAPPING ════════════════════════════════════════════════════════════════════════════════
--
--   surface.base      Normal.bg          the buffer: the grid and the editor
--   surface.panel     NormalSB.bg        the editor's OWN side panel (sidebar) background
--   surface.raised    Pmenu.bg           a popup list's body — the nearest thing to a card
--   surface.overlay   NormalFloat.bg     a float: dialogs
--   surface.status    StatusLine.bg      the status strip
--   surface.hover     CursorLine.bg      the line under the cursor → the row under the pointer
--   surface.selected  PmenuSel.bg        the selected entry of a popup list → a selected list row
--   surface.border    WinSeparator.fg    see the note below
--   text.primary      Normal.fg          the body text, at whatever contrast the editor has it
--   text.muted        Comment.fg         second-level text — NOT LineNr, see the note at its use
--   text.title        Title.fg           section headings
--   text.inverted     TabLineSel.fg      the ink the editor writes ON its one accent chip
--   accent.primary    TabLineSel.bg      that chip — so chip and ink are a pair the editor shipped
--   accent.secondary  DiagnosticHint.fg
--   accent.success    MoreMsg.fg
--   accent.warning    WarningMsg.fg
--   accent.error      ErrorMsg.fg
--   accent.info       DiagnosticInfo.fg
--   match.bg / .fg    Search.bg / Search.fg
--   syntax.*          Keyword / String / Constant / Comment / Function / Operator / Identifier
--   grid.header_bg    TabLine.bg         a header strip over content, with its own ink…
--   grid.header_fg    TabLine.fg         …which is exactly what a tab line is
--   grid.row_alt      ColorColumn.bg     the editor's quiet background band
--   grid.selection_bg Visual.bg          selected TEXT
--   grid.selection_fg Normal.fg          `Visual` sets no foreground: the editor keeps the body ink
--   grid.null_fg      NonText.fg         the editor's "there is nothing here" colour
--   grid.line_nr      LineNr.fg          the row-number column, which is literally a line number
--
-- **Roles with no analogue in the editor**, named here rather than left to be guessed at:
--
--   * `grid.row_alt` — an editor has no alternating rows. `ColorColumn` is the nearest: a quiet
--     band laid over the buffer's background without being a second surface.
--   * `surface.border` — on EVERY lvim style `WinSeparator.fg` equals its own background (measured
--     across all 48: the editor draws no visible line between windows). Taken literally, as the
--     rule requires, which means the client's frames are invisible and its structure is carried by
--     the SURFACES instead — which is exactly how the editor separates one window from the next.
--     This is reported by check.py, not corrected here.
--   * `match.*` and `syntax.*` are carried even though the client does not paint with them yet. The
--     file is the contract; a role dropped because today's client has no use for it is a role the
--     next version has to re-derive from somewhere else.
--
---@module "lvim-colorscheme.extra.lode"

local util = require("lvim-colorscheme.util")

local M = {}

--- Resolve a highlight group, following links. A group may be a link string, or a table carrying a
--- `link`, and the caller wants the definition either way.
---@param groups table
---@param name string
---@return table
local function hl(groups, name)
    local h = groups[name]
    for _ = 1, 8 do
        if type(h) == "string" then
            h = groups[h]
        elseif type(h) == "table" and type(h.link) == "string" then
            local next_h = groups[h.link]
            if next_h == nil then
                break
            end
            h = next_h
        else
            break
        end
    end
    return type(h) == "table" and h or {}
end

--- The first `#rrggbb` among the candidate `{ group, key }` pairs.
---
--- A candidate list, not a single group, because a few groups are legitimately unset on some styles
--- (`Number` is one: neovim links it to `Constant`). Every candidate is ANOTHER GROUP — never a
--- computed value — so a fallback is still the editor's own colour.
---@param groups table
---@param candidates table[]  list of { group_name, key }
---@param fallback string
---@return string
local function pick(groups, candidates, fallback)
    for _, c in ipairs(candidates) do
        local v = hl(groups, c[1])[c[2]]
        if type(v) == "string" and v:match("^#%x%x%x%x%x%x$") then
            return v
        end
    end
    return fallback
end

--- @param colors ColorScheme
--- @param groups table  the RESOLVED highlight groups — the whole source of this file
--- @param opts table
function M.generate(colors, groups, opts)
    groups = util.resolve(groups)
    local g = function(candidates, fallback)
        return pick(groups, candidates, fallback)
    end

    -- Surfaces. Every one is a background the editor actually paints.
    local base = g({ { "Normal", "bg" } }, colors.bg)
    local panel = g({ { "NormalSB", "bg" }, { "NormalFloat", "bg" } }, colors.bg_dark)
    local raised = g({ { "Pmenu", "bg" }, { "StatusLine", "bg" } }, colors.bg_soft_dark)
    local overlay = g({ { "NormalFloat", "bg" }, { "Pmenu", "bg" } }, colors.bg_dark)
    local status = g({ { "StatusLine", "bg" }, { "Pmenu", "bg" } }, colors.bg_soft_dark)
    local hover = g({ { "CursorLine", "bg" }, { "PmenuSel", "bg" } }, colors.bg_light)
    local selected = g({ { "PmenuSel", "bg" }, { "Visual", "bg" } }, colors.bg_light)
    -- See the header: this is the editor's separator colour, and on every lvim style it is the
    -- separator's own background — the editor draws no line.
    local border = g({ { "WinSeparator", "fg" }, { "VertSplit", "fg" }, { "FloatBorder", "fg" } }, colors.bg_dark)

    -- Inks, at the editor's own contrast. `Normal.fg` on base dark is 3.86:1 and stays 3.86:1.
    local text = g({ { "Normal", "fg" } }, colors.fg)
    -- `Comment`, NOT `LineNr`. Both are "quiet" in the editor and they are not interchangeable:
    -- on base dark `LineNr` is `#2a373d`, which measures 1.2:1 on the buffer background, because a
    -- gutter number is meant to be nearly invisible until looked for. Every small label in a
    -- client — a section heading, a driver name, a counter, the status strip — is text meant to be
    -- READ, and at 1.2:1 none of it was. `Comment` is `#5b7d7e`, legible, and still the theme's own
    -- colour with nothing computed. `LineNr` survives below, for the one thing that is literally a
    -- line number: the grid's row-number column.
    local muted = g({ { "Comment", "fg" }, { "NonText", "fg" } }, colors.comment)
    local title = g({ { "Title", "fg" }, { "Directory", "fg" } }, colors.green)
    -- The editor writes exactly one piece of text ON an accent: the selected tab's label. That pair
    -- — TabLineSel's background and foreground — is the chip and its ink, shipped together.
    local inverted = g({ { "TabLineSel", "fg" }, { "Normal", "bg" } }, colors.bg)
    local accent = g({ { "TabLineSel", "bg" }, { "Title", "fg" } }, colors.green)

    local accent_alt = g({ { "DiagnosticHint", "fg" }, { "Directory", "fg" } }, colors.teal)
    local success = g({ { "MoreMsg", "fg" }, { "DiagnosticOk", "fg" }, { "Title", "fg" } }, colors.green)
    local warning = g({ { "WarningMsg", "fg" }, { "DiagnosticWarn", "fg" } }, colors.yellow)
    local error_fg = g({ { "ErrorMsg", "fg" }, { "DiagnosticError", "fg" }, { "Error", "fg" } }, colors.red)
    local info = g({ { "DiagnosticInfo", "fg" }, { "Question", "fg" } }, colors.blue)

    local match_bg = g({ { "Search", "bg" }, { "IncSearch", "bg" }, { "Visual", "bg" } }, colors.bg_light)
    local match_fg = g({ { "Search", "fg" }, { "IncSearch", "fg" }, { "Normal", "fg" } }, colors.fg)

    -- Syntax: the editor's own, unchanged. `Number` is usually unset because neovim links it to
    -- `Constant`; the candidate list says so rather than inventing a colour.
    local syn_keyword = g({ { "Keyword", "fg" }, { "Statement", "fg" } }, colors.purple)
    local syn_string = g({ { "String", "fg" } }, colors.green)
    local syn_number = g({ { "Number", "fg" }, { "Constant", "fg" } }, colors.orange)
    local syn_comment = g({ { "Comment", "fg" } }, colors.comment)
    local syn_function = g({ { "Function", "fg" } }, colors.blue)
    local syn_operator = g({ { "Operator", "fg" } }, colors.fg)
    local syn_identifier = g({ { "Identifier", "fg" }, { "Normal", "fg" } }, colors.fg)

    -- The grid.
    local header_bg = g({ { "TabLine", "bg" }, { "StatusLine", "bg" } }, colors.bg_soft_dark)
    local header_fg = g({ { "TabLine", "fg" }, { "StatusLineNC", "fg" } }, colors.fg)
    local row_alt = g({ { "ColorColumn", "bg" }, { "CursorColumn", "bg" } }, colors.bg_soft_dark)
    local sel_bg = g({ { "Visual", "bg" } }, colors.bg_light)
    -- `Visual` carries no foreground on any lvim style: selected text keeps the body ink. Copied as
    -- such — this is the pair the first version of this file "fixed" by moving the surface, which is
    -- precisely the kind of correction that stops a theme being the theme.
    local sel_fg = g({ { "Visual", "fg" }, { "Normal", "fg" } }, colors.fg)
    local null_fg = g({ { "NonText", "fg" }, { "Comment", "fg" } }, colors.comment)
    -- The grid's row numbers ARE line numbers, so they take the gutter's own colour and are as
    -- quiet here as they are there — on purpose, and not to be confused with `text.muted` above.
    local line_nr = g({ { "LineNr", "fg" }, { "NonText", "fg" } }, colors.comment)

    colors.lode_name = "Lvim" .. (opts.style:gsub("^%l", string.upper))
    colors.lode_style = opts.style
    colors.lode_dark = tostring(not opts.style:match("_light$"))
    colors.lode_base = base
    colors.lode_panel = panel
    colors.lode_raised = raised
    colors.lode_overlay = overlay
    colors.lode_status = status
    colors.lode_hover = hover
    colors.lode_selected = selected
    colors.lode_border = border
    colors.lode_text = text
    colors.lode_muted = muted
    colors.lode_title = title
    colors.lode_inverted = inverted
    colors.lode_accent = accent
    colors.lode_accent_alt = accent_alt
    colors.lode_success = success
    colors.lode_warning = warning
    colors.lode_error = error_fg
    colors.lode_info = info
    colors.lode_match_bg = match_bg
    colors.lode_match_fg = match_fg
    colors.lode_kw = syn_keyword
    colors.lode_str = syn_string
    colors.lode_num = syn_number
    colors.lode_comment = syn_comment
    colors.lode_fn = syn_function
    colors.lode_op = syn_operator
    colors.lode_ident = syn_identifier
    colors.lode_header_bg = header_bg
    colors.lode_header_fg = header_fg
    colors.lode_row_alt = row_alt
    colors.lode_sel_bg = sel_bg
    colors.lode_sel_fg = sel_fg
    colors.lode_null = null_fg
    colors.lode_line_nr = line_nr

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
# EVERY VALUE BELOW IS A COLOUR THE EDITOR IS ALREADY DRAWING, taken from the resolved highlight
# groups of the `${lode_style}` style and copied unchanged. Nothing here is contrast-corrected,
# including the pairs that measure below 4.5:1 — notably `text.primary` on `surface.base`, which is
# `Normal` and is meant to read exactly as it does in the editor. A client that sits beside the
# editor all day has to be the same colour as the editor; a "more readable" version of a theme is a
# different theme. `extras/lode/check.py` measures and reports these pairs; it does not fail on them.
#
# Where a role has no analogue in an editor, the nearest group was used and said so in
# extra/misc/lode.lua. `surface.border` is `WinSeparator`, which on every lvim style equals its own
# background — the editor draws no line between windows — so the client's structure is carried by
# the surfaces rather than by outlines, exactly as it is in the editor.

name = "${lode_name}"
style = "${lode_style}"
dark = ${lode_dark}

# Normal.bg / NormalSB.bg / Pmenu.bg / NormalFloat.bg / StatusLine.bg / CursorLine.bg /
# PmenuSel.bg / WinSeparator.fg
[surface]
base     = "${lode_base}"
panel    = "${lode_panel}"
raised   = "${lode_raised}"
overlay  = "${lode_overlay}"
status   = "${lode_status}"
hover    = "${lode_hover}"
selected = "${lode_selected}"
border   = "${lode_border}"

# Normal.fg / Comment.fg / Title.fg / TabLineSel.fg
[text]
primary  = "${lode_text}"
muted    = "${lode_muted}"
title    = "${lode_title}"
inverted = "${lode_inverted}"

# TabLineSel.bg / DiagnosticHint.fg / MoreMsg.fg / WarningMsg.fg / ErrorMsg.fg / DiagnosticInfo.fg
[accent]
primary   = "${lode_accent}"
secondary = "${lode_accent_alt}"
success   = "${lode_success}"
warning   = "${lode_warning}"
error     = "${lode_error}"
info      = "${lode_info}"

# Search.bg / Search.fg — carried for the grid search that is next, like [syntax] below.
[match]
bg = "${lode_match_bg}"
fg = "${lode_match_fg}"

# Keyword / String / Constant / Comment / Function / Operator / Identifier
[syntax]
keyword    = "${lode_kw}"
string     = "${lode_str}"
number     = "${lode_num}"
comment    = "${lode_comment}"
function   = "${lode_fn}"
operator   = "${lode_op}"
identifier = "${lode_ident}"

# TabLine.bg / TabLine.fg / ColorColumn.bg / Visual.bg / Normal.fg (Visual sets no fg) / NonText.fg
# `line_nr` is LineNr.fg and is used ONLY for the row-number column, which is literally a line
# number and is as quiet here as the editor's gutter is. Everything else small uses text.muted.
[grid]
header_bg    = "${lode_header_bg}"
header_fg    = "${lode_header_fg}"
row_alt      = "${lode_row_alt}"
selection_bg = "${lode_sel_bg}"
selection_fg = "${lode_sel_fg}"
null_fg      = "${lode_null}"
line_nr      = "${lode_line_nr}"

# The raw palette, verbatim. Reference only — nothing draws text with it.
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
