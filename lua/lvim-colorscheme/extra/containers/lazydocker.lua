-- lvim-colorscheme.extra.lazydocker: generate a Lazydocker theme/colour config from the lvim-colorscheme palette.
--
---@module "lvim-colorscheme.extra.lazydocker"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    colors.bg_line = util.blend_bg(colors.bg_highlight, 0.1)
    -- A palette FRAGMENT, not a standalone file: lazydocker reads exactly one
    -- config.yml and has no include or multi-file mechanism, so clipack's
    -- config.sh appends these keys under the `theme:` line that base.yml
    -- deliberately ends with. The settings this used to carry (logs,
    -- commandTemplates, stats graphs, ...) are that base.yml.
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
    local lazydocker = util.template(
        [[# Palette fragment — appended under `gui: theme:` at the end of base.yml
# by clipack's config.sh. Not a complete lazydocker configuration.
    activeBorderColor:
      - "${orange}"
      - "bold"
    inactiveBorderColor:
      - "${border_highlight}"
    selectedLineBgColor:
      - "${bg_line}"
    optionsTextColor:
      - "${lg_options}"]],
        colors
    )
    return lazydocker
end

return M
