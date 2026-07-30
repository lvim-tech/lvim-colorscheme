-- lvim-colorscheme.health: :checkhealth lvim-colorscheme.
-- Reports the Neovim version, 'termguicolors', whether lvim-utils (the floating picker) is
-- present, the highlight-cache writability, and the active theme / cache-fingerprint version.
--
---@module "lvim-colorscheme.health"

local config = require("lvim-colorscheme.config")
local state = require("lvim-colorscheme.state")
local groups = require("lvim-colorscheme.groups")

local M = {}

function M.check()
    local health = vim.health
    health.start("lvim-colorscheme")

    if vim.fn.has("nvim-0.10") == 1 then
        health.ok("Neovim >= 0.10")
    else
        health.error("Neovim >= 0.10 is required")
    end

    if vim.o.termguicolors then
        health.ok("'termguicolors' is on")
    else
        health.warn("'termguicolors' is off — true colors won't render (set vim.o.termguicolors = true)")
    end

    -- lvim-ui is only needed for the floating theme picker (:LvimColorscheme).
    if pcall(require, "lvim-ui") then
        health.ok("lvim-ui found — the floating theme picker is available")
    else
        health.info("lvim-ui not found — :LvimColorscheme picker is unavailable")
    end

    -- The settings panel (`:LvimColorschemeConfig`) renders through lvim-ui and persists into the
    -- plugin's own document — reported here so "where did my setting go" has one answer.
    local p = config.settings_panel or {}
    local store = require("lvim-colorscheme.store")
    if pcall(require, "lvim-ui") then
        health.ok(("settings panel available (:%s)"):format(p.command or "LvimColorschemeConfig"))
    else
        health.error("lvim-ui not found — the settings panel is unavailable")
    end
    if vim.fn.filereadable(store.settings_file()) == 1 then
        health.ok("settings: " .. store.settings_file())
    else
        health.info("settings: none saved yet (" .. store.settings_file() .. ")")
    end

    -- highlight cache writability
    local cache_dir = vim.fn.stdpath("cache")
    if vim.fn.isdirectory(cache_dir) == 1 and vim.fn.filewritable(cache_dir) == 2 then
        health.ok(("highlight cache directory is writable (%s)"):format(cache_dir))
    else
        health.warn(("cache directory not writable (%s) — set cache = false"):format(cache_dir))
    end

    -- plugin group selection (all / auto-detected / manual)
    if config.plugins and config.plugins.all then
        health.ok("plugin groups: all (every known integration is themed)")
    elseif config.plugins and config.plugins.auto then
        local installed = groups.installed()
        local detected = {}
        for plugin, group in pairs(groups.plugins) do
            if installed[plugin] then
                detected[#detected + 1] = group
            end
        end
        table.sort(detected)
        if #detected > 0 then
            health.ok(("plugin groups: auto — %d detected (%s)"):format(#detected, table.concat(detected, ", ")))
        else
            health.info("plugin groups: auto — no installed integrations detected (only core groups themed)")
        end
    else
        health.info("plugin groups: manual (only groups you enabled + core)")
    end

    local active = vim.g.colors_name or "(none)"
    health.info(
        ("version=%s  active=%s  theme=%s"):format(
            config.version,
            active,
            state.opts and "applied" or "not applied yet"
        )
    )
end

return M
