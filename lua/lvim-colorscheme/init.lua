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

--- List of every available colorscheme name (the values accepted by `:colorscheme` and the
--- picker), in family/variant order. Build dropdowns from this so they never go stale when
--- new theme families are added.
---@return string[]
function M.colorschemes()
    return require("lvim-colorscheme.picker").list()
end

--- The currently active colorscheme NAME (the `:colorscheme` / picker form, with dashes),
--- or nil when no lvim theme is active. Note: `vim.g.colors_name` itself stores the
--- underscore STYLE form ("lvim-everforest_soft") for internal matching; this returns the
--- canonical command name ("lvim-everforest-soft") so it lines up with `colorschemes()`.
---@return string|nil
function M.current()
    local style = (vim.g.colors_name or ""):match("^lvim%-(.+)$")
    if not style then
        return nil
    end
    return "lvim-" .. (style:gsub("^lvim_", ""):gsub("_", "-"))
end

--- Update colorscheme option(s) at runtime and re-apply the active theme so the change
--- takes effect immediately. Merges `overrides` into the live config (e.g.
--- `{ transparent = true }`, `{ dim_inactive = true }`, `{ dark_active = true }`).
---@param overrides lvim-colorscheme.Config
function M.set(overrides)
    local cfg = require("lvim-colorscheme.config")
    local cur = cfg.options or cfg.defaults
    -- Only re-apply when something actually changes, so restoring a value equal to the
    -- current one (e.g. on startup) does not trigger a needless theme reload.
    local changed = false
    for k, v in pairs(overrides or {}) do
        if cur[k] ~= v then
            changed = true
            break
        end
    end
    cfg.options = vim.tbl_deep_extend("force", {}, cur, overrides or {})
    if changed then
        local opts = require("lvim-colorscheme.state").opts
        local style = opts and opts.style
        if style then
            M.load({ style = style })
        end
    end
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
