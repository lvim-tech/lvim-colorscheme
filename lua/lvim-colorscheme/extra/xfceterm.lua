local util = require("lvim-colorscheme.util")

local M = {}

function M.generate(colors)
    local xfceterm = util.template(
        [[
[Scheme]
Name=Lvim Colors
ColorBackground=${color_03}
ColorForeground=${color_21}

ColorSelectionBackground=${bg_visual}
ColorSelection=${color_21}

ColorPalette=${color_23};${color_25};${color_18};${color_07};${color_13};${color_24};${color_23};${color_16};${color_03};${color_25};${color_18};${color_07};${color_13};${color_24};${color_23};${color_21}
]]       ,
        colors
    )
    return xfceterm
end

return M
