-- lvim-colorscheme.extra.lazygit: generate a Lazygit theme/colour config from the lvim-colorscheme palette.
--
---@module "lvim-colorscheme.extra.lazygit"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    colors.bg_line = util.blend_bg(colors.bg_highlight, 0.1)
    -- Colours only: the gui.theme block. The other ~200 lines this used to
    -- carry (keybindings, pager, editor, refresher, ...) are clipack's
    -- base.yml — LG_CONFIG_FILE names both files and lazygit merges them,
    -- this one second so the palette wins any overlap.
    -- Text here lands on the TERMINAL's background, which this project themes from the same
    -- palette -- so `terminal.background` is the honest surface rather than a guess. The palette's
    -- own `terminal.*` entries are never re-floored: ANSI 0-15 is a measured hierarchy of its own
    -- in `colors/init.lua` and a second floor on top would undo it.
    --
    -- `activeBorderColor`, `inactiveBorderColor` and `searchingActiveBorderColor` draw a panel
    -- frame and `selectedLineBgColor` is a surface: nothing is read against any of them, so they
    -- keep the palette's own value. `defaultFgColor` is `terminal.foreground`, which already clears
    -- 6:1 by construction and is left alone rather than floored a second time.
    --
    -- `cherryPickedCommit*` and `markedBaseCommit*` are a foreground ON a palette background, so
    -- the text is chosen from the two the theme has rather than lifted, and the background gives a
    -- step of hsluv lightness only where that still cannot reach the floor.
    local function text(hex)
        return util.ensure_contrast(hex, colors.terminal.background, 4.5)
    end
    colors.lg_options = text(colors.blue)
    colors.lg_unstaged = text(colors.red)
    colors.lg_cherry_fg = util.readable_on(colors.magenta, colors.bg_dark)
    colors.lg_cherry_bg = util.ensure_contrast(colors.magenta, colors.lg_cherry_fg, 4.5)
    colors.lg_marked_fg = util.readable_on(colors.yellow, colors.bg_dark)
    colors.lg_marked_bg = util.ensure_contrast(colors.yellow, colors.lg_marked_fg, 4.5)
    local lazygit = util.template(
        [[---
gui:
  theme:
    activeBorderColor:
      - "${orange}"
      - "bold"
    inactiveBorderColor:
      - "${border_highlight}"
    searchingActiveBorderColor:
      - "${orange}"
      - "bold"
    optionsTextColor:
      - "${lg_options}"
    selectedLineBgColor:
      - "${bg_line}"
    cherryPickedCommitFgColor:
      - "${lg_cherry_fg}"
    cherryPickedCommitBgColor:
      - "${lg_cherry_bg}"
    markedBaseCommitFgColor:
      - "${lg_marked_fg}"
    markedBaseCommitBgColor:
      - "${lg_marked_bg}"
    unstagedChangesColor:
      - "${lg_unstaged}"
    defaultFgColor:
      - "${terminal.foreground}"
]],
        colors
    )
    return lazygit
end

return M
