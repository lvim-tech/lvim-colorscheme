-- lvim-colorscheme.extra.waybar: generate a Waybar theme/colour config from the lvim-colorscheme palette.
--
---@module "lvim-colorscheme.extra.waybar"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors, _, opts)
    -- Colours only, as named @define-color values. The 190 lines of
    -- structure this used to duplicate per theme live once in the user's
    -- structure.css, which current.css imports AFTER this palette so every
    -- @name is already defined when it is used.
    local waybar = util.template(
        [[
@define-color bg ${bg};
@define-color bg_dark ${bg_dark};
@define-color fg ${fg};
@define-color fg_light ${fg_light};
@define-color fg_soft_dark ${fg_soft_dark};
@define-color red ${red};
@define-color orange ${orange};
@define-color yellow ${yellow};
@define-color green ${green};
@define-color teal ${teal};
@define-color cyan ${cyan};
@define-color cyan_dark ${cyan_dark};
@define-color blue ${blue};]],
        colors
    )

    return waybar
end

return M
