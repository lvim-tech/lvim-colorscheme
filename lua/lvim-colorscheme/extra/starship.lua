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

    local starship = util.template(
        [[
"$schema" = "https://starship.rs/config-schema.json"

add_newline = true

format = "$all$username$time$character"

[memory_usage]
format = "[󰍛 ${ram}]($style) "
disabled = false
threshold = -1
symbol = "󰍛 "
style = "bold ${teal_dark}"

[time]
format = "[$time]($style) "
time_format = "%T"
style = "bold ${cyan_dark}"
disabled = false

[username]
format = "[](${yellow_dark}) [$user]($style) "
disabled = false
show_always = true
style_user = "${green_dark} bold"
style_root = "${red_dark} bold"

[character]
success_symbol = "[ ](bold ${green_dark})"
error_symbol = "[ ](bold ${red_dark})"
vimcmd_replace_one_symbol = "[ ](bold ${orange_dark})"
vimcmd_replace_symbol = "[ ](bold ${orange_dark})"
vimcmd_symbol = "[ ](bold dimmed ${green_dark})"
vimcmd_visual_symbol = "[ ](bold dimmed ${green_dark})"

[directory]
truncation_length = 3
truncate_to_repo = false
truncation_symbol = " …/"
home_symbol = " "
style = "bold ${purple_dark}"
read_only_style = "bold ${red_dark}"

[git_branch]
format = '[$symbol$branch(:$remote_branch)]($style) '
symbol = " "
style = "bold ${yellow_dark}"

[git_commit]
format = '[ $hash$tag]($style) '
commit_hash_length = 7
style = "bold ${magenta_dark}"

[git_status]
format = '([](${yellow_dark}) [$all_status$ahead_behind]($style)[](${yellow_dark}) )'
ahead = " "
behind = " "
diverged = " "
untracked = " "
stashed = " "
modified = " "
staged = " "
conflicted = " "

[hostname]
ssh_only = true
style = "bold dimmed ${green_dark}"

[jobs]
symbol = "✦ "
style = "bold ${blue_dark}"

[line_break]
disabled = false

[cmd_duration]
format = '[$duration]($style)'
min_time = 500
show_milliseconds = true
style = "bold ${red_dark}"

[package]
format = '[ $version](bold ${orange_dark}) '

[lua]
format = '[󰢱 $version]($style) '
style = "bold ${lua}"

[python]
format = '[ $version]($style) '
style = "bold ${python}"

[ruby]
format = '[ $version]($style) '
style = "bold ${ruby}"

[nodejs]
format = '[ $version]($style) '
style = "bold ${nodejs}"

[golang]
format = '[ $version]($style) '
style = "bold ${golang}"

[java]
format = '[ $version]($style) '
style = "bold ${java}"

[rust]
format = '[ $version]($style) '
style = "bold ${rust}"

[php]
format = '[ $version]($style) '
style = "bold ${php}"

[elixir]
format = '[ $version]($style) '
style = "bold ${elixir}"

[swift]
format = '[ $version]($style) '
style = "bold ${swift}"

[kotlin]
format = '[ $version]($style) '
style = "bold ${kotlin}"

[gradle]
format = '[ $version]($style) '
style = "bold ${gradle}"

[crystal]
format = '[ $version]($style) '
style = "bold ${crystal}"

[nim]
format = '[ $version]($style) '
style = "bold ${nim}"

[dart]
format = '[ $version]($style) '
style = "bold ${dart}"

[erlang]
format = '[ $version]($style) '
style = "bold ${erlang}"

[haskell]
format = '[ $version]($style) '
style = "bold ${haskell}"

[c]
format = '[ $version]($style) '
style = "bold ${c}"

[shell]
format = '[ $version]($style) '
style = "bold ${shell}"

[ocaml]
format = '[ $version]($style) '
style = "bold ${ocaml}"

[scala]
format = '[ $version]($style) '
style = "bold ${scala}"

[perl]
format = '[ $version]($style) '
style = "bold ${perl}"

[haxe]
format = '[ $version]($style) '
style = "bold ${haxe}"
    ]],
        colors
    )
    return starship
end

return M
