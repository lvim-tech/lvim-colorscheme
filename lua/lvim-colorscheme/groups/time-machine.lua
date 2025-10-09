local util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/y3owk1n/time-machine.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    TimeMachineCurrent = { bg = util.blend(c.blue, 0.1, c.bg) },
    TimeMachineTimeline = { fg = c.blue, bold = true },
    TimeMachineTimelineAlt = { fg = c.red, bold = true },
    TimeMachineKeymap = { fg = c.teal },
    TimeMachineInfo = { fg = c.yellow },
    TimeMachineSeq = { fg = c.green, bold = true },
    TimeMachineTag = { fg = c.orange, bold = true },
  }
end

return M
