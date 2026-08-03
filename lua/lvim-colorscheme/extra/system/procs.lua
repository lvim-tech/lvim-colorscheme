-- lvim-colorscheme.extra.procs: generate the [style] block of a procs config
-- from the palette.
--
--     mkdir -p ~/.config/procs
--     ln -sf .../extras/procs/LvimNord_dark.toml ~/.config/procs/config.toml
--
-- procs takes 16 names or an xterm-256 INDEX — no hex — so every colour is
-- rounded through extra/ansi.lua, the same rounding miller uses.
--
-- [[columns]] is NOT written on purpose: supplying that array replaces the
-- whole default column set, so a colour scheme that emitted it would also be
-- deciding which columns you see.
--
---@module "lvim-colorscheme.extra.system.procs"

local ansi = require("lvim-colorscheme.extra.ansi")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    local function c(hex)
        return tostring(ansi.to_256(hex))
    end
    return table.concat({
        "[style]",
        'header = "' .. c(colors.blue) .. '"',
        'unit = "' .. c(colors.comment) .. '"',
        'tree = "' .. c(colors.bg_light) .. '"',
        "",
        "[style.by_percentage]",
        'color_000 = "' .. c(colors.blue) .. '"',
        'color_025 = "' .. c(colors.green) .. '"',
        'color_050 = "' .. c(colors.yellow) .. '"',
        'color_075 = "' .. c(colors.orange) .. '"',
        'color_100 = "' .. c(colors.red) .. '"',
        "",
        "[style.by_state]",
        'color_d = "' .. c(colors.red) .. '"',
        'color_r = "' .. c(colors.green) .. '"',
        'color_s = "' .. c(colors.blue) .. '"',
        'color_t = "' .. c(colors.yellow) .. '"',
        'color_z = "' .. c(colors.magenta) .. '"',
        'color_x = "' .. c(colors.comment) .. '"',
        "",
        "[style.by_unit]",
        'color_k = "' .. c(colors.blue) .. '"',
        'color_m = "' .. c(colors.green) .. '"',
        'color_g = "' .. c(colors.yellow) .. '"',
        'color_t = "' .. c(colors.orange) .. '"',
        'color_p = "' .. c(colors.red) .. '"',
        'color_x = "' .. c(colors.comment) .. '"',
        "",
    }, "\n")
end

return M
