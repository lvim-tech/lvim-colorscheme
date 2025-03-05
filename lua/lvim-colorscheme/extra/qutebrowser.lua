local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors, _, opts)
    local function capitalizeFirstLetter(str)
        return (str:gsub("^%l", string.upper))
    end

    local nameTheme = "Lvim" .. capitalizeFirstLetter(opts.style)
    local qutebrowser = util.template(
        [[
palette = {
    "background": "${bg}",
    "background-alt": "${bg_soft_light}",
    "background-attention": "${bg_dark}",
    "border": "${bg_soft_dark}",
    "current-line": "${bg_highlight}",
    "selection": "${bg_light}",
    "foreground": "${fg}",
    "foreground-alt": "${fg_light}",
    "foreground-attention": "${fg_soft_light}",
    "comment": "${comment}",
    "cyan": "${cyan}",
    "green": "${green}",
    "orange": "${orange}",
    "pink": "${magenta}",
    "purple": "${purple}",
    "red": "${red}",
    "yellow": "${yellow}",
}
]],
        vim.tbl_extend("force", colors, { style = nameTheme })
    )
    return qutebrowser
end

return M
