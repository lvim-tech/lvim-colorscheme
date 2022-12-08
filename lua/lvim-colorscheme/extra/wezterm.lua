local utils = require("lvim-colorscheme.utils")

local M = {}

function M.generate(colors)
    local wezterm = utils.template(
        [[
return {
    background = "${bg_01}",
	foreground = "${orange_03}",
	cursor_bg = "${orange_03}",
	cursor_fg = "${bg_01}",
	cursor_border = "${orange_03}",
	compose_cursor = "${bg_01}",
	ansi = {
		"${bg_01}",
		"${red_02}",
		"${green_02}",
		"${orange_02}",
        "${blue_01}",
		"${teal_02}",
		"${cyan_01}",
		"${fg_05}",
	},
	brights = {
		"${orange_03}",
		"${red_03}",
		"${green_03}",
		"${orange_03}",
        "${blue_02}",
		"${teal_03}",
		"${cyan_02}",
		"${fg_06}",
	},
}
  ]],
        colors
    )
    return wezterm
end

return M
