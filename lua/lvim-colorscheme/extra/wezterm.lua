local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    return util.template(
        [[
[colors]
foreground = "${fg}"
background = "${bg_soft_dark}"
cursor_bg = "${green}"
cursor_fg = "${bg_dark}"
cursor_border = "${green}"
selection_fg = "${fg}"
selection_bg = "${bg_visual}"
scrollbar_thumb = "${bg_highlight}"
split = "${bg_highlight}"

ansi = [
  "${terminal.black}",
  "${terminal.red}",
  "${terminal.green}",
  "${terminal.yellow}",
  "${terminal.blue}",
  "${terminal.magenta}",
  "${terminal.cyan}",
  "${terminal.white}",
]
brights = [
  "${terminal.black_bright}",
  "${terminal.red_bright}",
  "${terminal.green_bright}",
  "${terminal.yellow_bright}",
  "${terminal.blue_bright}",
  "${terminal.magenta_bright}",
  "${terminal.cyan_bright}",
  "${terminal.white_bright}",
]

[colors.tab_bar]
background = "${bg_dark}"

[colors.tab_bar.active_tab]
bg_color = "${blue}"
fg_color = "${bg_dark}"

[colors.tab_bar.inactive_tab]
bg_color = "${bg_highlight}"
fg_color = "${bg}"]],
        colors
    )
end

return M
