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
    return util.template(
        [[
{
  "document": { "block_prefix": "\n", "block_suffix": "\n", "color": "${fg}", "margin": 2 },
  "block_quote": { "color": "${yellow}", "italic": true, "indent": 1, "indent_token": "│ " },
  "paragraph": {},
  "list": { "color": "${fg}", "level_indent": 2 },
  "heading": { "block_suffix": "\n", "color": "${purple}", "bold": true },
  "h1": { "prefix": " ", "suffix": " ", "color": "${bg_dark}", "background_color": "${purple}", "bold": true },
  "h2": { "prefix": "## ", "color": "${blue}" },
  "h3": { "prefix": "### ", "color": "${cyan}" },
  "h4": { "prefix": "#### ", "color": "${teal}" },
  "h5": { "prefix": "##### ", "color": "${green}" },
  "h6": { "prefix": "###### ", "color": "${comment}", "bold": false },
  "text": {},
  "strikethrough": { "crossed_out": true },
  "emph": { "color": "${yellow}", "italic": true },
  "strong": { "color": "${orange}", "bold": true },
  "hr": { "color": "${bg_light}", "format": "\n--------\n" },
  "item": { "block_prefix": "• " },
  "enumeration": { "block_prefix": ". " },
  "task": { "ticked": "[✓] ", "unticked": "[ ] " },
  "link": { "color": "${cyan}", "underline": true },
  "link_text": { "color": "${magenta}", "bold": true },
  "image": { "color": "${cyan}", "underline": true },
  "image_text": { "color": "${comment}", "format": "Image: {{.text}} →" },
  "code": { "color": "${green}", "prefix": " ", "suffix": " " },
  "code_block": { "color": "${fg}", "margin": 2, "theme": "nord" },
  "table": { "center_separator": "┼", "column_separator": "│", "row_separator": "─" },
  "definition_list": {},
  "definition_term": { "color": "${blue}" },
  "definition_description": { "block_prefix": "\n🠶 " },
  "html_block": {},
  "html_span": {}
}
]],
        colors
    )
end

return M
