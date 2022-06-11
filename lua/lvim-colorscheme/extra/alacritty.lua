local util = require("lvim-colorscheme.util")

local M = {}

function M.generate(colors)
    local alacrittyColors = {}
    for k, v in pairs(colors) do
        if type(v) == "string" then
            alacrittyColors[k] = v:gsub("^#", "0x")
        end
    end

    local alacritty = util.template(
        [[
# Lvim Alacritty Colors
colors:
  # Default colors
  primary:
    background: '${color_03}'
    foreground: '${color_21}'

  # Normal colors
  normal:
    black:   '${color_23}'
    red:     '${color_25}'
    green:   '${color_18}'
    yellow:  '${color_07}'
    blue:    '${color_13}'
    magenta: '${color_24}'
    cyan:    '${color_23}'
    white:   '${color_16}'

  # Bright colors
  bright:
    black:   '${color_23}'
    red:     '${color_25}'
    green:   '${color_18}'
    yellow:  '${color_07}'
    blue:    '${color_13}'
    magenta: '${color_24}'
    cyan:    '${color_23}'
    white:   '${color_21}'

  indexed_colors:
    - { index: 16, color: '${color_20}' }
    - { index: 17, color: '${color_25}' }
    
  ]]     ,
        alacrittyColors
    )

    return alacritty
end

return M
