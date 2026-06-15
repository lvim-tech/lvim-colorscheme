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
    -- Restore persisted panel settings (control-center's DB when present, else our own JSON
    -- file). The store wins over `opts`; applied into config.options so the first theme load
    -- already reflects them. Guarded so a persistence hiccup never breaks setup.
    pcall(function()
        require("lvim-colorscheme.settings").restore()
    end)
    -- Mark the configured side-panel filetypes as sidebars (Normal:NormalSB winhighlight).
    require("lvim-colorscheme.sidebar").setup((config.options or config.defaults).sidebar_filetypes)
    local grp = vim.api.nvim_create_augroup("lvim_colorscheme", { clear = true })
    -- Auto background: when `vim.o.background` flips, reload with the theme for that background.
    -- Use the variant the user actually CHOSE for that background — `M.styles[bg]` tracks the
    -- last theme applied per background — NOT the configured default `style`/`light_style`.
    -- Reverting a picked theme to the default on a background flip (then persisting it via the
    -- User autocmd) is exactly the bug this guards against; `style`/`light_style` are only the
    -- fallback for a background no theme has run on yet.
    vim.api.nvim_create_autocmd("OptionSet", {
        group = grp,
        pattern = "background",
        callback = function()
            local o = config.options or config.defaults
            if not o.auto_background or not vim.g.colors_name or not vim.g.colors_name:match("^lvim%-") then
                return
            end
            local new_bg = vim.v.option_new
            local style = (new_bg == "light" and (M.styles.light or o.light_style)) or (M.styles.dark or o.style)
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
        -- Re-applying options must NEVER switch the active theme. An option change — or a
        -- persisted-settings restore (e.g. from control-center's DB on startup) — reverting a
        -- chosen colorscheme to the default is the bug this guards against: load()'s bg-driven
        -- style logic can pick the default style when re-entered. Remember the active theme and
        -- re-assert it if the re-load changed it, so the theme depends ONLY on what was loaded.
        local before = M.current()
        local opts = require("lvim-colorscheme.state").opts
        local style = opts and opts.style
        if style then
            M.load({ style = style })
        end
        if before and M.current() ~= before then
            vim.cmd("colorscheme " .. before)
        end
    end
end

--- Open the runtime configuration panel (also reachable via `:LvimColorscheme config`).
--- Lets you toggle transparency, dim/dark focus cues, syntax italics and more; each change
--- applies live and is persisted (control-center DB or a local JSON file).
function M.config_panel()
    require("lvim-colorscheme.config_ui").open()
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
