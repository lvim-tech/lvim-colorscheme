local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors, _, opts)
    local function capitalizeFirstLetter(str)
        return (str:gsub("^%l", string.upper))
    end

    vim.notify(vim.inspect(opts.style))
    local nameTheme = "Lvim" .. capitalizeFirstLetter(opts.style)
    local qtile = util.template(
        [[
${style} = [
    ["${bg}", "${bg}"],
    ["${fg}", "${fg}"],
    ["${bg_soft_dark}", "${bg_soft_dark}"],
    ["${orange_dark}", "${orange_dark}"],
    ["${green_dark}", "${green_dark}"],
    ["${yellow_dark}", "${yellow_dark}"],
    ["${blue_dark}", "${blue_dark}"],
    ["${teal_dark}", "${teal_dark}"],
    ["${cyan_dark}", "${cyan_dark}"],
    ["${red_dark}", "${red_dark}"],
]
]],
        vim.tbl_extend("force", colors, { style = nameTheme })
    )
    return qtile
end

return M
