local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    return util.template(
        [[
background = ${bg_soft_dark}
foreground = ${fg}
cursor-color = ${green}
cursor-text = ${bg_dark}
selection-background = ${bg_visual}
selection-foreground = ${fg}

palette = 0=${terminal.black}
palette = 1=${terminal.red}
palette = 2=${terminal.green}
palette = 3=${terminal.yellow}
palette = 4=${terminal.blue}
palette = 5=${terminal.magenta}
palette = 6=${terminal.cyan}
palette = 7=${terminal.white}
palette = 8=${terminal.black_bright}
palette = 9=${terminal.red_bright}
palette = 10=${terminal.green_bright}
palette = 11=${terminal.yellow_bright}
palette = 12=${terminal.blue_bright}
palette = 13=${terminal.magenta_bright}
palette = 14=${terminal.cyan_bright}
palette = 15=${terminal.white_bright}]],
        colors
    )
end

return M
