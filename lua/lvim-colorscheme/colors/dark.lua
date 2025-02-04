---@class Git
---@field add string
---@field change string
---@field delete string

---@class Palette
---@field bg_light string
---@field bg_soft_light string
---@field bg string
---@field bg_soft_dark string
---@field bg_dark string
---@field bg_highlight string
---@field fg_light string
---@field fg_soft_light string
---@field fg string
---@field fg_soft_dark string
---@field fg_dark string
---@field comment string
---@field blue string
---@field blue_dark string
---@field green string
---@field green_dark string
---@field cyan string
---@field cyan_dark string
---@field magenta string
---@field magenta_dark string
---@field orange string
---@field orange_dark string
---@field yellow string
---@field yellow_dark string
---@field purple string
---@field purple_dark string
---@field red string
---@field red_dark string
---@field teal string
---@field teal_dark string
---@field terminal_bg string
---@field git Git
---@type Palette
return {
    bg_light = "#364149",
    bg_soft_light = "#2b343a",
    bg = "#20272b",
    bg_soft_dark = "#1c2125",
    bg_dark = "#181d1f",
    bg_highlight = "#2f3940",

    fg_light = "#55a6ab",
    fg_soft_light = "#4c969a",
    fg = "#5e8888",
    fg_soft_dark = "#3c7478",
    fg_dark = "#374646",

    comment = "#4d6263",

    blue = "#0A85B9",
    blue_dark = "#0974a1",
    green = "#8AA55F",
    green_dark = "#7d9654",
    cyan = "#018FA6",
    cyan_dark = "#01798d",
    magenta = "#c75940",
    magenta_dark = "#b84e36",
    orange = "#FF9C2A",
    orange_dark = "#ff9010",
    yellow = "#edc060",
    yellow_dark = "#eab749",
    purple = "#177ab3",
    purple_dark = "#146b9c",
    red = "#e65e4f",
    red_dark = "#e34a39",
    teal = "#218471",
    teal_dark = "#1c7060",

    terminal_bg = "#1c7060",
    git = {
        add = "#8AA55F",
        change = "#ea953f",
        delete = "#d55137",
    },
}
