-- lvim-colorscheme.extra.keyforge: generate a keyforge theme file from the lvim-colorscheme palette.
--
-- keyforge is a Bubble Tea key/secret manager. Like the other tools in the family it now reads a
-- per-app palette from `~/.config/keyforge/themes/<name>.yaml`:
--
--     mkdir -p ~/.config/keyforge/themes
--     cp extras/keyforge/*.yaml ~/.config/keyforge/themes/
--
-- keyforge uses more hues than clipack (it tells apart six meanings by colour — red/yellow/green/
-- blue/purple/orange — where clipack rules two of them out), so its file carries the ten roles its
-- UI needs rather than clipack's nine semantic ones. The hues are the palette's own; the surfaces
-- (`bg`, `bg_alt`) are the palette's too, blended the way keyforge's own loader blends them.
--
-- The two TEXT roles are NOT handed over raw. They used to be — `fg` straight off the palette and
-- `dim` blended off it — on the strength of the loader lifting anything below its floor on load.
-- Measured 2026-08-19 against the reference rendering (3.084:1), that lift is not what reaches the
-- screen: `dim` came out at 1.46:1 on kanagawa_soft and 1.57:1 on everforest_dark, and `fg` itself
-- failed in the nine muted-foreground styles. Which is the same lesson clipack already carries —
-- an EDITOR foreground is tuned against one background under syntax highlighting, and a TUI that
-- paints it as plain text on two surfaces needs a floor applied where the file is WRITTEN, not
-- trusted to an app-side clamp. So both text roles clear their floor here, against BOTH surfaces.
--
---@module "lvim-colorscheme.extra.keyforge"

local util = require("lvim-colorscheme.util")

local M = {}

-- blend mixes two "#rrggbb" colours by t, matching keyforge's own blend(): a linear interpolation
-- in RGB. bg_alt is bg nudged a step toward fg; dim is fg pulled most of the way back to bg.
local function blend(a, b, t)
    local function rgb(h)
        h = h:gsub("#", "")
        return tonumber(h:sub(1, 2), 16), tonumber(h:sub(3, 4), 16), tonumber(h:sub(5, 6), 16)
    end
    local ar, ag, ab = rgb(a)
    local br, bg, bb = rgb(b)
    local function mix(x, y)
        return math.floor(x + (y - x) * t + 0.5)
    end
    return string.format("#%02x%02x%02x", mix(ar, br), mix(ag, bg), mix(ab, bb))
end

--- @param colors ColorScheme
--- @param _ table  highlight groups, unused: keyforge maps from the palette
--- @param opts table
function M.generate(colors, _, opts)
    -- The surfaces first: they are what the text has to clear, and they do not move. `bg_alt` is
    -- the palette background nudged a step toward the palette foreground — the raw one, so the
    -- selected-row surface stays exactly the shade it has always been.
    local bg = colors.bg
    local bg_alt = blend(colors.bg, colors.fg, 0.06)

    -- Text is drawn on BOTH surfaces, so both have to be cleared. `ensure_contrast` is a floor and
    -- walks hsluv lightness away from the background, so applying it twice is monotone: the second
    -- call can only push further out, never back across the first. Body text at 4.5 (WCAG AA),
    -- secondary text at 3.2 — the same tier clipack's `muted` uses, which is what the reference
    -- rendering was measured on.
    local fg = util.ensure_contrast(colors.fg, bg, 4.5)
    fg = util.ensure_contrast(fg, bg_alt, 4.5)
    -- `dim` is derived from the LIFTED foreground, not the palette one: blended off a foreground
    -- that is itself unreadable it started below the floor and had to be dragged back up, which
    -- cost the tier its relation to the body text. Pulled most of the way back to the background
    -- from a foreground that reads, it lands under `fg` and stays there — the floor below only
    -- catches the styles whose foreground and background sit too close to leave room.
    local dim = blend(fg, bg, 0.45)
    dim = util.ensure_contrast(dim, bg, 3.2)
    dim = util.ensure_contrast(dim, bg_alt, 3.2)

    -- The title ink: chip names sit ON `blue` and the active tab label ON `orange`, so ONE
    -- colour has to read on BOTH accents. The rule lives in `util.title_fg` and is judged once
    -- per theme on EVERY surface the badge-painting family paints (these raw hues and the tui9
    -- apps' terminal-floored accents alike), so all seven apps put byte-identical ink on their
    -- chips. 4.5 everywhere is not always reachable (kanagawa's blue caps at 3.80:1 with pure
    -- black), and the accents are shared semantic hues this file must not move; the best end
    -- always clears the 3.084 reference floor.
    local title_fg = util.title_fg(colors)

    colors.keyforge_theme_name = "Lvim" .. (opts.style:gsub("^%l", string.upper))
    colors.keyforge_bg = bg
    colors.keyforge_bg_alt = bg_alt
    colors.keyforge_fg = fg
    colors.keyforge_dim = dim
    colors.keyforge_red = colors.red
    colors.keyforge_yellow = colors.yellow
    colors.keyforge_green = colors.green
    colors.keyforge_blue = colors.blue
    colors.keyforge_purple = colors.purple
    colors.keyforge_orange = colors.orange
    colors.keyforge_title_fg = title_fg

    return util.template(
        [[---
# ${keyforge_theme_name}
# Generated by lvim-colorscheme for keyforge — https://github.com/lvim-tech/keyforge
#
# Install:
#   mkdir -p ~/.config/keyforge/themes
#   cp extras/keyforge/*.yaml ~/.config/keyforge/themes/
#
# Use, in keyforge's config: theme: ${keyforge_theme_name}
#
# fg and dim already clear their contrast floor against BOTH bg and bg_alt
# (4.5 and 3.2), so keyforge's own load-time lift has nothing left to do here;
# a missing role still falls back to the built-in Everforest.

name: ${keyforge_theme_name}

colors:
    # Base background and the one-step-off surface (selected rows).
    bg: "${keyforge_bg}"
    bg_alt: "${keyforge_bg_alt}"
    # Default foreground and the dimmed secondary text.
    fg: "${keyforge_fg}"
    dim: "${keyforge_dim}"
    # Semantic hues: red danger, yellow caution, green ok, blue key,
    # purple prior/context, orange note.
    red: "${keyforge_red}"
    yellow: "${keyforge_yellow}"
    green: "${keyforge_green}"
    blue: "${keyforge_blue}"
    purple: "${keyforge_purple}"
    orange: "${keyforge_orange}"
    # Text on the accent surfaces: chip names on `blue`, the active tab on `orange`.
    title_fg: "${keyforge_title_fg}"
]],
        colors
    )
end

return M
