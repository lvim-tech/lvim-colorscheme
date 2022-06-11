    set -l foreground ${fg}
    set -l selection 415058
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
    
    set -l foreground F2994B
    set -l selection 415058
    set -l comment 83a598
    set -l red 70a9a8
    set -l orange f08628
    set -l yellow 00839F
    set -l green A7C080
    set -l purple F2AF5C
    set -l cyan E6C068
    set -l pink F05F4E
    
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
  