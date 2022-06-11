local util = require("lvim-colorscheme.util")

local M = {}

function M.generate(colors)
    local fishColors = {}
    for k, v in pairs(colors) do
        if type(v) == "string" then
            fishColors[k] = v:gsub("^#", "")
        end
    end

    local fish = util.template(
        [[
    set -l foreground ${fg}
    set -l selection ${bg_visual}
    set -l comment ${comment}
    set -l red ${red}
    set -l orange ${orange}
    set -l yellow ${yellow}
    set -l green ${green}
    set -l purple ${purple}
    set -l cyan ${cyan}
    set -l pink ${magenta}
    
    # Syntax Highlighting Colors
    set -g fish_color_normal $foreground
    set -g fish_color_command $cyan
    set -g fish_color_keyword $pink
    set -g fish_color_quote $yellow
    set -g fish_color_redirection $foreground
    set -g fish_color_end $orange
    set -g fish_color_error $red
    set -g fish_color_param $purple
    set -g fish_color_comment $comment
    set -g fish_color_selection --background=$selection
    set -g fish_color_search_match --background=$selection
    set -g fish_color_operator $green
    set -g fish_color_escape $pink
    set -g fish_color_autosuggestion $comment
    
    # Completion Pager Colors
    set -g fish_pager_color_progress $comment
    set -g fish_pager_color_prefix $cyan
    set -g fish_pager_color_completion $foreground
    set -g fish_pager_color_description $comment
    # Lvim Color Palette
    
    set -l foreground ${color_21}
    set -l selection ${bg_visual}
    set -l comment ${color_15}
    set -l red ${color_13}
    set -l orange ${color_20}
    set -l yellow ${color_07}
    set -l green ${color_18}
    set -l purple ${color_22}
    set -l cyan ${color_23}
    set -l pink ${color_24}
    
    # Syntax Highlighting Colors
    set -g fish_color_normal $foreground
    set -g fish_color_command $color_23
    set -g fish_color_keyword $pink
    set -g fish_color_quote $color_07
    set -g fish_color_redirection $foreground
    set -g fish_color_end $color_20
    set -g fish_color_error $red
    set -g fish_color_param $color_22
    set -g fish_color_comment $color_15
    set -g fish_color_selection --background=$selection
    set -g fish_color_search_match --background=$selection
    set -g fish_color_operator $color_18
    set -g fish_color_escape $pink
    set -g fish_color_autosuggestion $color_15
    
    # Completion Pager Colors
    set -g fish_pager_color_progress $color_15
    set -g fish_pager_color_prefix $color_23
    set -g fish_pager_color_completion $foreground
    set -g fish_pager_color_description $color_15
  ]]     ,
        fishColors
    )

    return fish
end

return M
