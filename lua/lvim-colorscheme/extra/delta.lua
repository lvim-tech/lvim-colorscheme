---@class DeltaColors
---@field add string
---@field delete string

---@class DiffColors
---@field add string
---@field delete string

---@class GitColors
---@field add string
---@field delete string
---@field change string

---@class ColorScheme
---@field diff DiffColors
---@field delta DeltaColors
---@field git GitColors
---@field fg string

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
  colors.delta = {
    add = util.brighten(colors.diff.add, 0.01, 0.5),
    delete = util.brighten(colors.diff.delete, 0.01, 0.5),
  }
  local delta = util.template(
    [[
[delta]
  minus-style                   = syntax "${diff.delete}"
  minus-non-emph-style          = syntax "${diff.delete}"
  minus-emph-style              = syntax "${delta.delete}"
  minus-empty-line-marker-style = syntax "${diff.delete}"
  line-numbers-minus-style      = "${git.delete}"
  plus-style                    = syntax "${diff.add}"
  plus-non-emph-style           = syntax "${diff.add}"
  plus-emph-style               = syntax "${delta.add}"
  plus-empty-line-marker-style  = syntax "${diff.add}"
  line-numbers-plus-style       = "${git.add}"
  line-numbers-zero-style       = "${fg}"
]],
    colors
  )
  return delta
end

return M
