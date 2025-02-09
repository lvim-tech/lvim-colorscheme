local config = require("lvim-colorscheme.config")
local util = require("lvim-colorscheme.util")

local M = {}

-- stylua: ignore
M.plugins = {
  ["alpha-nvim"]                    = "alpha",
  ["blink.cmp"]                     = "blink",
  ["nvim-bqf"]                      = "bqf",
  ["nvim-cmp"]                      = "cmp",
  ["vim-ctrlspace"]                 = "ctrlspace",
  ["nvim-dap"]                      = "dap",
  ["dashboard-nvim"]                = "dashboard",
  ["diffview.nvim"]                 = "diffview",
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
  ["lvim-ui-config"]                = "lvim",
  ["mason.nvim"]                    = "mason",
  ["mini.cursorword"]               = "mini_cursorword",
  ["mini.files"]                    = "mini_files",
  ["nvim-navic"]                    = "navic",
  ["neo-tree.nvim"]                 = "neo-tree",
  ["neogit"]                        = "neogit",
  ["noice.nvim"]                    = "noice",
  ["nvim-notify"]                   = "notify",
  ["nui.nvim"]                      = "nui",
  ["outline.nvim"]                  = "outline",
  ["package-info.nvim"]             = "package-info",
  ["pubspec-assist.nvim"]           = "pubspec-assist",
  ["quicker.nvim"]                  = "quicker",
  ["rainbow-delimiters.nvim"]       = "rainbow",
  ["render-markdown.nvim"]          = "render-markdown",
  ["rgflow.nvim"]                   = "rgflow",
  ["snacks.nvim"]                   = "snacks",
  ["nvim-treesitter-context"]       = "treesitter-context",
  ["trouble.nvim"]                  = "trouble",
  ["vgit.nvim"]                     = "vgit",
  ["which-key.nvim"]                = "which-key",
}

local me = debug.getinfo(1, "S").source:sub(2)
me = vim.fn.fnamemodify(me, ":h")

function M.get_group(name)
    ---@type {get: lvim-colorscheme.HighlightsFn, url: string}
    return util.mod("lvim-colorscheme.groups." .. name)
end

---@param colors ColorScheme
---@param opts lvim-colorscheme.Config
function M.get(name, colors, opts)
    local mod = M.get_group(name)
    return mod.get(colors, opts)
end

---@param colors ColorScheme
---@param opts lvim-colorscheme.Config
function M.setup(colors, opts)
    local groups = {
        base = true,
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

    local cache_key = opts.style
    local cache = opts.cache and util.cache.read(cache_key)

    local inputs = {
        colors = colors,
        plugins = names,
        version = config.version,
        opts = { transparent = opts.transparent, styles = opts.styles, dim_inactive = opts.dim_active },
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
    opts.on_highlights(ret, colors)

    return ret, groups
end

return M
