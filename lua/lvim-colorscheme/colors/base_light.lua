---@param opts lvim-colorscheme.Config
return function(opts)
    local style = opts.light_style or "base_dark"
    -- normalise ANY light base to its dark sibling (this module INVERTS a dark palette); guarding only the
    -- self-reference let a user's `light_style = "everforest_light"` index a function value and crash.
    style = style:match("_light$") and (style:gsub("_light$", "_dark")) or style

    local util = require("lvim-colorscheme.util")

    ---@type Palette
    local colors = vim.deepcopy(util.mod("lvim-colorscheme.colors." .. style))

    ---@type Palette

    util.invert(colors)

    colors.bg_light = "#eeeeee"
    colors.bg_soft_light = "#e9e9e9"
    colors.bg = "#E4E4E4"
    colors.bg_soft_dark = "#dfdfdf"
    colors.bg_dark = "#dadada"

    colors.fg_light = "#55a6ab"
    colors.fg_soft_light = "#4c969a"
    colors.fg = "#5e8888"
    colors.fg_soft_dark = "#3c7478"
    return colors
end
