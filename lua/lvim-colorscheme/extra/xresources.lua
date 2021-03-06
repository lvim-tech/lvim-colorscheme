local util = require("lvim-colorscheme.util")

local M = {}

function M.generate(colors)
    local xr = util.template(
        [[
! Lvim Xresources Colors

*background: ${color_03}
*foreground: ${color_21}

*color0: ${color_03}
*color1: ${color_25}
*color2: ${color_18}
*color3: ${color_07}
*color4: ${color_13}
*color5: ${color_24}
*color6: ${color_23}
*color7: ${color_16}

*color8: ${color_23}
*color9: ${color_25}
*color10: ${color_18}
*color11: ${color_07}
*color12: ${color_13}
*color13: ${color_24}
*color14: ${color_23}
*color15: ${color_21}
]]       ,
        colors
    )
    return xr
end

return M
