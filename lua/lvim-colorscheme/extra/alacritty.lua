local utils = require("lvim-colorscheme.utils")

local M = {}

function M.generate(colors)
    local alacritty_colors = {}
    for k, v in pairs(colors) do
        if type(v) == "string" then
            alacritty_colors[k] = v:gsub("^#", "0x")
        end
    end

    local alacritty = utils.template(
        [[
# Lvim Alacritty Colors
colors:
    # Default colors
    primary:
        background: "${bg_01}"
        foreground: "${orange_03}"
        bright_foreground: "${orange_03}"
    cursor:
        cursor: "${orange_03}"
        text: "${bg_01}"
    vi_mode_cursor:
        cursor: "${fg_05}"
        text: "${bg_01}"
    search:
        matches:
            foreground: "${bg_03}"
            background: "${green_02}"
        focused_match:
            foreground: "${bg_03}"
            background: "${orange_02}"
        bar:
            background: "${bg_01}"
            foreground: "${fg_05}"
    hints:
        start:
            foreground: "${bg_01}"
            background: "${green_01}"
        end:
            foreground: "${green_01}"
            background: "${bg_01}"
    line_indicator:
        foreground: None
        background: None
    selection:
        text: "${fg_05}"
        background: "${bg_05}"
    # Normal colors
    normal:
        black:   "${bg_01}"
        red:     "${red_02}"
        green:   "${green_02}"
        yellow:  "${orange_02}"
        blue:    "${blue_01}"
        magenta: "${teal_02}"
        cyan:    "${cyan_01}"
        white:   "${fg_05}"

    # Bright colors
    bright:
        black:   "${orange_03}"
        red:     "${red_03}"
        green:   "${green_03}"
        yellow:  "${orange_03}"
        blue:    "${blue_02}"
        magenta: "${teal_03}"
        cyan:    "${cyan_02}"
        white:   "${fg_06}"
  ]],
        alacritty_colors
    )

    return alacritty
end

return M
