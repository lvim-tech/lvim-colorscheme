local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
  colors.bg_search = util.blend_bg(colors.info, 0.1)
  local yazi = util.template([[
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
vimcmd_replace_one_symbol = "[ ](bold ${orange_dark_dark})"
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
style = "bold #000080"

[python]
format = '[ $version]($style) '
style = "bold #3572A5"

[ruby]
format = '[ $version]($style) '
style = "bold #701516"

[nodejs]
format = '[ $version]($style) '
style = "bold #43853D"

[golang]
format = '[ $version]($style) '
style = "bold #00ADD8"

[java]
format = '[ $version]($style) '
style = "bold #B07219"

[rust]
format = '[ $version]($style) '
style = "bold #DEA584"

[php]
format = '[ $version]($style) '
style = "bold #4F5D95"

[elixir]
format = '[ $version]($style) '
style = "bold #6E4A7E"

[swift]
format = '[ $version]($style) '
style = "bold #F05138"

[kotlin]
format = '[ $version]($style) '
style = "bold #A97BFF"

[gradle]
format = '[ $version]($style) '
style = "bold #02303A"

[crystal]
format = '[ $version]($style) '
style = "bold #000000"

[nim]
format = '[ $version]($style) '
style = "bold #FFC200"

[dart]
format = '[ $version]($style) '
style = "bold #00B4AB"

[erlang]
format = '[ $version]$style) '
style = "bold #B83998"

[haskell]
format = '[ $version]($style) '
style = "bold #5e5086"

[c]
format = '[ $version]($style) '
style = "bold #555555"

[shell]
format = '[ $version]($style) '
style = "bold #89e051"

[ocaml]
format = '[ $version]($style) '
style = "bold #3be133"

[scala]
format = '[ $version]($style) '
style = "bold #c22d40"

[perl]
format = '[ $version]($style) '
style = "bold #0298c3"

[haxe]
format = '[ $version]($style) '
style = "bold #df7900"
    ]], colors)
  return yazi
end

return M

