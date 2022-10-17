local M = {}

M.bg = "#000000"
M.fg = "#ffffff"
M.brightness = 0.1

local function hexToRgb(c)
    c = string.lower(c)
    return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

function M.blend(foreground, background, alpha)
    alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
    local bg = hexToRgb(background)
    local fg = hexToRgb(foreground)
    local blendChannel = function(i)
        local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end
    return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

function M.darken(hex, amount, bg)
    return M.blend(hex, bg or M.bg, amount)
end

function M.lighten(hex, amount, fg)
    return M.blend(hex, fg or M.fg, amount)
end

function M.invert_color(color)
    local hsluv = require("lvim-colorscheme.hsluv")
    if color ~= "NONE" then
        local hsl = hsluv.hex_to_hsluv(color)
        hsl[3] = 100 - hsl[3]
        if hsl[3] < 40 then
            hsl[3] = hsl[3] + (100 - hsl[3]) * M.brightness
        end
        return hsluv.hsluv_to_hex(hsl)
    end
    return color
end

function M.highlight(group, hl)
    if hl.style then
        if type(hl.style) == "table" then
            hl = vim.tbl_extend("force", hl, hl.style)
        elseif hl.style:lower() ~= "none" then
            for s in string.gmatch(hl.style, "([^,]+)") do
                hl[s] = true
            end
        end
        hl.style = nil
    end
    vim.api.nvim_set_hl(0, group, hl)
end

function M.onColorScheme()
    if vim.g.colors_name ~= "lvim" then
        vim.cmd([[autocmd! LvimColorscheme]])
        vim.cmd([[augroup! LvimColorscheme]])
    end
end

function M.autocmds(config)
    vim.cmd([[augroup LvimColorscheme]])
    vim.cmd([[  autocmd!]])
    vim.cmd([[  autocmd ColorScheme * lua require("lvim-colorscheme.util").onColorScheme()]])
    vim.cmd(
        [[  autocmd FileType ]]
            .. table.concat(config.sidebars, ",")
            .. [[ setlocal winhighlight=Normal:NormalSB,SignColumn:SignColumnSB]]
    )
    if vim.tbl_contains(config.sidebars, "terminal") then
        vim.cmd([[  autocmd TermOpen * setlocal winhighlight=Normal:NormalSB,SignColumn:SignColumnSB]])
    end
    vim.cmd([[augroup end]])
end

function M.template(str, table)
    return (str:gsub("($%b{})", function(w)
        return table[w:sub(3, -2)] or w
    end))
end

function M.syntax(syntax)
    for group, colors in pairs(syntax) do
        M.highlight(group, colors)
    end
end

function M.terminal(colors)
    vim.g.terminal_color_0 = colors.color_03
    vim.g.terminal_color_8 = colors.color_23
    vim.g.terminal_color_7 = colors.color_16
    vim.g.terminal_color_15 = colors.color_21
    vim.g.terminal_color_1 = colors.color_25
    vim.g.terminal_color_9 = colors.color_25
    vim.g.terminal_color_2 = colors.color_18
    vim.g.terminal_color_10 = colors.color_18
    vim.g.terminal_color_3 = colors.color_07
    vim.g.terminal_color_11 = colors.color_08
    vim.g.terminal_color_4 = colors.color_13
    vim.g.terminal_color_12 = colors.color_13
    vim.g.terminal_color_5 = colors.color_24
    vim.g.terminal_color_13 = colors.color_24
    vim.g.terminal_color_6 = colors.color_23
    vim.g.terminal_color_14 = colors.color_23
end

function M.invert_colors(colors)
    if type(colors) == "string" then
        return M.invert_color(colors)
    end
    for key, value in pairs(colors) do
        colors[key] = M.invert_colors(value)
    end
end

function M.invert_highlights(hls)
    for _, hl in pairs(hls) do
        if hl.fg then
            hl.fg = M.invert_color(hl.fg)
        end
        if hl.bg then
            hl.bg = M.invert_color(hl.bg)
        end
        if hl.sp then
            hl.sp = M.invert_color(hl.sp)
        end
    end
end

function M.load(theme)
    if vim.g.colors_name then
        vim.cmd("hi clear")
    end
    vim.o.termguicolors = true
    vim.g.colors_name = "lvim"
    M.syntax(theme.highlights)
    -- vim.api.nvim_set_hl_ns(M.ns)
    if theme.config.terminal_colors then
        M.terminal(theme.colors)
    end

    M.autocmds(theme.config)
end

return M
