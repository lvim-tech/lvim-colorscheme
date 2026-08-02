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
      - "${blue}"
    selectedLineBgColor:
      - "${bg_line}"
    cherryPickedCommitFgColor:
      - "${blue}"
    cherryPickedCommitBgColor:
      - "${magenta}"
    markedBaseCommitFgColor:
      - "${blue}"
    markedBaseCommitBgColor:
      - "${yellow}"
    unstagedChangesColor:
      - "${red}"
    defaultFgColor:
      - "${terminal.foreground}"
]],
        colors
    )
    return lazygit
end

return M
