local utils = require("lvim-colorscheme.utils")

local M = {}

function M.generate(colors)
    local kitty = utils.template(
        [[
# Lvim Lazygit Colors


gui:
  theme:
    activeBorderColor:
      - "${green_02}"
      - bold
    inactiveBorderColor:
      - "${orange_02}"
    optionsTextColor:
      - "${orange_02}"
    selectedLineBgColor:
      - "${bg_04}"
    selectedRangeBgColor:
      - "${green_02}"
    cherryPickedCommitBgColor:
      - teal
    cherryPickedCommitFgColor:
      - blue
    unstagedChangesColor:
      - red
    defaultFgColor:
      - default
  showFileTree: true
  showListFooter: true
  showRandomTip: true
  showBottomLine: true
  showCommandLog: true
  showIcons: true
  ]],
        colors
    )
    return kitty
end

return M
