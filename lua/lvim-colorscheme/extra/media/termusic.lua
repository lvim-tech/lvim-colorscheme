-- lvim-colorscheme.extra.termusic: generate a termusic palette theme.
--
--     mkdir -p ~/.config/termusic/themes
--     ln -sf .../extras/termusic/LvimNord_dark.yml ~/.config/termusic/themes/
--     # then in tui.toml: [theme] name = "Lvim Colorscheme NordDark"
--
-- `colors.name` is what tui.toml's [theme] name matches against, so a file
-- without it cannot be selected at all. MEASURED against the vscode.dark.yml
-- termusic ships: it carries name and author inside colors, and the generated
-- files did not.
--
-- termusic splits theming in two: this alacritty-shaped palette file, and
-- `tui.toml`, where each widget names a palette SLOT (`red`, `light_blue`,
-- ...) rather than a colour. Only the palette is generated — the widget
-- mapping is a layout preference, and overwriting tui.toml would take the
-- rest of the user's TUI settings with it.
--
---@module "lvim-colorscheme.extra.media.termusic"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    return util.template(
        [[
# ${_style_name}
colors:
  name: ${_style_name}
  author: lvim-colorscheme
  primary:
    background: "${bg_dark}"
    foreground: "${fg}"
  cursor:
    text: "${bg_dark}"
    cursor: "${fg}"
  normal:
    black: "${terminal.black}"
    red: "${terminal.red}"
    green: "${terminal.green}"
    yellow: "${terminal.yellow}"
    blue: "${terminal.blue}"
    magenta: "${terminal.magenta}"
    cyan: "${terminal.cyan}"
    white: "${terminal.white}"
  bright:
    black: "${terminal.black_bright}"
    red: "${terminal.red_bright}"
    green: "${terminal.green_bright}"
    yellow: "${terminal.yellow_bright}"
    blue: "${terminal.blue_bright}"
    magenta: "${terminal.magenta_bright}"
    cyan: "${terminal.cyan_bright}"
    white: "${terminal.white_bright}"
]],
        colors
    )
end

return M
