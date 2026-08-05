-- lvim-colorscheme.config: the live configuration table.
-- Holds the defaults; setup() merges user overrides into it IN PLACE via
-- lvim-utils.utils.merge, so every require("lvim-colorscheme.config") reader sees the
-- effective values directly (config.<field>) — no defaults/options split. `version` is a
-- config field because it is part of the highlight-cache fingerprint (groups/init.lua):
-- bump it whenever the generated highlights change so on-disk caches regenerate.
--
---@module "lvim-colorscheme.config"

local utils = require("lvim-utils.utils")

---@class lvim-colorscheme.Config
---@field version? string   Cache-fingerprint version (bump on any generated-highlight change)
---@field style? string   Active dark-background style (e.g. "base_dark")
---@field light_style? string   Style used when `vim.o.background` is "light"
---@field auto_background? boolean   Reload style/light_style automatically on a background flip
---@field remember? boolean   Self-manage theme persistence (restore + apply on setup, save on commit)
---@field transparent? boolean   Drop the editor background (see-through terminal)
---@field terminal_colors? boolean   Set the `:terminal` ANSI colours from the palette
---@field comment_saturation? number   Floor for the comment colour's saturation (hsluv S; 0 = off)
---@field cursor_accent? string|false   Palette key for the cursor block (false = the foreground)
---@field cursorline_contrast? number   The cursor line's wash, as a contrast ratio over the background
---@field terminal? { contrast?: number, dim_contrast?: number, bright_dim?: number, block_min?: number }   Contrast floors for the EXPORTED terminal palette
---@field picker? { live_chrome?: boolean, width?: number, tab_icon?: string }
---@field settings_panel? { command?: string, layout?: string }   The runtime settings panel: `command` = the user command that opens it, `layout` = how it opens ("float"|"area"|"bottom")
---@field styles? table   Per-syntax-group attr tables + sidebars/floats background style
---@field sidebar_filetypes? string[]   Filetypes treated as sidebars (Normal:NormalSB)
---@field day_brightness? number   0..1 vibrancy of the light ("day") style
---@field dim_inactive? boolean   Mute the foreground of non-focused windows
---@field dim_inactive_amount? number   0..1 strength of dim_inactive
---@field dark_active? boolean   Darken the focused window's background toward black
---@field dark_active_amount? number   0..1 strength of dark_active
---@field on_colors? fun(colors: ColorScheme)
---@field on_highlights? fun(highlights: lvim-colorscheme.Highlights, colors: ColorScheme)
---@field cache? boolean   Cache the generated highlights on disk for faster loads
---@field plugins? table<string, boolean|{enabled:boolean}>
---@field dim_active? boolean  Deprecated back-compat alias for `dark_active` (mapped in setup)
---@field _preview? boolean  Internal: lightweight live-preview load (skips hi clear + User autocmd)

--- The config MODULE table: the live config (all Config fields) plus its setup/extend helpers.
--- Readers `require("lvim-colorscheme.config")` and access effective values as `config.<field>`.
---@class lvim-colorscheme.ConfigModule: lvim-colorscheme.Config
---@field setup? fun(options?: lvim-colorscheme.Config)
---@field extend? fun(opts?: lvim-colorscheme.Config): lvim-colorscheme.Config

---@type lvim-colorscheme.ConfigModule
local M = {
    version = "1.1.25",
    style = "base_dark",
    -- When true, lvim-colorscheme REMEMBERS the active theme itself: `setup()` restores and
    -- applies the last committed theme, and every committed change is persisted — to the settings
    -- document AND a plain mirror file readable before the plugin loads. Lets a host drop its own
    -- `colorscheme <name>` apply + persistence.
    remember = false,
    light_style = "base_light", -- The theme is used when the background is set to light
    auto_background = false, -- Reload `style`/`light_style` automatically when `vim.o.background` changes
    transparent = false, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    -- Contrast floors for the palette handed to TERMINALS (the `extras/` themes and `:terminal`).
    -- A terminal palette is not an editor palette: the editor `fg` is tuned against one background
    -- under syntax highlighting, and several palettes here keep it muted enough to read at ~2:1 on
    -- their own background — fine for code, unusable once a TUI paints text on a coloured block.
    --
    -- `contrast` is a DIAL between the theme's character and that block. Dim text is unaffected by it:
    -- ANSI 8 is derived on its own floor and stays ~3:1 at any setting. Raising `contrast` only buys
    -- readability for text sitting ON an ANSI 8 block, and spends the palette's mood for it —
    -- 4.5 keeps almost all the character but leaves such a block at 1.5:1; 9 makes the block 3:1 and
    -- washes the foreground out to a near-neutral. 6 keeps the palette's tint while lifting the
    -- foreground clear of its own background.
    -- Every palette already gives its COMMENT the theme's own hue — kanagawa violet, everforest green,
    -- gruvbox warm — but the saturation each author chose ranges from 5.8 to 34.7, a six-fold spread, so
    -- on some themes the tint is there in the numbers and invisible on screen. This is a FLOOR: palettes
    -- already above it are untouched, the washed-out ones are lifted to it. Saturation moves at constant
    -- lightness in hsluv, so contrast is unchanged (measured: kanagawa 2.05:1 -> 2.03:1). 0 disables.
    comment_saturation = 22,
    -- The cursor block's colour, as a PALETTE KEY. It used to be `fg` — the editor's muted foreground —
    -- so the cursor was the least theme-coloured thing on screen, while the TERMINAL export has always
    -- given it an accent (`cursor ${green}` in every terminal theme). Same accent here, so the block reads
    -- the same in the editor and in a `:terminal`. Any palette key works ("blue", "orange", …); set false
    -- to go back to the foreground.
    cursor_accent = "green",
    -- The cursor line's wash, as a contrast ratio over the background rather than a blend factor — a fixed
    -- blend lands somewhere different in every palette (this one came out at 1.01:1, barely visible).
    cursorline_contrast = 1.2,
    terminal = {
        contrast = 6, -- floor for `terminal.foreground` against the terminal background
        -- ANSI 8 is FIRST a block background. Measured against a real consumer: a TUI that paints its
        -- prompt block with ANSI 8 and writes on it in a fixed colour of its own (#55556d) that no palette
        -- controls — so the closer ANSI 8 sits to the background, the better that text reads, and the more
        -- the block looks like the translucent tint it is meant to be. Pushed away it becomes a glaring
        -- band with text at 1.16:1. It is ALSO dim text (a shell autosuggestion), which wants the opposite;
        -- that consumer is configurable on its own, a block background is not, so the block wins here.
        dim_contrast = 1.08,
        -- How far ANSI 15 ("bright white") sits BELOW the terminal foreground, in hsluv lightness points.
        -- ANSI 15 is what a TUI writes on a coloured block with, so dimming it is what makes such a block
        -- read as a quote rather than as ordinary text. `block_min` is the real bound: the dim is reduced
        -- automatically if it would push the text on that block below this contrast. ANSI 7 is derived a
        -- step below 15, so the 7 < 15 ordering holds however far this goes.
        bright_dim = 20,
        block_min = 2.5, -- floor for ANSI 15 on ANSI 8 — the text on a block
    },
    picker = {
        -- During live preview: true (default) recolours the picker itself to each previewed
        -- theme too (full live preview); false keeps the picker's own colours stable while
        -- only the editor behind it previews.
        live_chrome = true,
        -- Fraction of the screen wide for the theme picker popup. (The `config` settings panel
        -- carries no width of its own and follows the shared lvim-ui geometry.)
        width = 0.9,
        -- The palette glyph on every theme-family tab in the picker.
        tab_icon = "󰏘",
    },
    -- The runtime settings panel (transparency / focus / syntax), built on lvim-ui. Its values are
    -- persisted in the plugin's own document, stdpath("data")/lvim-colorscheme/settings.json.
    settings_panel = {
        -- The user command that opens the settings panel (also reachable via `:LvimColorscheme config`).
        command = "LvimColorschemeConfig",
        -- How the panel opens: "float" (centred modal) | "area" (cmdline zone) | "bottom".
        layout = "float",
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
    -- own groups already get it). EMPTY by default — the theme makes no assumption about which
    -- panels you run; add your own panels' filetypes from your config's `setup()`.
    sidebar_filetypes = {},
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
        -- Theme EVERY known plugin group unconditionally, whether or not it is installed.
        -- Leave false and rely on `auto`; set true only to force the complete set.
        all = false,
        -- Auto-detect installed plugins and theme only those. Manager-agnostic: reads native
        -- `vim.pack` (the lvim-installer default) and lazy.nvim when present.
        auto = true,
    },
}

--- Merge user `options` into the live config IN PLACE (via lvim-utils.utils.merge), so every
--- `require("lvim-colorscheme.config")` reader immediately sees the effective values.
---@param options? lvim-colorscheme.Config
function M.setup(options)
    options = options or {}
    -- Back-compat: the original `dim_active` darkened the FOCUSED window — that is exactly
    -- what `dark_active` now does, so map the old key onto it when the new one isn't supplied.
    if options.dim_active ~= nil and options.dark_active == nil then
        options.dark_active = options.dim_active
    end
    options.dim_active = nil
    utils.merge(M, options)
end

--- The live config overlaid with per-call `opts`, WITHOUT mutating the live table. Used by the
--- load path (theme/colors) so a single `load({ style = … })` (or the picker's `_preview`) takes
--- effect for that apply only. Returns the live config itself when there is nothing to overlay.
---@param opts? lvim-colorscheme.Config
---@return lvim-colorscheme.Config
function M.extend(opts)
    return opts and vim.tbl_deep_extend("force", {}, M, opts) or M
end

return M
