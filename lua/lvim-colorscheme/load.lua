local config = require("lvim-colorscheme.config")
local setup_theme = require("lvim-colorscheme.theme")

local M = {}

M.init = function(style)
    local theme
    local colors
    local _style
    local ok1, colors1 = pcall(require, "lvim-colorscheme.colors." .. style)
    if not ok1 then
        local ok2, colors2 = pcall(require, "lvim-colorscheme.colors" .. config.style)
        if not ok2 then
            _style = "dark"
            colors = require("lvim-colorscheme.colors.dark")
        else
            _style = config.style
            colors = colors2
        end
    else
        _style = style
        colors = colors1
    end
    colors = vim.tbl_deep_extend("force", {}, colors, config.colors[_style] or {})
    theme = setup_theme.setup(colors)
    if vim.g.colors_name then
        vim.cmd("hi clear")
    end
    vim.o.termguicolors = true
    vim.g.colors_name = "lvim"
    M.syntax(theme)
    M.terminal(colors)
    M.autocmds()
end

M.syntax = function(syntax)
    for group, colors in pairs(syntax) do
        M.highlight(group, colors)
    end
end

M.highlight = function(group, hl)
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

M.terminal = function(colors)
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

M.onColorScheme = function()
    if vim.g.colors_name ~= "lvim" then
        vim.cmd([[autocmd! LvimColorscheme]])
        vim.cmd([[augroup! LvimColorscheme]])
    end
end

function M.autocmds()
    vim.cmd([[augroup LvimColorscheme]])
    vim.cmd([[autocmd!]])
    vim.cmd([[autocmd ColorScheme * lua require("lvim-colorscheme.load").onColorScheme()]])
    vim.cmd([[augroup end]])
end

return M
