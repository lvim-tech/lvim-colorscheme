-- lvim-colorscheme.groups: assemble the full highlight-group set for a palette.
-- Maps plugin names → group modules, picks which groups to build (all / lazy-detected /
-- manual), merges each group module's output, and caches the result on disk keyed by style +
-- a fingerprint of the colour-affecting inputs (palette, plugin set, version, dark_active).
--
---@module "lvim-colorscheme.groups"

local config = require("lvim-colorscheme.config")
local util = require("lvim-colorscheme.util")

local M = {}

-- stylua: ignore
M.plugins = {
  ["alpha-nvim"]                    = "alpha",
  ["betterTerm.nvim"]               = "better-term",
  ["blink.cmp"]                     = "blink",
  ["nvim-bqf"]                      = "bqf",
  ["nvim-cmp"]                      = "cmp",
  ["copilot.lua"]                   = "copilot",
  ["vim-ctrlspace"]                 = "ctrlspace",
  ["nvim-dap"]                      = "dap",
  ["dashboard-nvim"]                = "dashboard",
  ["diffview.nvim"]                 = "diffview",
  ["fidget.nvim"]                   = "fidget",
  ["flash.nvim"]                    = "flash",
  ["flutter-tools.nvim"]            = "flutter-tools",
  ["fzf-lua"]                       = "fzf",
  ["vim-gitgutter"]                 = "gitgutter",
  ["gitsigns.nvim"]                 = "gitsigns",
  ["grug-far.nvim"]                 = "grug-far",
  ["glance.nvim"]                   = "glance",
  ["nvim-hlslens"]                  = "hlslens",
  ["indent-blankline.nvim"]         = "indent-blankline",
  ["lazy.nvim"]                     = "lazy",
  ["nvim-lightbulb"]                = "lightbulb",
  ["markview.nvim"]                 = "markview",
  ["mason.nvim"]                    = "mason",
  ["mini.cursorword"]               = "mini_cursorword",
  ["mini.diff"]                     = "mini_diff",
  ["mini.files"]                    = "mini_files",
  ["nvim-navic"]                    = "navic",
  ["neo-tree.nvim"]                 = "neo-tree",
  ["neogit"]                        = "neogit",
  ["neotest"]                       = "neotest",
  ["noice.nvim"]                    = "noice",
  ["nomad"]                         = "nomad",
  ["nvim-notify"]                   = "notify",
  ["nui.nvim"]                      = "nui",
  ["outline.nvim"]                  = "outline",
  ["overseer.nvim"]                 = "overseer",
  ["package-info.nvim"]             = "package-info",
  ["pubspec-assist.nvim"]           = "pubspec-assist",
  ["quicker.nvim"]                  = "quicker",
  ["rainbow-delimiters.nvim"]       = "rainbow",
  ["render-markdown.nvim"]          = "render-markdown",
  ["rgflow.nvim"]                   = "rgflow",
  ["snacks.nvim"]                   = "snacks",
  ["time-machine.nvim"]             = "time-machine",
  ["nvim-treesitter-context"]       = "treesitter-context",
  ["trouble.nvim"]                  = "trouble",
  ["ui.nvim"]                       = "ui",
  ["vgit.nvim"]                     = "vgit",
  ["which-key.nvim"]                = "which-key",
}

--- Session memo of the last built highlight set per style. The picker's live preview re-enters
--- setup() for the same styles as the cursor scrubs; this skips the on-disk read + full JSON decode
--- for a style already built this session (disk stays the cross-session layer). Wiped whenever the
--- module is reloaded (M.reload drops it from package.loaded), so palette/version edits still rebuild.
---@type table<string, {groups: lvim-colorscheme.Highlights, inputs: table}>
local memo = {}

--- Lazy-load a single group module by short name (e.g. "base", "which-key").
---@param name string
---@return {get: lvim-colorscheme.HighlightsFn, url?: string}
function M.get_group(name)
    ---@type {get: lvim-colorscheme.HighlightsFn, url: string}
    return util.mod("lvim-colorscheme.groups." .. name)
end

--- The highlights a single named group contributes for the given palette + opts.
---@param name string
---@param colors ColorScheme
---@param opts lvim-colorscheme.Config
---@return lvim-colorscheme.Highlights
function M.get(name, colors, opts)
    local mod = M.get_group(name)
    return mod.get(colors, opts)
end

--- Build (or read from cache) the full merged highlight set for a palette + opts.
---@param colors ColorScheme
---@param opts lvim-colorscheme.Config
---@return lvim-colorscheme.Highlights groups, table<string, boolean> enabled
function M.setup(colors, opts)
    local groups = {
        base = true,
        lang = true,
        kinds = true,
        semantic_tokens = true,
        treesitter = true,
    }

    if opts.plugins.all then
        for _, group in pairs(M.plugins) do
            groups[group] = true
        end
    elseif opts.plugins.auto and package.loaded.lazy then
        local plugins = require("lazy.core.config").plugins
        for plugin, group in pairs(M.plugins) do
            if plugins[plugin] then
                groups[group] = true
            end
        end

        -- special case for mini.nvim
        if plugins["mini.nvim"] then
            for _, group in pairs(M.plugins) do
                if group:find("^mini_") then
                    groups[group] = true
                end
            end
        end
    end

    -- manually enable/disable plugins
    for plugin, group in pairs(M.plugins) do
        local use = opts.plugins[group]
        use = use == nil and opts.plugins[plugin] or use
        if use ~= nil then
            if type(use) == "table" then
                use = use.enabled
            end
            groups[group] = use or nil
        end
    end

    local names = vim.tbl_keys(groups)
    table.sort(names)

    -- `style` always resolves to a value here (config default "lvim_dark", set by config.extend
    -- before load), so it is a valid cache key string.
    local cache_key = opts.style --[[@as string]]
    -- Session memo first (no disk IO), then the on-disk cache. Both are validated by the same
    -- input-fingerprint deep_equal below, so a stale layer is simply rebuilt.
    local cache = opts.cache and (memo[cache_key] or util.cache.read(cache_key))

    local inputs = {
        colors = colors,
        plugins = names,
        version = config.version,
        -- `dark_active` (+ its amount) changes Normal's bg, so they are part of the cache
        -- fingerprint. `dim_inactive` (+ amount) is a runtime namespace overlay (does not change
        -- generated groups) → not fingerprinted.
        opts = {
            transparent = opts.transparent,
            styles = opts.styles,
            dark_active = opts.dark_active,
            dark_active_amount = opts.dark_active_amount,
        },
    }

    local ret = cache and vim.deep_equal(inputs, cache.inputs) and cache.groups

    if not ret then
        ret = {}
        -- merge highlights
        for group in pairs(groups) do
            for k, v in pairs(M.get(group, colors, opts)) do
                ret[k] = v
            end
        end
        util.resolve(ret)
        if opts.cache then
            util.cache.write(cache_key, { groups = ret, inputs = inputs })
        end
    end
    if opts.cache then
        memo[cache_key] = { groups = ret, inputs = inputs }
    end
    opts.on_highlights(ret, colors)

    return ret, groups
end

return M
