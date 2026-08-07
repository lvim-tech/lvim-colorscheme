-- lvim-colorscheme.extra.waybar: generate a Waybar theme/colour config from the lvim-colorscheme palette.
--
---@module "lvim-colorscheme.extra.waybar"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    -- Colours only, as named @define-color values. The 190 lines of
    -- structure this used to duplicate per theme live once in the user's
    -- structure.css, which current.css imports AFTER this palette so every
    -- @name is already defined when it is used.
    -- The three FOREGROUND names are floored against `bg`, the bar this palette also defines.
    -- A name emitted into a bar stylesheet as `fg` has exactly one job there, and measured across
    -- the 48 palettes the editor foreground read at 2.09:1 on that bar — an editor foreground is
    -- tuned against one background under syntax highlighting, and a status bar is a different job.
    --
    -- The nine accents below are left VERBATIM, and that is deliberate rather than an omission: a
    -- waybar module writes its accent as text *and* paints its urgent or active state with it as a
    -- background, and which of the two a given `@name` is used for is decided in the user's own
    -- structure.css, which this file cannot see. Flooring them would lighten every active-module
    -- background to fix text that may not be there. `bg` and `bg_dark` are surfaces and stay too.
    local floored = vim.tbl_extend("force", colors, {
        wb_fg = util.ensure_contrast(colors.fg, colors.bg, 4.5),
        wb_fg_light = util.ensure_contrast(colors.fg_light, colors.bg, 4.5),
        wb_fg_soft_dark = util.ensure_contrast(colors.fg_soft_dark, colors.bg, 4.5),
    })
    local waybar = util.template(
        [[
@define-color bg ${bg};
@define-color bg_dark ${bg_dark};
@define-color fg ${wb_fg};
@define-color fg_light ${wb_fg_light};
@define-color fg_soft_dark ${wb_fg_soft_dark};
@define-color red ${red};
@define-color orange ${orange};
@define-color yellow ${yellow};
@define-color green ${green};
@define-color teal ${teal};
@define-color cyan ${cyan};
@define-color cyan_dark ${cyan_dark};
@define-color blue ${blue};]],
        floored
    )

    return waybar
end

return M
