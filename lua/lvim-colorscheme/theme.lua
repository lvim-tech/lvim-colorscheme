local M = {}

---@param opts? lvim-colorscheme.Config
function M.setup(opts)
    opts = require("lvim-colorscheme.config").extend(opts)

    local colors = require("lvim-colorscheme.colors").setup(opts)
    local groups = require("lvim-colorscheme.groups").setup(colors, opts)

    -- only needed to clear when not the default colorscheme
    if vim.g.colors_name then
        vim.cmd("hi clear")
    end

    vim.o.termguicolors = true
    vim.g.colors_name = "lvim-" .. opts.style

    for group, hl in pairs(groups) do
        hl = type(hl) == "string" and { link = hl } or hl
        vim.api.nvim_set_hl(0, group, hl)
    end

    if opts.terminal_colors then
        M.terminal(colors)
    end

    return colors, groups, opts
end

---@param colors ColorScheme
function M.terminal(colors)
    -- stylua: ignore
    local map = {
        { 0, "black" }, { 8,  "black_bright"   },
        { 7, "white" }, { 15, "white_bright"   },
        { 1, "red"   }, { 9,  "red_bright"     },
        { 2, "green" }, { 10, "green_bright"   },
        { 3, "yellow"}, { 11, "yellow_bright"  },
        { 4, "blue"  }, { 12, "blue_bright"    },
        { 5, "magenta"},{ 13, "magenta_bright" },
        { 6, "cyan"  }, { 14, "cyan_bright"    },
    }
    for _, pair in ipairs(map) do
        vim.g["terminal_color_" .. pair[1]] = colors.terminal[pair[2]]
    end
end

return M
