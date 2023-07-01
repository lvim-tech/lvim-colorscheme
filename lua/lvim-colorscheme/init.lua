local utils = require("lvim-colorscheme.utils")
local config = require("lvim-colorscheme.config")
local load = require("lvim-colorscheme.load")

local M = {}

M.setup = function(user_config)
    if user_config ~= nil then
        utils.merge(config, user_config)
    end
    -- vim.schedule(function()
    load.init(config.default)
    -- end)
end

return M
