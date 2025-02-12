local util = require("lvim-colorscheme.util")

local M = {}

local function remove_hash(color)
    if type(color) == "string" then
        return color:gsub("#", "")
    end
    return color
end

--- @param colors ColorScheme
function M.generate(colors)
    local clean_colors = {}
    for k, v in pairs(colors) do
        clean_colors[k] = remove_hash(v)
    end
    local vivid = util.template(
        [[
colors:
  black: "${yellow_dark}"
  green: "${green}"
  purple: "${purple}"
  red: "${red}"
  yellow: "${yellow}"
  cyan: "${cyan}"
  pink: "${teal}"
  orange: "${orange}"
  white: "${fg_soft_dark}"
]],
        clean_colors
    )
    return vivid
end

return M
