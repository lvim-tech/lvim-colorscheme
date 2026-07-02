-- lvim-colorscheme.health: :checkhealth lvim-colorscheme.
-- Reports the Neovim version, 'termguicolors', whether lvim-utils (the floating picker) is
-- present, the highlight-cache writability, and the active theme / cache-fingerprint version.
--
---@module "lvim-colorscheme.health"

local config = require("lvim-colorscheme.config")
local state = require("lvim-colorscheme.state")

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

    -- lvim-utils is only needed for the floating theme picker (:LvimColorscheme).
    if pcall(require, "lvim-utils.ui") then
        health.ok("lvim-utils found — the floating theme picker is available")
    else
        health.info("lvim-utils not found — :LvimColorscheme falls back to vim.ui.select")
    end

    -- highlight cache writability
    local cache_dir = vim.fn.stdpath("cache")
    if vim.fn.isdirectory(cache_dir) == 1 and vim.fn.filewritable(cache_dir) == 2 then
        health.ok(("highlight cache directory is writable (%s)"):format(cache_dir))
    else
        health.warn(("cache directory not writable (%s) — set cache = false"):format(cache_dir))
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
