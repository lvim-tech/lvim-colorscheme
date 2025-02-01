local util = require("lvim-colorscheme.util")

local M = {}

---@type table<string, Palette|fun(opts:lvim-colorscheme.Config):Palette>
M.styles = setmetatable({}, {
    __index = function(_, style)
        return vim.deepcopy(util.mod("lvim-colorscheme.colors." .. style))
    end,
})

---@param opts? lvim-colorscheme.Config
function M.setup(opts)
    opts = require("lvim-colorscheme.config").extend(opts)

    util.day_brightness = opts.day_brightness

    local palette = M.styles[opts.style]
    if type(palette) == "function" then
        palette = palette(opts) --[[@as Palette]]
    end

    -- Color Palette
    ---@class ColorScheme: Palette
    local colors = palette

    util.bg = colors.bg
    util.fg = colors.fg

    colors.none = "NONE"

    colors.diff = {
        add = util.blend_bg(colors.green_dark, 0.10),
        delete = util.blend_bg(colors.red_dark, 0.10),
        change = util.blend_bg(colors.yellow_dark, 0.10),
        changeDelete = util.blend_bg(colors.orange_dark, 0.10),
        untracked = util.blend_bg(colors.teal_dark, 0.10),
        text = colors.fg,
    }

    colors.git.ignore = colors.bg_soft_light
    colors.black = util.blend_bg(colors.bg, 0.8, "#000000")
    colors.border_highlight = util.blend_bg(colors.green_dark, 0.8)
    colors.border = colors.bg_soft_dark

    -- Popups and statusline always get a dark background
    colors.bg_popup = colors.bg_soft_dark
    colors.bg_statusline = colors.bg_soft_dark

    -- Sidebar and Floats are configurable
    colors.bg_sidebar = opts.styles.sidebars == "transparent" and colors.none
        or opts.styles.sidebars == "dark" and colors.bg_dark
        or colors.bg_soft_dark

    colors.bg_float = opts.styles.floats == "transparent" and colors.none
        or opts.styles.floats == "dark" and colors.bg_dark
        or colors.bg_soft_dark

    colors.bg_visual = util.blend_bg(colors.bg_light, 0.2)
    colors.bg_search = util.blend_bg(colors.bg_light, 0.2)
    colors.fg_sidebar = colors.fg_soft_dark
    colors.fg_float = colors.fg

    colors.error = colors.red_dark
    colors.todo = colors.green_dark
    colors.warning = colors.orange_dark
    colors.info = colors.blue_dark
    colors.hint = colors.teal_dark

    colors.rainbow = {
        colors.green_dark,
        colors.yellow,
        colors.green,
        colors.teal,
        colors.magenta,
        colors.purple,
        colors.orange,
        colors.red,
    }

  -- stylua: ignore
  --- @class TerminalColors
  colors.terminal = {
    black          = colors.black,
    black_bright   = colors.terminal_bg,
    red            = colors.red,
    red_bright     = util.brighten(colors.red),
    green          = colors.green,
    green_bright   = util.brighten(colors.green),
    yellow         = colors.yellow,
    yellow_bright  = util.brighten(colors.yellow),
    blue           = colors.green_dark,
    blue_bright    = util.brighten(colors.green_dark),
    magenta        = colors.magenta,
    magenta_bright = util.brighten(colors.magenta),
    cyan           = colors.cyan,
    cyan_bright    = util.brighten(colors.cyan),
    white          = colors.fg_soft_dark,
    white_bright   = colors.fg,
  }

    opts.on_colors(colors)

    return colors, opts
end

return M
