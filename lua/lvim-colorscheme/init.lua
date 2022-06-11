local util = require("lvim-colorscheme.util")
local theme = require("lvim-colorscheme.theme")

local M = {}

function M.colorscheme()
    util.load(theme.setup())
end

return M
