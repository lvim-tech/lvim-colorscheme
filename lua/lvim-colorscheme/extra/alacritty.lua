local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    return util.template(
        [[
[colors.primary]
background = "${bg_soft_dark}"
foreground = "${fg}"

[colors.cursor]
text = "${bg_dark}"
cursor = "${green}"

[colors.selection]
text = "${fg}"
background = "${bg_visual}"

[colors.normal]
black = "${terminal.black}"
red = "${terminal.red}"
green = "${terminal.green}"
yellow = "${terminal.yellow}"
blue = "${terminal.blue}"
magenta = "${terminal.magenta}"
cyan = "${terminal.cyan}"
white = "${terminal.white}"

[colors.bright]
black = "${terminal.black_bright}"
red = "${terminal.red_bright}"
green = "${terminal.green_bright}"
yellow = "${terminal.yellow_bright}"
blue = "${terminal.blue_bright}"
magenta = "${terminal.magenta_bright}"
cyan = "${terminal.cyan_bright}"
white = "${terminal.white_bright}"]],
        colors
    )
end

return M
