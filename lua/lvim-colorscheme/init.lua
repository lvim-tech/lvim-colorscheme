local util = require("lvim-colorscheme.util")
local theme = require("lvim-colorscheme.theme")
local config = require("lvim-colorscheme.config")

local M = {}

function M._load(style)
    if style and not M._style then
        M._style = require("lvim-colorscheme.config").options.style
    end
    if not style and M._style then
        require("lvim-colorscheme.config").options.style = M._style
        M._style = nil
    end
    M.load({ style = style, use_background = style == nil })
end

function M.load(opts)
    if opts then
        require("lvim-colorscheme.config").extend(opts)
    end
    util.load(theme.setup())
end

M.setup = config.setup

M.colorscheme = M.load

return M