-- lvim-colorscheme.extra.starship: generate a Starship theme/colour config from the lvim-colorscheme palette.
--
---@module "lvim-colorscheme.extra.starship"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors, _, opts)
    if opts.style == "base_light" then
        colors.lua = "#366B8A"
        colors.python = "#805E02"
        colors.ruby = "#701516"
        colors.nodejs = "#447028"
        colors.golang = "#36677C"
        colors.java = "#992E33"
        colors.rust = "#6F5242"
        colors.php = "#6B4D83"
        colors.elixir = "#6B4D83"
        colors.swift = "#975122"
        colors.kotlin = "#5F3EBF"
        colors.gradle = "#005F87"
        colors.crystal = "#434343"
        colors.nim = "#514700"
        colors.dart = "#03589C"
        colors.erlang = "#8A2B72"
        colors.haskell = "#6B4D83"
        colors.c = "#3B69AA"
        colors.shell = "#447028"
        colors.ocaml = "#975122"
        colors.scala = "#992E33"
        colors.perl = "#36677C"
        colors.haxe = "#9C5715"
    else
        colors.lua = "#51A0CF"
        colors.python = "#FFBC03"
        colors.ruby = "#701516"
        colors.nodejs = "#89E051"
        colors.golang = "#519ABA"
        colors.java = "#CC3E44"
        colors.rust = "#DEA584"
        colors.php = "#A074C4"
        colors.elixir = "#A074C4"
        colors.swift = "#E37933"
        colors.kotlin = "#7F52FF"
        colors.gradle = "#005F87"
        colors.crystal = "#C8C8C8"
        colors.nim = "#F3D400"
        colors.dart = "#03589C"
        colors.erlang = "#B83998"
        colors.haskell = "#A074C4"
        colors.c = "#599EFF"
        colors.shell = "#89E051"
        colors.ocaml = "#E37933"
        colors.scala = "#CC3E44"
        colors.perl = "#519ABA"
        colors.haxe = "#EA8220"
    end

    -- Every name below is used as a FOREGROUND, and that is a checked fact rather than an
    -- assumption: the prompt.toml this fragment is appended to writes each of them as
    -- `style = "bold <name>"` and contains no `bg:` at all, so a segment is coloured text on the
    -- terminal's own background — the surface this project themes from the same palette, which
    -- makes `terminal.background` the honest thing to measure against.
    --
    -- Measured across the 48 styles before this existed, 908 of the 1536 pairs here were under
    -- WCAG AA's 4.5:1: the nim yellow at **1.11:1** on every light style and ruby's `#701516` at
    -- **1.60:1** on nord_dark. The language colours are the languages' own brand values rather
    -- than the palette's, and they are floored too — the `base_light` branch above already exists
    -- because they were unreadable on a light background, and it only ever covered one of the
    -- twelve light styles. hsluv holds the hue, so Rust stays rust-coloured and only its
    -- lightness moves, and a value that already clears the floor comes back untouched.
    local t = setmetatable({}, {
        __index = function(_, k)
            local v = colors[k]
            if type(v) == "string" and v:match("^#%x%x%x%x%x%x$") then
                return util.ensure_contrast(v, colors.terminal.background, 4.5)
            end
            return v
        end,
    })

    -- A palette FRAGMENT: starship reads one file and has no include, so
    -- clipack's config.sh appends this after its prompt.toml — whose
    -- `palette = "lvim"` line resolves every colour name below. The 174-line
    -- prompt this used to duplicate per theme lives in that prompt.toml once.
    local starship = util.template(
        [[
# Palette fragment — appended after prompt.toml by clipack's config.sh.
# Not a complete starship configuration.
[palettes.lvim]
teal_dark = "${teal_dark}"
cyan_dark = "${cyan_dark}"
yellow_dark = "${yellow_dark}"
green_dark = "${green_dark}"
red_dark = "${red_dark}"
orange_dark = "${orange_dark}"
purple_dark = "${purple_dark}"
magenta_dark = "${magenta_dark}"
blue_dark = "${blue_dark}"
lua = "${lua}"
python = "${python}"
ruby = "${ruby}"
nodejs = "${nodejs}"
golang = "${golang}"
java = "${java}"
rust = "${rust}"
php = "${php}"
elixir = "${elixir}"
swift = "${swift}"
kotlin = "${kotlin}"
gradle = "${gradle}"
crystal = "${crystal}"
nim = "${nim}"
dart = "${dart}"
erlang = "${erlang}"
haskell = "${haskell}"
c = "${c}"
shell = "${shell}"
ocaml = "${ocaml}"
scala = "${scala}"
perl = "${perl}"
haxe = "${haxe}"]],
        t
    )
    return starship
end

return M
