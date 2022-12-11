local utils = require("lvim-colorscheme.utils")

local M = {}

function M.generate(colors)
    local xr = utils.template(
        [[
! Lvim Xresources Colors

*background: ${bg_01}
*foreground: ${fg_05}

*color0: ${bg_01}
*color1: ${red_02}
*color2: ${green_02}
*color3: ${orange_02}
*color4: ${blue_02}
*color5: ${teal_02}
*color6: ${cyan_01}
*color7: ${fg_05}

*color8: ${orange_03}
*color9: ${red_03}
*color10: ${green_03}
*color11: ${orange_03}
*color12: ${blue_03}
*color13: ${teal_03}
*color14: ${cyan_02}
*color15: ${fg_06}
]],
        colors
    )
    return xr
end

return M
