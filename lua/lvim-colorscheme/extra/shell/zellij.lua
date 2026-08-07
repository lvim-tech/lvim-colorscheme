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
    -- A zellij component is `base` plus four `emphasis_*`, all written on that component's own
    -- `background` — so the pairs here are not a guess, the format states them. Twelve of the
    -- thirteen components below paint their background with one of three palette surfaces
    -- (`bg_dark`, `bg_highlight`, `bg_light`), which sit close enough together that a colour
    -- clearing whichever it is NEAREST clears all three; `util.hardest` picks that one.
    --
    -- Measured across the 48 styles before this existed, 1903 of zellij's 3120 text pairs were
    -- under WCAG AA's 4.5:1.
    local function ui(hex)
        local v = hex
        for _ = 1, 3 do
            v = util.ensure_contrast(v, util.hardest(v, colors.bg_dark, colors.bg_highlight, colors.bg_light), 4.5)
        end
        return v
    end

    -- The thirteenth is `ribbon_selected`, whose background is the palette's **green** — an accent
    -- used as a surface. Its own label is floored the way every strip in this repo is: the green
    -- must stay green (a selected tab that is no longer the accent has stopped being the selected
    -- tab), so the text is chosen from the two the theme has and the green gives a step of hsluv
    -- lightness only where that is not enough.
    --
    -- Its four `emphasis_*` are DELIBERATELY left at the palette's accents, and the reason is
    -- arithmetic rather than taste. The ribbon lands between 0.12 and 0.30 relative luminance on
    -- these 48 palettes, and 4.5:1 against a surface at luminance L admits only text below
    -- (L+0.05)/4.5-0.05 or above 4.5*(L+0.05)-0.05. Measured on the generated ribbons: tokyonight
    -- leaves **0.0126** at the bottom and needs 1.22 at the top, which is brighter than white, so
    -- only near-black qualifies — the four floored colours came out #201a1b, #1f1c1b, #1e1c22 and
    -- #1c1b1e, four hues turned into one. everforest_soft goes the other way and gives #fffafa,
    -- #fffbfa, #fffcfc and #fbfbfc, four hues turned into white. An emphasis colour exists to say
    -- WHICH of four things this is; floored on this background it can no longer say anything, and
    -- 1.02:1 reported honestly is worth more than 4.5:1 that has destroyed the distinction.
    -- Clearing the floor here would need the ribbon itself to stop being the accent.
    local ribbon_fg = util.readable_on(colors.green, colors.bg_dark)
    local ribbon_bg = util.ensure_contrast(colors.green, ribbon_fg, 4.5)

    local t = setmetatable({
        z_ribbon_fg = ribbon_fg,
        z_ribbon_bg = ribbon_bg,
        z_ribbon_e0 = colors.red,
        z_ribbon_e1 = colors.orange,
        z_ribbon_e2 = colors.magenta,
        z_ribbon_e3 = colors.purple,

        -- The ten player colours are left exactly as the palette has them. They are identity —
        -- which of ten people a cursor or a frame belongs to — and nothing is read against them,
        -- so flooring would only make ten colours chosen to be told APART harder to tell apart.
        -- `extra/desktop/waybar.lua` leaves its accents for the same kind of reason.
        z_player_1 = colors.magenta,
        z_player_2 = colors.blue,
        z_player_3 = colors.green,
        z_player_4 = colors.orange,
        z_player_5 = colors.purple,
        z_player_6 = colors.teal,
        z_player_7 = colors.cyan,
        z_player_8 = colors.yellow,
        z_player_9 = colors.red,
        z_player_10 = colors.comment,
    }, {
        __index = function(_, k)
            local v = colors[k]
            if type(v) == "string" and v:match("^#%x%x%x%x%x%x$") and not k:match("^bg") then
                return ui(v)
            end
            return v
        end,
    })

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
            base "${z_ribbon_fg}"
            background "${z_ribbon_bg}"
            emphasis_0 "${z_ribbon_e0}"
            emphasis_1 "${z_ribbon_e1}"
            emphasis_2 "${z_ribbon_e2}"
            emphasis_3 "${z_ribbon_e3}"
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
            player_1 "${z_player_1}"
            player_2 "${z_player_2}"
            player_3 "${z_player_3}"
            player_4 "${z_player_4}"
            player_5 "${z_player_5}"
            player_6 "${z_player_6}"
            player_7 "${z_player_7}"
            player_8 "${z_player_8}"
            player_9 "${z_player_9}"
            player_10 "${z_player_10}"
        }
    }
}
]],
        t
    )
end

return M
