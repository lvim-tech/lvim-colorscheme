-- lvim-colorscheme.extra.starship: generate a Starship theme/colour config from the lvim-colorscheme palette.
--
---@module "lvim-colorscheme.extra.starship"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors, _, opts)
    if opts.style == "lvim_light" then
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
        colors
    )
    return starship
end

return M
