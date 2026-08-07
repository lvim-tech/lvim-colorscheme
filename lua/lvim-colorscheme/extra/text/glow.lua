-- lvim-colorscheme.extra.glow: generate a glamour style for glow from the
-- palette.
--
--     ln -sf .../extras/glow/LvimNord_dark.json ~/.config/glow/lvim.json
--     # then: style: "~/.config/glow/lvim.json" in glow.yml
--     # or:   GLAMOUR_STYLE=~/.config/glow/lvim.json glow README.md
--
-- The same JSON is what any glamour-based tool takes, so this file themes
-- more than glow alone.
--
-- `code_block.theme` names a CHROMA theme for syntax inside fenced blocks;
-- it is left at a neutral built-in because chroma cannot be pointed at the
-- tmTheme this palette already generates for bat.
--
---@module "lvim-colorscheme.extra.text.glow"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    -- Text here lands on the TERMINAL's background, which this project themes from the same
    -- palette -- so `terminal.background` is the honest surface rather than a guess. The palette's
    -- own `terminal.*` entries are never re-floored: ANSI 0-15 is a measured hierarchy of its own
    -- in `colors/init.lua` and a second floor on top would undo it.
    --
    -- `hr` is left verbatim -- it draws a rule, not words -- and `code_block.theme` names a chroma
    -- theme rather than a colour. `h1` is the one heading glamour paints a background for, so its
    -- text is chosen from the two the theme has and the purple gives a step of lightness only if
    -- that still cannot reach the floor.
    local function text(hex)
        return util.ensure_contrast(hex, colors.terminal.background, 4.5)
    end
    local h1_fg = util.readable_on(colors.purple, colors.bg_dark)
    local t = vim.tbl_extend("force", colors, {
        gl_fg = text(colors.fg), gl_yellow = text(colors.yellow), gl_purple = text(colors.purple),
        gl_blue = text(colors.blue), gl_cyan = text(colors.cyan), gl_teal = text(colors.teal),
        gl_green = text(colors.green), gl_comment = text(colors.comment),
        gl_orange = text(colors.orange), gl_magenta = text(colors.magenta),
        gl_h1_fg = h1_fg,
        gl_h1_bg = util.ensure_contrast(colors.purple, h1_fg, 4.5),
    })
    return util.template(
        [[
{
  "document": { "block_prefix": "\n", "block_suffix": "\n", "color": "${gl_fg}", "margin": 2 },
  "block_quote": { "color": "${gl_yellow}", "italic": true, "indent": 1, "indent_token": "│ " },
  "paragraph": {},
  "list": { "color": "${gl_fg}", "level_indent": 2 },
  "heading": { "block_suffix": "\n", "color": "${gl_purple}", "bold": true },
  "h1": { "prefix": " ", "suffix": " ", "color": "${gl_h1_fg}", "background_color": "${gl_h1_bg}", "bold": true },
  "h2": { "prefix": "## ", "color": "${gl_blue}" },
  "h3": { "prefix": "### ", "color": "${gl_cyan}" },
  "h4": { "prefix": "#### ", "color": "${gl_teal}" },
  "h5": { "prefix": "##### ", "color": "${gl_green}" },
  "h6": { "prefix": "###### ", "color": "${gl_comment}", "bold": false },
  "text": {},
  "strikethrough": { "crossed_out": true },
  "emph": { "color": "${gl_yellow}", "italic": true },
  "strong": { "color": "${gl_orange}", "bold": true },
  "hr": { "color": "${bg_light}", "format": "\n--------\n" },
  "item": { "block_prefix": "• " },
  "enumeration": { "block_prefix": ". " },
  "task": { "ticked": "[✓] ", "unticked": "[ ] " },
  "link": { "color": "${gl_cyan}", "underline": true },
  "link_text": { "color": "${gl_magenta}", "bold": true },
  "image": { "color": "${gl_cyan}", "underline": true },
  "image_text": { "color": "${gl_comment}", "format": "Image: {{.text}} →" },
  "code": { "color": "${gl_green}", "prefix": " ", "suffix": " " },
  "code_block": { "color": "${gl_fg}", "margin": 2, "theme": "nord" },
  "table": { "center_separator": "┼", "column_separator": "│", "row_separator": "─" },
  "definition_list": {},
  "definition_term": { "color": "${gl_blue}" },
  "definition_description": { "block_prefix": "\n🠶 " },
  "html_block": {},
  "html_span": {}
}
]],
        t
    )
end

return M
