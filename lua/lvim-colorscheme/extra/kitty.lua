local util = require("lvim-colorscheme.util")

local M = {}

function M.generate(colors)
    local kitty = util.template(
        [[
# Lvim Kitty Colors

background ${color_03}
foreground ${color_21}
selection_background ${bg_visual}
selection_foreground ${color_21}
url_color ${color_08}
cursor ${color_21}

# Tabs
active_tab_background ${color_13}
active_tab_foreground ${color_01}
inactive_tab_background ${color_02}
inactive_tab_foreground ${color_05}
#tab_bar_background ${color_01}

# normal
color0 ${color_03}
color1 ${color_25}
color2 ${color_18}
color3 ${color_07}
color4 ${color_13}
color5 ${color_24}
color6 ${color_23}
color7 ${color_16}

# bright
color8 ${color_23}
color9 ${color_25}
color10 ${color_18}
color11 ${color_08}
color12 ${color_13}
color13 ${color_24}
color14 ${color_23}
color15 ${color_21}

# extended colors
color16 ${color_20}
color17 ${color_25}
  ]],
        colors
    )
    return kitty
end

return M
