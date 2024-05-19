local config = require("lvim-colorscheme.config")
local setup_theme = require("lvim-colorscheme.theme")

local M = {}

M.init = function(style)
    local theme
    local colors
    local _style
    local ok1, colors1 = pcall(require, "lvim-colorscheme.colors." .. style)
    if not ok1 then
        local ok2, colors2 = pcall(require, "lvim-colorscheme.colors" .. config.default)
        if not ok2 then
            _style = "dark"
            colors = require("lvim-colorscheme.colors.dark")
        else
            _style = config.default
            colors = colors2
        end
    else
        _style = style
        colors = colors1
    end
    colors = vim.tbl_deep_extend("force", {}, colors, config.colors[_style] or {})
    theme = setup_theme.setup(colors)
    -- if vim.g.colors_name then
    --     vim.cmd("hi clear")
    -- end
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
    vim.g.terminal_color_0 = colors.bg_01 -- black
    vim.g.terminal_color_1 = colors.red_02 -- red
    vim.g.terminal_color_2 = colors.green_02 -- green
    vim.g.terminal_color_3 = colors.orange_02 -- yellow
    vim.g.terminal_color_4 = colors.blue_02 -- blue
    vim.g.terminal_color_5 = colors.teal_02 -- magenta
    vim.g.terminal_color_6 = colors.cyan_01 -- cyan
    vim.g.terminal_color_7 = colors.orange_01 -- white
    vim.g.terminal_color_8 = colors.orange_03 -- black
    vim.g.terminal_color_9 = colors.red_03 -- red
    vim.g.terminal_color_10 = colors.green_03 -- green
    vim.g.terminal_color_11 = colors.orange_03 -- yellow
    vim.g.terminal_color_12 = colors.blue_03 -- blue
    vim.g.terminal_color_13 = colors.teal_03 -- magenta
    vim.g.terminal_color_14 = colors.cyan_02 -- cyan
    vim.g.terminal_color_15 = colors.fg_06 -- white
end

M.onColorScheme = function()
    if vim.g.colors_name ~= "lvim" then
        vim.cmd([[autocmd! LvimColorscheme]])
        vim.cmd([[augroup! LvimColorscheme]])
    end
end

function M.autocmds()
    local group = vim.api.nvim_create_augroup("LvimColorscheme", { clear = true })

    vim.api.nvim_create_autocmd("ColorSchemePre", {
        group = group,
        callback = function()
            vim.api.nvim_del_augroup_by_id(group)
        end,
    })
    vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = table.concat(config.sidebars, ","),
        callback = function()
            vim.schedule(function()
                vim.cmd([[ setlocal winhighlight=Normal:SideBar,NormalNC:SideBarNC ]])
            end)
        end,
    })
    if vim.tbl_contains(config.sidebars, "terminal") then
        vim.api.nvim_create_autocmd("TermOpen", {
            group = group,
            callback = function()
                vim.schedule(function()
                    vim.cmd([[ setlocal winhighlight=Normal:SideBar,NormalNC:SideBarNC ]])
                end)
            end,
        })
    end
end

return M
