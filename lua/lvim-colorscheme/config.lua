local M = {}

M.version = "1.1.9"

---@class lvim-colorscheme.Config
---@field on_colors? fun(colors: ColorScheme)
---@field on_highlights? fun(highlights: lvim-colorscheme.Highlights, colors: ColorScheme)
---@field remember? boolean  Self-manage theme persistence (restore + apply on setup, save on commit)
---@field _preview? boolean  Internal: lightweight live-preview load (skips hi clear + User autocmd)
M.defaults = {
    style = "lvim_dark",
    -- When true, lvim-colorscheme REMEMBERS the active theme itself: `setup()` restores and
    -- applies the last committed theme, and every committed change is persisted — to the store
    -- (the control-center DB when present, else the JSON file) AND a plain mirror file readable
    -- before the plugin loads. Lets a host drop its own `colorscheme <name>` apply + persistence.
    remember = false,
    light_style = "lvim_light", -- The theme is used when the background is set to light
    auto_background = false, -- Reload `style`/`light_style` automatically when `vim.o.background` changes
    transparent = false, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    picker = {
        -- During live preview: true (default) recolours the picker itself to each previewed
        -- theme too (full live preview); false keeps the picker's own colours stable while
        -- only the editor behind it previews.
        live_chrome = true,
        -- Fraction of the screen wide for BOTH colorscheme popups (the theme picker + the `config` settings panel).
        width = 0.9,
        -- The palette glyph on every theme-family tab in the picker.
        tab_icon = "󰏘",
    },
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = { italic = true },
        variables = {},
        -- Background style for sidebars / floating windows: "dark", "transparent" or "normal".
        -- AUTHORITATIVE — an explicit value wins over the global `transparent` (so
        -- `transparent = true` + `sidebars = "normal"` keeps an OPAQUE sidebar). Left unset,
        -- they follow `transparent`.
        -- sidebars = "dark",
        -- floats = "dark",
    },
    -- Filetypes whose windows are treated as SIDEBARS: a `Normal:NormalSB` winhighlight is
    -- applied so they take the sidebar background (which follows `styles.sidebars`). Use this
    -- for left/right panels that don't theme themselves (file trees / outlines that ship their
    -- own groups already get it). Add your panels' filetypes here.
    sidebar_filetypes = {
        "help",
        "qf",
        "man",
        "checkhealth",
        "lspinfo",
        "undotree",
        "aerial",
        "Outline",
        "spectre_panel",
        "dbui",
    },
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    -- These two are INDEPENDENT (use either, both, or neither):
    -- `dim_inactive` mutes the FOREGROUND of non-focused windows (the background stays
    -- uniform, so it works under `transparent`); applied via a window-local namespace.
    dim_inactive = false,
    -- How strongly `dim_inactive` mutes the foreground: a 0..1 fraction blended toward the
    -- background — 0 = no dimming, 1 = fully invisible. Default 0.4.
    dim_inactive_amount = 0.4,
    -- `dark_active` darkens the FOCUSED window's background (toward black). Note: under a
    -- translucent terminal a darker bg shows more through — pair with an opaque terminal for a
    -- true "darker active".
    dark_active = false,
    -- How much darker `dark_active` makes the focused window: a 0..1 fraction toward black
    -- (0 = no change, 1 = black). Default 0.2.
    dark_active_amount = 0.2,

    --- You can override specific color groups to use other groups or a hex color.
    --- Called with a ColorScheme table (signature on the `lvim-colorscheme.Config` class).
    on_colors = function() end,

    --- You can override specific highlights to use other groups or a hex color.
    --- Called with a Highlights and ColorScheme table (signature on the Config class).
    on_highlights = function() end,

    cache = true, -- When set to true, the theme will be cached for better performance

    ---@type table<string, boolean|{enabled:boolean}>
    plugins = {
        -- enable all plugins when not using lazy.nvim
        -- set to false to manually enable/disable plugins
        all = package.loaded.lazy == nil,
        -- uses your plugin manager to automatically enable needed plugins
        -- currently only lazy.nvim is supported
        auto = true,
    },
}

---@type lvim-colorscheme.Config
M.options = nil

---@param options? lvim-colorscheme.Config
function M.setup(options)
    options = vim.tbl_deep_extend("force", {}, options or {})
    -- Back-compat: the original `dim_active` darkened the FOCUSED window — that is exactly
    -- what `dark_active` now does, so map the old key onto it when the new one isn't supplied.
    if options.dim_active ~= nil and options.dark_active == nil then
        options.dark_active = options.dim_active
    end
    options.dim_active = nil
    M.options = vim.tbl_deep_extend("force", {}, M.defaults, options)
end

---@param opts? lvim-colorscheme.Config
function M.extend(opts)
    return opts and vim.tbl_deep_extend("force", {}, M.options, opts) or M.options
end

setmetatable(M, {
    __index = function(_, k)
        if k == "options" then
            return M.defaults
        end
    end,
})

return M
