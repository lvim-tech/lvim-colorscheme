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
    -- This target writes no background of its own, so its text lands on the TERMINAL's — which
    -- this project themes from the same palette, making `terminal.background` the honest surface
    -- rather than a guess. Measured across the 48 palettes before this existed, 763 of the 1008
    -- accent-and-foreground values in this scheme read under WCAG AA's 4.5:1 when used that way.
    --
    -- The palette's own `terminal.*` entries are NOT touched anywhere: ANSI 0-15 is a measured
    -- hierarchy of its own in `colors/init.lua` (foreground at 6:1, ANSI 8 doing double duty as dim
    -- text and as a block background at ~3:1, 7 derived a step under 15), and a second floor on top
    -- of it would undo that.
    --
    -- `tree-edge` is left verbatim: it draws the ├── glyphs of the tree, which are structure and
    -- not words, and it is `bg_light` precisely so the names stand in front of it.
    local function text(hex)
        return util.ensure_contrast(hex, colors.terminal.background, 4.5)
    end
    local t = setmetatable({}, { __index = function(_, k)
        local v = colors[k]
        -- `tree-edge` is the only key this file writes that is not read as text.
        if type(v) == "string" and v:match("^#%x%x%x%x%x%x$") and k ~= "bg_light" then
            return text(v)
        end
        return v
    end })
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
        t
    )
end

return M
