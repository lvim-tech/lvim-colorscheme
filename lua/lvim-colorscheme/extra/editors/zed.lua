-- lvim-colorscheme.extra.zed: generate a Zed theme/colour config from the lvim-colorscheme palette.
--
---@module "lvim-colorscheme.extra.zed"

local util = require("lvim-colorscheme.util")

local M = {}

-- BOTH element families are written in full — background, hover, selected, active, disabled — because
-- a key left out is not left neutral: Zed substitutes its own default, which is built for a light UI.
-- `ghost_element.selected` was the one missing, and it is what paints the SELECTED row of the project
-- panel, so the open file sat in a near-white box with the palette's own `text` on top, unreadable
-- under every dark theme. `ghost_element.hover` was present, which is why hovering looked correct and
-- only selection did not. The schema at zed.dev lists five keys per family; all ten are set here.
--
-- selected and hover resolve to the same colour, deliberately left so: colors/init.lua assigns one
-- `bg_blend` to bg_visual, bg_search and bg_highlight alike, and distinguishing them would mean a new
-- derived colour in every palette.
--- @param colors ColorScheme
function M.generate(colors)
    -- Zed switches its own UI chrome on this field, so a light palette shipped as "dark" makes the
    -- editor draw dark chrome around light code. The style name carries the answer (`*_light`).
    colors._appearance = tostring(colors._style):match("_light$") and "light" or "dark"
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
        "editor.line_number": "${fg_dark}",
        "editor.active_line_number": "${fg_light}",
        "editor.active_line.background": "${bg}",
        "editor.gutter.background": "${bg_dark}",
        "text": "${fg}",
        "text.muted": "${comment}",
        "text.accent": "${blue}",
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
        "created": "${git.add}",
        "modified": "${git.change}",
        "deleted": "${git.delete}",
        "error": "${red}",
        "warning": "${yellow}",
        "info": "${blue}",
        "hint": "${cyan}",
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
        colors
    )
end

return M
