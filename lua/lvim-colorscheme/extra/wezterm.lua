local util = require("lvim-colorscheme.util")

local M = {}

function M.generate(colors)
    local wezterm = util.template(
        [[
return {
	foreground = "${color_21}",
	background = "${color_03}",
	cursor_bg = "${color_21}",
	cursor_fg = "${color_03}",
	cursor_border = "${color_21}",
	compose_cursor = "${color_21}",
	ansi = {
		"${color_03}",
		"${color_25}",
		"${color_18}",
		"${color_07}",
		"${color_13}",
		"${color_24}",
		"${color_23}",
		"${color_16}",
	},
	brights = {
		"${color_23}",
		"${color_25}",
		"${color_18}",
		"${color_08}",
		"${color_13}",
		"${color_24}",
		"${color_23}",
		"${color_21}",
	},
}
  ]],
        colors
    )
    return wezterm
end

return M
