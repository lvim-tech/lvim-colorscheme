local M = {}

---@param opts? lvim-colorscheme.Config
function M.setup(opts)
    opts = require("lvim-colorscheme.config").extend(opts)

    local colors = require("lvim-colorscheme.colors").setup(opts)
    local groups = require("lvim-colorscheme.groups").setup(colors, opts)

    -- Preview (`opts._preview`, set by the picker's live preview) skips only `hi clear`:
    -- it is unnecessary between lvim variants (the group set is identical, so nvim_set_hl
    -- overwrites cleanly) and clearing flickers the picker's stacked-float borders. The
    -- User autocmd IS still fired so self-theming plugins (lvim-utils etc.) re-sync their
    -- palette and recolour live — that is the whole point of preview.
    local preview = opts._preview == true

    -- only needed to clear when not the default colorscheme
    if vim.g.colors_name and not preview then
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

    -- `dim_inactive`: mute the foreground of non-focused windows via a window-local highlight
    -- namespace (rebuilt here from the freshly-applied groups); off tears it down. Independent
    -- of `dark_active` (a darker bg for the focused window, handled in base.lua). Skipped
    -- during preview (no live windows to manage).
    if not preview then
        local ok_dim, dim = pcall(require, "lvim-colorscheme.dim")
        if ok_dim then
            if opts.dim_inactive then
                dim.enable(colors.bg, opts.dim_inactive_amount)
            else
                dim.disable()
            end
        end
    end

    -- Publish to state and notify listeners
    local state = require("lvim-colorscheme.state")
    state.colors = colors
    state.opts = opts
    for _, fn in ipairs(state.listeners) do
        pcall(fn, colors, opts)
    end
    -- `data` lets listeners persist only COMMITTED changes: the picker's live preview sets
    -- preview = true, so a config can save the theme to its store on a real change while
    -- ignoring the preview keystrokes. `style` is the applied style (e.g. "everforest_dark").
    vim.api.nvim_exec_autocmds("User", {
        pattern = "LvimColorscheme",
        modeline = false,
        data = { style = opts.style, preview = preview },
    })

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
