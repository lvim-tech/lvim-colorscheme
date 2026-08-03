-- lvim-colorscheme.extra.btop: generate a btop theme from the palette.
--
--     mkdir -p ~/.config/btop/themes
--     ln -sf .../extras/btop/LvimNord_dark.theme ~/.config/btop/themes/
--     # then in ~/.config/btop/btop.conf: color_theme = "LvimNord_dark"
--
-- The nine gradients are what btop actually renders with; giving each a
-- start/mid/end from the palette is why the meters look like the rest of the
-- desktop instead of like btop's own rainbow.
--
---@module "lvim-colorscheme.extra.system.btop"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    return util.template(
        [[
# ${_style_name}
theme[main_bg]="${bg_dark}"
theme[main_fg]="${fg}"
theme[title]="${fg_light}"
theme[hi_fg]="${blue}"
theme[selected_bg]="${bg_highlight}"
theme[selected_fg]="${fg_light}"
theme[inactive_fg]="${comment}"
theme[graph_text]="${fg_dark}"
theme[meter_bg]="${bg_light}"
theme[proc_misc]="${purple}"
theme[cpu_box]="${blue_dark}"
theme[mem_box]="${green_dark}"
theme[net_box]="${red_dark}"
theme[proc_box]="${purple_dark}"
theme[div_line]="${bg_light}"
theme[temp_start]="${teal}"
theme[temp_mid]="${yellow}"
theme[temp_end]="${red}"
theme[cpu_start]="${green}"
theme[cpu_mid]="${yellow}"
theme[cpu_end]="${red}"
theme[free_start]="${green}"
theme[free_mid]="${green_dark}"
theme[free_end]="${teal}"
theme[cached_start]="${cyan}"
theme[cached_mid]="${cyan_dark}"
theme[cached_end]="${blue}"
theme[available_start]="${yellow}"
theme[available_mid]="${orange}"
theme[available_end]="${orange_dark}"
theme[used_start]="${red}"
theme[used_mid]="${red_dark}"
theme[used_end]="${magenta}"
theme[download_start]="${green}"
theme[download_mid]="${teal}"
theme[download_end]="${cyan}"
theme[upload_start]="${orange}"
theme[upload_mid]="${red}"
theme[upload_end]="${magenta}"
theme[process_start]="${blue}"
theme[process_mid]="${purple}"
theme[process_end]="${magenta}"
]],
        colors
    )
end

return M
