-- lvim-colorscheme.extra.zed: generate a Zed theme/colour config from the lvim-colorscheme palette.
--
---@module "lvim-colorscheme.extra.zed"

local util = require("lvim-colorscheme.util")

local M = {}

-- EVERY key in ThemeStyleContent is written, all 142 of them, and that completeness is the point: a
-- key left out is not left neutral. Zed substitutes its own default, built for its own themes, and the
-- result is a colour from another palette sitting in the middle of this one. Two were found by looking
-- rather than by reasoning — `ghost_element.selected` was missing, so the selected row of the project
-- panel drew in a near-white box under every dark theme; and the confirm button of a dialog came out
-- #0082E6, a blue that appears in no palette here, measured off a screenshot with ImageMagick.
--
-- Both had the same shape, and 84 keys were still absent when the second one was found, so they are
-- all filled in now instead of one at a time.
--
-- Mapping, where it is not obvious: every status family (error, warning, created, conflict …) takes
-- the palette colour for its border and the shared highlight wash for its background — Zed expects a
-- tint there, not a second saturated colour. `border.transparent` is genuinely transparent, and
-- `background.appearance` is a word rather than a colour.
--
-- selected and hover resolve to the same colour, deliberately left so: colors/init.lua assigns one
-- `bg_blend` to bg_visual, bg_search and bg_highlight alike, and distinguishing them would mean a new
-- derived colour in every palette.
--- @param colors ColorScheme
function M.generate(colors)
    -- Zed switches its own UI chrome on this field, so a light palette shipped as "dark" makes the
    -- editor draw dark chrome around light code. The style name carries the answer (`*_light`).
    colors._appearance = tostring(colors._style):match("_light$") and "light" or "dark"

    -- Zed is an EDITOR, so the `syntax` object at the bottom is a deliberate hierarchy — a comment
    -- recedes because that is its job — and it is not floored. What is floored is the CHROME read
    -- as words: the UI's body and muted text, the gutter's line numbers, the accent text, and the
    -- status labels a panel writes beside a file name.
    --
    -- `editor.foreground` stays with the syntax rather than the chrome. It is zed's `Normal`, the
    -- base the hierarchy is built on, and `groups/base.lua` leaves neovim's `Normal` at the
    -- palette's muted `fg` (2.03:1 on kanagawa_soft) while flooring every float around it.
    --
    -- Measured across the 48 styles before this existed, 772 of zed's 960 chrome pairs were under
    -- WCAG AA's 4.5:1 — the line number at **1.42:1** on base_soft.
    --
    -- Zed writes chrome text on six palette surfaces (the window background, a panel, the editor,
    -- a float, a status wash, a selected element). They sit close together, so a colour clearing
    -- whichever it is NEAREST clears the rest; the walk is repeated because a colour that starts
    -- inside that cluster would otherwise stop on the next surface up.
    local function ui(hex)
        local v = hex
        for _ = 1, 4 do
            v = util.ensure_contrast(v, util.hardest(v, colors.bg_soft_dark, colors.bg, colors.bg_dark,
                colors.bg_float, colors.bg_highlight, colors.bg_visual), 4.5)
        end
        return v
    end

    -- One floored value per tier, reused by every key on that tier — including the icons, so an
    -- icon and the label beside it stay the same shade. Every `*.background` and `*.border` keeps
    -- the palette's own value: a status family's background is a tint zed expects, and a border is
    -- a line rather than a word. `terminal.*` keeps the palette's ANSI hierarchy untouched, and so
    -- do `players` and `accents`, which are identity rather than text.
    local t = vim.tbl_extend("force", colors, {
        zed_ui_fg = ui(colors.fg),
        zed_ui_muted = ui(colors.comment),
        zed_line_nr = ui(colors.fg_dark),
        zed_active_line_nr = ui(colors.fg_light),
        zed_text_blue = ui(colors.blue),
        zed_created = ui(colors.git.add),
        zed_modified = ui(colors.git.change),
        zed_deleted = ui(colors.git.delete),
        zed_renamed = ui(colors.purple),
        zed_conflict = ui(colors.orange),
        zed_error = ui(colors.red),
        zed_warning = ui(colors.yellow),
        zed_hint = ui(colors.cyan),
        zed_success = ui(colors.green),
    })

    return util.template(
        [[
{
  "$schema": "https://zed.dev/schema/themes/v0.2.0.json",
  "name": "${_style_name}",
  "author": "lvim-tech",
  "themes": [
    {
      "name": "${_style_name}",
      "appearance": "${_appearance}",
      "style": {
        "background": "${bg_soft_dark}",
        "editor.background": "${bg_dark}",
        "editor.foreground": "${fg}",
        "editor.line_number": "${zed_line_nr}",
        "editor.active_line_number": "${zed_active_line_nr}",
        "editor.active_line.background": "${bg}",
        "editor.gutter.background": "${bg_dark}",
        "text": "${zed_ui_fg}",
        "text.muted": "${zed_ui_muted}",
        "text.accent": "${zed_text_blue}",
        "border": "${bg_highlight}",
        "surface.background": "${bg_float}",
        "elevated_surface.background": "${bg_float}",
        "element.background": "${bg}",
        "element.hover": "${bg_highlight}",
        "element.selected": "${bg_visual}",
        "element.active": "${bg_visual}",
        "element.disabled": "${bg}",
        "ghost_element.background": "${bg}",
        "ghost_element.hover": "${bg_highlight}",
        "ghost_element.selected": "${bg_visual}",
        "ghost_element.active": "${bg_visual}",
        "ghost_element.disabled": "${bg}",
        "drop_target.background": "${bg_visual}",
        "status_bar.background": "${bg}",
        "title_bar.background": "${bg}",
        "toolbar.background": "${bg_dark}",
        "tab_bar.background": "${bg}",
        "tab.active_background": "${bg_dark}",
        "tab.inactive_background": "${bg}",
        "panel.background": "${bg}",
        "scrollbar.thumb.background": "${bg_highlight}",
        "terminal.background": "${terminal.background}",
        "terminal.foreground": "${terminal.foreground}",
        "terminal.ansi.black": "${terminal.black}",
        "terminal.ansi.red": "${terminal.red}",
        "terminal.ansi.green": "${terminal.green}",
        "terminal.ansi.yellow": "${terminal.yellow}",
        "terminal.ansi.blue": "${terminal.blue}",
        "terminal.ansi.magenta": "${terminal.magenta}",
        "terminal.ansi.cyan": "${terminal.cyan}",
        "terminal.ansi.white": "${terminal.white}",
        "terminal.ansi.bright_black": "${terminal.black_bright}",
        "terminal.ansi.bright_red": "${terminal.red_bright}",
        "terminal.ansi.bright_green": "${terminal.green_bright}",
        "terminal.ansi.bright_yellow": "${terminal.yellow_bright}",
        "terminal.ansi.bright_blue": "${terminal.blue_bright}",
        "terminal.ansi.bright_magenta": "${terminal.magenta_bright}",
        "terminal.ansi.bright_cyan": "${terminal.cyan_bright}",
        "terminal.ansi.bright_white": "${terminal.white_bright}",
        "background.appearance": "opaque",
        "border.variant": "${bg_highlight}",
        "border.focused": "${blue}",
        "border.selected": "${blue}",
        "border.transparent": "#00000000",
        "border.disabled": "${bg_highlight}",
        "text.disabled": "${zed_ui_muted}",
        "text.placeholder": "${comment}",
        "icon": "${zed_ui_fg}",
        "icon.accent": "${zed_text_blue}",
        "icon.muted": "${zed_ui_muted}",
        "icon.disabled": "${zed_ui_muted}",
        "icon.placeholder": "${comment}",
        "link_text.hover": "${zed_text_blue}",
        "title_bar.inactive_background": "${bg_dark}",
        "pane.focused_border": "${blue}",
        "pane_group.border": "${bg_highlight}",
        "panel.focused_border": "${blue}",
        "panel.indent_guide": "${bg_highlight}",
        "panel.indent_guide_active": "${bg_visual}",
        "panel.indent_guide_hover": "${bg_visual}",
        "scrollbar.thumb.border": "${bg_highlight}",
        "scrollbar.thumb.hover_background": "${bg_visual}",
        "scrollbar.track.background": "${bg}",
        "scrollbar.track.border": "${bg_highlight}",
        "search.match_background": "${bg_visual}",
        "editor.wrap_guide": "${bg_highlight}",
        "editor.active_wrap_guide": "${bg_visual}",
        "editor.indent_guide": "${bg_highlight}",
        "editor.indent_guide_active": "${bg_visual}",
        "editor.invisible": "${comment}",
        "editor.subheader.background": "${bg_dark}",
        "editor.highlighted_line.background": "${bg_visual}",
        "editor.document_highlight.read_background": "${bg_visual}",
        "editor.document_highlight.write_background": "${bg_visual}",
        "editor.document_highlight.bracket_background": "${bg_visual}",
        "created": "${zed_created}",
        "created.background": "${bg_highlight}",
        "created.border": "${git.add}",
        "modified": "${zed_modified}",
        "modified.background": "${bg_highlight}",
        "modified.border": "${git.change}",
        "deleted": "${zed_deleted}",
        "deleted.background": "${bg_highlight}",
        "deleted.border": "${git.delete}",
        "renamed": "${zed_renamed}",
        "renamed.background": "${bg_highlight}",
        "renamed.border": "${purple}",
        "conflict": "${zed_conflict}",
        "conflict.background": "${bg_highlight}",
        "conflict.border": "${orange}",
        "error": "${zed_error}",
        "error.background": "${bg_highlight}",
        "error.border": "${red}",
        "warning": "${zed_warning}",
        "warning.background": "${bg_highlight}",
        "warning.border": "${yellow}",
        "info": "${zed_text_blue}",
        "info.background": "${bg_highlight}",
        "info.border": "${blue}",
        "hint": "${zed_hint}",
        "hint.background": "${bg_highlight}",
        "hint.border": "${cyan}",
        "success": "${zed_success}",
        "success.background": "${bg_highlight}",
        "success.border": "${green}",
        "ignored": "${zed_ui_muted}",
        "ignored.background": "${bg_highlight}",
        "ignored.border": "${comment}",
        "hidden": "${zed_ui_muted}",
        "hidden.background": "${bg_highlight}",
        "hidden.border": "${comment}",
        "predictive": "${comment}",
        "predictive.background": "${bg_highlight}",
        "predictive.border": "${comment}",
        "unreachable": "${zed_ui_muted}",
        "unreachable.background": "${bg_highlight}",
        "unreachable.border": "${comment}",
        "terminal.ansi.background": "${terminal.background}",
        "terminal.bright_foreground": "${fg_light}",
        "terminal.dim_foreground": "${comment}",
        "terminal.ansi.dim_black": "${bg_soft_dark}",
        "terminal.ansi.dim_red": "${red_dark}",
        "terminal.ansi.dim_green": "${green_dark}",
        "terminal.ansi.dim_yellow": "${yellow_dark}",
        "terminal.ansi.dim_blue": "${blue_dark}",
        "terminal.ansi.dim_magenta": "${magenta_dark}",
        "terminal.ansi.dim_cyan": "${cyan_dark}",
        "terminal.ansi.dim_white": "${fg_dark}",
        "accents": ["${blue}", "${green}", "${yellow}", "${purple}", "${cyan}", "${orange}", "${red}"],
        "players": [
          { "cursor": "${blue}", "background": "${blue}", "selection": "${bg_visual}" },
          { "cursor": "${green}", "background": "${green}", "selection": "${bg_visual}" },
          { "cursor": "${yellow}", "background": "${yellow}", "selection": "${bg_visual}" },
          { "cursor": "${purple}", "background": "${purple}", "selection": "${bg_visual}" },
          { "cursor": "${cyan}", "background": "${cyan}", "selection": "${bg_visual}" },
          { "cursor": "${orange}", "background": "${orange}", "selection": "${bg_visual}" },
          { "cursor": "${red}", "background": "${red}", "selection": "${bg_visual}" }
        ],
        "syntax": {
          "comment": { "color": "${comment}", "font_style": "italic" },
          "string": { "color": "${green}" },
          "string.regex": { "color": "${cyan}" },
          "number": { "color": "${orange}" },
          "constant": { "color": "${orange}" },
          "keyword": { "color": "${purple}" },
          "function": { "color": "${blue}" },
          "function.method": { "color": "${blue}" },
          "type": { "color": "${yellow}" },
          "variable": { "color": "${fg}" },
          "variable.special": { "color": "${red}" },
          "property": { "color": "${cyan}" },
          "operator": { "color": "${cyan}" },
          "punctuation": { "color": "${fg_dark}" },
          "tag": { "color": "${red}" },
          "attribute": { "color": "${cyan}" },
          "title": { "color": "${blue}", "font_weight": 700 },
          "link_uri": { "color": "${cyan}" },
          "link_text": { "color": "${red}" }
        }
      }
    }
  ]
}]],
        t
    )
end

return M
