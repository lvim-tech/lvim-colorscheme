local config = require("lvim-colorscheme.config")

local M = {}

---@type {light?: string, dark?: string}
M.styles = {}

---@param opts? lvim-colorscheme.Config
function M.load(opts)
    opts = require("lvim-colorscheme.config").extend(opts)
    local bg = vim.o.background
    local style_bg = opts.style == "day" and "light" or "dark"

    if bg ~= style_bg then
        if vim.g.colors_name == "lvim-" .. opts.style then
            opts.style = bg == "light" and (M.styles.light or "lvim_light") or (M.styles.dark or "lvim_dark")
        else
            vim.o.background = style_bg
        end
    end
    M.styles[vim.o.background] = opts.style
    return require("lvim-colorscheme.theme").setup(opts)
end

--- Configure the colorscheme and register the optional autocmds (auto background swap).
---@param opts? lvim-colorscheme.Config
function M.setup(opts)
    config.setup(opts)
    local grp = vim.api.nvim_create_augroup("lvim_colorscheme", { clear = true })
    -- Auto background: when `vim.o.background` flips, reload with the style for that
    -- background (style for dark, light_style for light). Only the lvim styles are touched.
    vim.api.nvim_create_autocmd("OptionSet", {
        group = grp,
        pattern = "background",
        callback = function()
            local o = config.options or config.defaults
            if not o.auto_background or not vim.g.colors_name or not vim.g.colors_name:match("^lvim%-") then
                return
            end
            local style = vim.v.option_new == "light" and o.light_style or o.style
            vim.schedule(function()
                M.load({ style = style })
            end)
        end,
    })
end

--- Register a callback that fires every time the colorscheme loads.
--- The callback receives (colors: ColorScheme, opts: Config).
--- Fires before the User LvimColorscheme autocmd.
---@param fn fun(colors: ColorScheme, opts: lvim-colorscheme.Config)
function M.on_colors(fn)
    table.insert(require("lvim-colorscheme.state").listeners, fn)
end

-- Make M.colors and M.opts live properties — always reflect the current state.
setmetatable(M, {
    __index = function(_, k)
        if k == "colors" or k == "opts" then
            return require("lvim-colorscheme.state")[k]
        end
    end,
})

return M
