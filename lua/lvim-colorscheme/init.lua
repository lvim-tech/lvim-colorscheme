-- lvim-colorscheme.init: the plugin's public entry point.
-- Owns setup() (option merge + the optional auto-background / `remember` autocmds), the
-- theme load/reload paths, and the runtime API other plugins build on (colorschemes /
-- current / set / config_panel). Reads the live config table directly (no defaults/options
-- split) and exposes `M.colors` / `M.opts` as live properties backed by `state`.
--
---@module "lvim-colorscheme"

local config = require("lvim-colorscheme.config")
local state = require("lvim-colorscheme.state")
local util = require("lvim-colorscheme.util")
local sidebar = require("lvim-colorscheme.sidebar")
local store = require("lvim-colorscheme.store")
local theme = require("lvim-colorscheme.theme")
local utils = require("lvim-utils.utils")

local M = {}

---@type {light?: string, dark?: string}
M.styles = {}

--- Load and apply a colorscheme, honouring `vim.o.background`. Overlays `opts` on the live
--- config for this apply only (the picker's `_preview` path uses the same seam).
---@param opts? lvim-colorscheme.Config
---@return ColorScheme colors, lvim-colorscheme.Highlights groups, lvim-colorscheme.Config opts
function M.load(opts)
    opts = config.extend(opts)
    local bg = vim.o.background
    local style_bg = opts.style:match("_light$") and "light" or "dark"

    if bg ~= style_bg then
        if vim.g.colors_name == "lvim-" .. opts.style then
            opts.style = bg == "light" and (M.styles.light or config.light_style) or (M.styles.dark or config.style)
        else
            M.styles[style_bg] = opts.style
            vim.o.background = style_bg
        end
    end
    M.styles[vim.o.background] = opts.style
    return theme.setup(opts)
end

--- Configure the colorscheme and register the optional autocmds (auto background swap).
---@param opts? lvim-colorscheme.Config
function M.setup(opts)
    config.setup(opts)
    -- Restore persisted panel settings from the plugin's own settings document. The store wins over
    -- `opts`; applied into the live config so the first theme load already reflects them. Guarded so
    -- a persistence hiccup never breaks setup.
    pcall(function()
        require("lvim-colorscheme.settings").restore()
    end)
    M.config_command()
    -- Mark the configured side-panel filetypes as sidebars (Normal:NormalSB winhighlight).
    sidebar.setup(config.sidebar_filetypes)
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
            if not config.auto_background or not vim.g.colors_name or not vim.g.colors_name:match("^lvim%-") then
                return
            end
            local new_bg = vim.v.option_new
            vim.schedule(function()
                local style = (new_bg == "light" and (M.styles.light or config.light_style))
                    or (M.styles.dark or config.style)
                if vim.g.colors_name == "lvim-" .. style then
                    return
                end
                M.load({ style = style })
            end)
        end,
    })
    -- `remember`: lvim-colorscheme owns theme persistence. Save every COMMITTED theme change
    -- (live preview sets data.preview = true → skipped) to the store + mirror, and restore the
    -- last theme now so the host need neither persist nor re-apply it.
    if config.remember then
        vim.api.nvim_create_autocmd("User", {
            group = grp,
            pattern = "LvimColorscheme",
            callback = function(ev)
                if ev.data and ev.data.preview == true then
                    return
                end
                local name = M.current()
                if name then
                    store.save_theme(name)
                end
            end,
        })
        -- Restore the remembered theme (store wins; mirror file is the early/standalone
        -- fallback). Applied via `:colorscheme` so it goes through the normal load path; the
        -- apply re-fires the User autocmd above, which seeds the mirror on first run. With
        -- nothing remembered yet, fall back to the configured default `style`.
        local last = store.load_theme()
        if not last or not pcall(vim.cmd, "colorscheme " .. last) then
            M.load()
        end
    end
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

--- Force-reload the active theme without restarting Neovim. Drops the on-disk highlight cache
--- for the active style AND the generated `groups` / `colors` / `theme` modules from
--- `package.loaded`, then re-applies the current colorscheme through the normal `:colorscheme`
--- path — so live edits to palettes/highlights (or a `config.version` bump) take effect at once.
--- Live user options and registered on-load listeners are preserved, so other
--- plugins that self-theme keep their bindings. Edits to `config.lua` itself still need a restart.
---@return boolean ok  -- false when no lvim theme is currently active
function M.reload()
    -- `vim.g.colors_name` stores the underscore STYLE form ("lvim-everforest_soft") — that is the
    -- cache key — while `:colorscheme` expects the dashed COMMAND name ("lvim-everforest-soft"),
    -- which `M.current()` derives. Use each in its right place.
    local style = (vim.g.colors_name or ""):match("^lvim%-(.+)$")
    local cmd_name = M.current()
    if not (style and cmd_name) then
        return false
    end
    -- Bust the cache file for the active style so groups regenerate from source.
    vim.uv.fs_unlink(util.cache.file(style))
    -- Drop only the highlight-producing modules so freshly-edited palettes/highlights are re-read;
    -- keep config (live opts), state (listeners), settings and store intact.
    for mod in pairs(package.loaded) do
        if
            mod:match("^lvim%-colorscheme%.groups")
            or mod:match("^lvim%-colorscheme%.colors")
            or mod == "lvim-colorscheme.theme"
        then
            package.loaded[mod] = nil
        end
    end
    vim.cmd("colorscheme " .. cmd_name)
    return true
end

--- Update colorscheme option(s) at runtime and re-apply the active theme so the change
--- takes effect immediately. Merges `overrides` into the live config (e.g.
--- `{ transparent = true }`, `{ dim_inactive = true }`, `{ dark_active = true }`).
---@param overrides lvim-colorscheme.Config
function M.set(overrides)
    overrides = overrides or {}
    -- Only re-apply when something actually changes, so restoring a value equal to the
    -- current one (e.g. on startup) does not trigger a needless theme reload.
    local changed = false
    for k, v in pairs(overrides) do
        if type(config[k]) == "table" and type(v) == "table" then
            if not vim.deep_equal(config[k], v) then
                changed = true
                break
            end
        elseif config[k] ~= v then
            changed = true
            break
        end
    end
    -- Merge the overrides into the live config IN PLACE (via lvim-utils.utils.merge), so every
    -- reader immediately sees the new effective values — same seam as config.setup().
    utils.merge(config, overrides)
    if changed then
        -- Re-applying options must NEVER switch the active theme. An option change — or a
        -- persisted-settings restore on startup — reverting a
        -- chosen colorscheme to the default is the bug this guards against: load()'s bg-driven
        -- style logic can pick the default style when re-entered. Remember the active theme and
        -- re-assert it if the re-load changed it, so the theme depends ONLY on what was loaded.
        local before = M.current()
        local opts = state.opts
        local style = opts and opts.style
        if style then
            M.load({ style = style })
        end
        if before and M.current() ~= before then
            vim.cmd("colorscheme " .. before)
        end
    end
end

--- Open the runtime configuration panel (also reachable via `:LvimColorschemeConfig`).
--- Lets you toggle transparency, dim/dark focus cues, syntax italics and more; each change
--- applies live and is persisted in the plugin's own settings document.
---@param tab? string|integer  the section to focus — its name ("Background" …) or an index
---@param layout? string  "float" | "area" | "bottom"; overrides `settings_panel.layout`
---@return nil
function M.config_panel(tab, layout)
    require("lvim-colorscheme.panel").open(tab, layout)
end

--- How the panel may be opened, offered as the command's completion.
---@type string[]
local LAYOUTS = { "float", "area", "bottom" }

--- Register the settings-panel command (`settings_panel.command`, `:LvimColorschemeConfig` by
--- default). The plugin's own `:LvimColorscheme` stays the theme PICKER; this is the config panel.
---   :LvimColorschemeConfig [section] [float|area|bottom]
---@return nil
function M.config_command()
    local p = config.settings_panel or {}
    vim.api.nvim_create_user_command(p.command or "LvimColorschemeConfig", function(opts)
        local tab, layout
        for _, arg in ipairs(opts.fargs) do
            if vim.tbl_contains(LAYOUTS, arg) then
                layout = arg
            else
                tab = tab or arg
            end
        end
        M.config_panel(tab, layout)
    end, {
        nargs = "*",
        desc = "lvim-colorscheme: runtime settings panel",
        ---@param lead string  the argument being typed
        ---@param line string  the whole command line so far
        ---@return string[]
        complete = function(lead, line)
            -- Which argument POSITION is being typed: the sections first, the layout after them —
            -- offering every token at every position is what makes a completion unreadable.
            local words = vim.split(vim.trim(line), "%s+")
            local pos = #words - 1 - (lead == "" and 0 or 1)
            local pool = LAYOUTS
            if pos <= 0 then
                pool = {}
                local seen = {}
                for _, spec in ipairs(require("lvim-colorscheme.settings").specs) do
                    if not seen[spec.group] then
                        seen[spec.group] = true
                        pool[#pool + 1] = spec.group
                    end
                end
            end
            return vim.tbl_filter(function(item)
                return item:find(lead, 1, true) == 1
            end, pool)
        end,
    })
end

--- Register a callback that fires every time the colorscheme loads.
--- The callback receives (colors: ColorScheme, opts: Config).
--- Fires before the User LvimColorscheme autocmd.
---@param fn fun(colors: ColorScheme, opts: lvim-colorscheme.Config)
function M.on_colors(fn)
    table.insert(state.listeners, fn)
end

-- Make M.colors and M.opts live properties — always reflect the current state.
setmetatable(M, {
    __index = function(_, k)
        if k == "colors" or k == "opts" then
            return state[k]
        end
    end,
})

return M
