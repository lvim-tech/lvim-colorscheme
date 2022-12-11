local utils = require("lvim-colorscheme.utils")

local M = {}

function M.generate(colors)
    local kitty = utils.template(
        [[
# Lvim Kitty Colors


background ${bg_01}
foreground ${orange_03}
selection_background ${bg_03}
selection_foreground ${orange_03}

#URL
url_color ${blue_01}

# Cursor
cursor ${orange_03}
cursor_text_color ${bg_01}

# Tabs
active_tab_background ${green_02}
active_tab_foreground ${bg_01}
inactive_tab_background ${bg_01}
inactive_tab_foreground ${green_02}

# Marks
mark1_foreground ${bg_03}
mark1_background ${red_02}

# normal
color0 ${bg_01}
color1 ${red_02}
color2 ${green_02}
color3 ${orange_02}
color4 ${blue_02}
color5 ${teal_02}
color6 ${cyan_01}
color7 ${fg_05}

# bright
color8 ${orange_03}
color9 ${red_03}
color10 ${green_03}
color11 ${orange_03}
color12 ${blue_03}
color13 ${teal_03}
color14 ${cyan_02}
color15 ${fg_06}
  ]],
        colors
    )
    return kitty
end

return M
