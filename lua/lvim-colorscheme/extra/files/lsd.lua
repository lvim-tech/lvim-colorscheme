-- lvim-colorscheme.extra.lsd: generate an lsd colour theme from the palette.
--
--     mkdir -p ~/.config/lsd
--     ln -sf .../extras/lsd/LvimNord_dark.yaml ~/.config/lsd/colors.yaml
--
-- lsd looks for exactly `colors.yaml` — no theme name, no themes/ directory —
-- so the generated file is symlinked over that one name.
--
-- Colours are written as "#rrggbb" strings; lsd also accepts [r,g,b] and a
-- 256 index, but the hex form keeps the file readable next to the palette.
-- Filetype colours are NOT set here: those come from LS_COLORS, which vivid
-- already owns, and defining them twice guarantees the two drift apart.
--
---@module "lvim-colorscheme.extra.files.lsd"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    return util.template(
        [[
---
# ${_style_name}
user: "${yellow}"
group: "${yellow_dark}"
permission:
  read: "${green}"
  write: "${yellow}"
  exec: "${red}"
  exec-sticky: "${magenta}"
  no-access: "${comment}"
  octal: "${teal}"
  acl: "${teal}"
  context: "${cyan}"
date:
  hour-old: "${green}"
  day-old: "${green_dark}"
  older: "${teal_dark}"
size:
  none: "${comment}"
  small: "${green}"
  medium: "${yellow}"
  large: "${orange}"
inode:
  valid: "${purple}"
  invalid: "${comment}"
links:
  valid: "${purple}"
  invalid: "${comment}"
tree-edge: "${bg_light}"
git-status:
  default: "${fg}"
  unmodified: "${comment}"
  ignored: "${comment}"
  new-in-index: "${green}"
  new-in-workdir: "${green}"
  typechange: "${yellow}"
  deleted: "${red}"
  renamed: "${blue}"
  modified: "${orange}"
  conflicted: "${magenta}"
]],
        colors
    )
end

return M
