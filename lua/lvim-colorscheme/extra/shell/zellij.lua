-- lvim-colorscheme.extra.zellij: generate a zellij theme from the palette.
--
--     mkdir -p ~/.config/zellij/themes
--     ln -sf .../extras/zellij/LvimNord_dark.kdl ~/.config/zellij/themes/
--     # then in config.kdl: theme "lvim"
--
-- The theme is selected by the BLOCK name, not the file name, so every
-- generated file declares the same block — `theme "lvim"` keeps working when
-- the symlink is repointed at another palette.
--
-- Written in the component format (text_unselected, ribbon_*, frame_*, ...);
-- the older flat palette form is still accepted by zellij but cannot express
-- the selected/unselected split.
--
---@module "lvim-colorscheme.extra.shell.zellij"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    return util.template(
        [[
// ${_style_name}
themes {
    lvim {
        text_unselected {
            base "${fg}"
            background "${bg_dark}"
            emphasis_0 "${orange}"
            emphasis_1 "${cyan}"
            emphasis_2 "${green}"
            emphasis_3 "${magenta}"
        }
        text_selected {
            base "${fg_light}"
            background "${bg_highlight}"
            emphasis_0 "${orange}"
            emphasis_1 "${cyan}"
            emphasis_2 "${green}"
            emphasis_3 "${magenta}"
        }
        ribbon_selected {
            base "${bg_dark}"
            background "${green}"
            emphasis_0 "${red}"
            emphasis_1 "${orange}"
            emphasis_2 "${magenta}"
            emphasis_3 "${purple}"
        }
        ribbon_unselected {
            base "${fg}"
            background "${bg_light}"
            emphasis_0 "${orange}"
            emphasis_1 "${fg_light}"
            emphasis_2 "${magenta}"
            emphasis_3 "${purple}"
        }
        table_title {
            base "${green}"
            background "${bg_dark}"
            emphasis_0 "${orange}"
            emphasis_1 "${cyan}"
            emphasis_2 "${green}"
            emphasis_3 "${magenta}"
        }
        table_cell_selected {
            base "${fg_light}"
            background "${bg_highlight}"
            emphasis_0 "${orange}"
            emphasis_1 "${cyan}"
            emphasis_2 "${green}"
            emphasis_3 "${magenta}"
        }
        table_cell_unselected {
            base "${fg}"
            background "${bg_dark}"
            emphasis_0 "${orange}"
            emphasis_1 "${cyan}"
            emphasis_2 "${green}"
            emphasis_3 "${magenta}"
        }
        list_selected {
            base "${fg_light}"
            background "${bg_highlight}"
            emphasis_0 "${orange}"
            emphasis_1 "${cyan}"
            emphasis_2 "${green}"
            emphasis_3 "${magenta}"
        }
        list_unselected {
            base "${fg}"
            background "${bg_dark}"
            emphasis_0 "${orange}"
            emphasis_1 "${cyan}"
            emphasis_2 "${green}"
            emphasis_3 "${magenta}"
        }
        frame_selected {
            base "${blue}"
            background "${bg_dark}"
            emphasis_0 "${orange}"
            emphasis_1 "${cyan}"
            emphasis_2 "${green}"
            emphasis_3 "${magenta}"
        }
        frame_highlight {
            base "${orange}"
            background "${bg_dark}"
            emphasis_0 "${magenta}"
            emphasis_1 "${cyan}"
            emphasis_2 "${green}"
            emphasis_3 "${purple}"
        }
        exit_code_success {
            base "${green}"
            background "${bg_dark}"
            emphasis_0 "${teal}"
            emphasis_1 "${cyan}"
            emphasis_2 "${green}"
            emphasis_3 "${magenta}"
        }
        exit_code_error {
            base "${red}"
            background "${bg_dark}"
            emphasis_0 "${orange}"
            emphasis_1 "${yellow}"
            emphasis_2 "${magenta}"
            emphasis_3 "${purple}"
        }
        multiplayer_user_colors {
            player_1 "${magenta}"
            player_2 "${blue}"
            player_3 "${green}"
            player_4 "${orange}"
            player_5 "${purple}"
            player_6 "${teal}"
            player_7 "${cyan}"
            player_8 "${yellow}"
            player_9 "${red}"
            player_10 "${comment}"
        }
    }
}
]],
        colors
    )
end

return M
