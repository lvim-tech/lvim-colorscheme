# LVIM Colorscheme

A Neovim colorscheme written in Lua with 12 theme families, each available in four variants.

[![License: BSD-3-Clause](https://img.shields.io/badge/License-BSD--3--Clause-blue.svg)](https://github.com/lvim-tech/lvim-colorscheme/blob/main/LICENSE)

## Themes

Each family has four variants: **soft** (lighter dark), **dark** (base), **darker** (harder dark), **light**.

### Lvim

| Variant | Style name    | Colorscheme command        |
| ------- | ------------- | -------------------------- |
| Soft    | `lvim_soft`   | `:colorscheme lvim-soft`   |
| Dark    | `lvim_dark`   | `:colorscheme lvim-dark`   |
| Darker  | `lvim_darker` | `:colorscheme lvim-darker` |
| Light   | `lvim_light`  | `:colorscheme lvim-light`  |

### Kanagawa

| Variant | Style name        | Colorscheme command                 |
| ------- | ----------------- | ----------------------------------- |
| Soft    | `kanagawa_soft`   | `:colorscheme lvim-kanagawa-soft`   |
| Dark    | `kanagawa_dark`   | `:colorscheme lvim-kanagawa-dark`   |
| Darker  | `kanagawa_darker` | `:colorscheme lvim-kanagawa-darker` |
| Light   | `kanagawa_light`  | `:colorscheme lvim-kanagawa-light`  |

### Gruvbox

| Variant | Style name       | Colorscheme command                |
| ------- | ---------------- | ---------------------------------- |
| Soft    | `gruvbox_soft`   | `:colorscheme lvim-gruvbox-soft`   |
| Dark    | `gruvbox_dark`   | `:colorscheme lvim-gruvbox-dark`   |
| Darker  | `gruvbox_darker` | `:colorscheme lvim-gruvbox-darker` |
| Light   | `gruvbox_light`  | `:colorscheme lvim-gruvbox-light`  |

### Everforest

| Variant | Style name          | Colorscheme command                   |
| ------- | ------------------- | ------------------------------------- |
| Soft    | `everforest_soft`   | `:colorscheme lvim-everforest-soft`   |
| Dark    | `everforest_dark`   | `:colorscheme lvim-everforest-dark`   |
| Darker  | `everforest_darker` | `:colorscheme lvim-everforest-darker` |
| Light   | `everforest_light`  | `:colorscheme lvim-everforest-light`  |

### Catppuccin

| Variant | Style name          | Colorscheme command                   |
| ------- | ------------------- | ------------------------------------- |
| Soft    | `catppuccin_soft`   | `:colorscheme lvim-catppuccin-soft`   |
| Dark    | `catppuccin_dark`   | `:colorscheme lvim-catppuccin-dark`   |
| Darker  | `catppuccin_darker` | `:colorscheme lvim-catppuccin-darker` |
| Light   | `catppuccin_light`  | `:colorscheme lvim-catppuccin-light`  |

### Tokyo Night

| Variant | Style name          | Colorscheme command                   |
| ------- | ------------------- | ------------------------------------- |
| Soft    | `tokyonight_soft`   | `:colorscheme lvim-tokyonight-soft`   |
| Dark    | `tokyonight_dark`   | `:colorscheme lvim-tokyonight-dark`   |
| Darker  | `tokyonight_darker` | `:colorscheme lvim-tokyonight-darker` |
| Light   | `tokyonight_light`  | `:colorscheme lvim-tokyonight-light`  |

### Nord

| Variant | Style name    | Colorscheme command             |
| ------- | ------------- | ------------------------------- |
| Soft    | `nord_soft`   | `:colorscheme lvim-nord-soft`   |
| Dark    | `nord_dark`   | `:colorscheme lvim-nord-dark`   |
| Darker  | `nord_darker` | `:colorscheme lvim-nord-darker` |
| Light   | `nord_light`  | `:colorscheme lvim-nord-light`  |

### Dracula

| Variant | Style name       | Colorscheme command                |
| ------- | ---------------- | ---------------------------------- |
| Soft    | `dracula_soft`   | `:colorscheme lvim-dracula-soft`   |
| Dark    | `dracula_dark`   | `:colorscheme lvim-dracula-dark`   |
| Darker  | `dracula_darker` | `:colorscheme lvim-dracula-darker` |
| Light   | `dracula_light`  | `:colorscheme lvim-dracula-light`  |

### Rosé Pine

| Variant | Style name        | Colorscheme command                 |
| ------- | ----------------- | ----------------------------------- |
| Soft    | `rosepine_soft`   | `:colorscheme lvim-rosepine-soft`   |
| Dark    | `rosepine_dark`   | `:colorscheme lvim-rosepine-dark`   |
| Darker  | `rosepine_darker` | `:colorscheme lvim-rosepine-darker` |
| Light   | `rosepine_light`  | `:colorscheme lvim-rosepine-light`  |

### Material

| Variant | Style name        | Colorscheme command                 |
| ------- | ----------------- | ----------------------------------- |
| Soft    | `material_soft`   | `:colorscheme lvim-material-soft`   |
| Dark    | `material_dark`   | `:colorscheme lvim-material-dark`   |
| Darker  | `material_darker` | `:colorscheme lvim-material-darker` |
| Light   | `material_light`  | `:colorscheme lvim-material-light`  |

### Solarized

| Variant | Style name         | Colorscheme command                  |
| ------- | ------------------ | ------------------------------------ |
| Soft    | `solarized_soft`   | `:colorscheme lvim-solarized-soft`   |
| Dark    | `solarized_dark`   | `:colorscheme lvim-solarized-dark`   |
| Darker  | `solarized_darker` | `:colorscheme lvim-solarized-darker` |
| Light   | `solarized_light`  | `:colorscheme lvim-solarized-light`  |

### Nightfox

| Variant | Style name        | Colorscheme command                 |
| ------- | ----------------- | ----------------------------------- |
| Soft    | `nightfox_soft`   | `:colorscheme lvim-nightfox-soft`   |
| Dark    | `nightfox_dark`   | `:colorscheme lvim-nightfox-dark`   |
| Darker  | `nightfox_darker` | `:colorscheme lvim-nightfox-darker` |
| Light   | `nightfox_light`  | `:colorscheme lvim-nightfox-light`  |

---

## Installation

Requires Neovim >= 0.10, [lvim-utils](https://github.com/lvim-tech/lvim-utils) (for the floating
theme picker — falls back to `vim.ui.select` without it), and
[lvim-control-center](https://github.com/lvim-tech/lvim-control-center) (which hosts the settings
panel in its own database).

### lvim-installer (recommended)

Install and manage it from the LVIM package manager — open the **Plugins** tab and install / update / pin it:

```vim
:LvimInstaller plugins
```

lvim-installer installs plugins through Neovim's built-in `vim.pack`, so no external plugin manager is needed.

### Native (vim.pack)

```lua
vim.pack.add({
    { src = "https://github.com/lvim-tech/lvim-utils" },
    { src = "https://github.com/lvim-tech/lvim-control-center" },
    { src = "https://github.com/lvim-tech/lvim-colorscheme" },
})

require("lvim-colorscheme").setup({ ... })
vim.cmd("colorscheme lvim-dark")
```

---

## Setup

```lua
require("lvim-colorscheme").setup({
    -- Active style — see style names in the theme tables above
    style = "lvim_dark",

    -- Style used when vim.o.background = "light"
    light_style = "lvim_light",

    -- Reload style/light_style automatically when vim.o.background changes
    auto_background = false,

    -- Self-manage theme persistence. When true, setup() restores and applies the last
    -- committed theme, and every committed change is saved — to the settings panel's own
    -- control-center database AND a plain mirror file (stdpath("data")/lvim-colorscheme/theme)
    -- readable before the plugin loads. Lets a distribution drop its own `colorscheme <name>`
    -- apply + persistence. `style` above is the first-run default, used until a theme is picked.
    remember = false,

    -- The runtime settings panel — hosted by lvim-control-center in its own database.
    settings_panel = {
        command = "LvimColorschemeConfig", -- the user command that opens the panel
        save = nil, -- database directory; nil → stdpath("data")/lvim-colorscheme
    },

    -- Theme picker behaviour
    picker = {
        -- true: the picker recolors to each previewed theme too (full live preview);
        -- false: picker keeps its own colors while only the editor previews
        live_chrome = true,
    },

    -- Disable background color (for transparent terminals)
    transparent = false,

    -- Set terminal colors (vim.g.terminal_color_*)
    terminal_colors = true,

    -- Syntax group styles
    styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { italic = true },
        variables = {},
        -- Sidebar / float background: "dark" (darker panel) | "normal" (editor bg) |
        -- "transparent". AUTHORITATIVE — an explicit value overrides the global `transparent`
        -- (so `transparent = true` + `sidebars = "normal"` keeps an OPAQUE sidebar).
        -- sidebars = "dark",
        -- floats   = "dark",
    },

    -- Filetypes treated as sidebars (get the sidebar background via a Normal:NormalSB winhl).
    -- Empty by default; add the filetypes of your left/right panels that don't theme themselves.
    sidebar_filetypes = {},

    -- Brightness for light variants (0.0 = dull, 1.0 = vibrant)
    day_brightness = 0.3,

    -- Mute the foreground of non-focused windows (background stays uniform; transparent-safe)
    dim_inactive = false,

    -- Strength of dim_inactive: 0..1 fraction toward the background (0 = none, 1 = invisible)
    dim_inactive_amount = 0.4,

    -- Darken the focused window's background toward black (independent of dim_inactive)
    dark_active = false,

    -- How much dark_active darkens: 0..1 fraction toward black (0 = none, 1 = black)
    dark_active_amount = 0.2,

    -- Override palette colors before highlights are generated
    ---@param colors ColorScheme
    on_colors = function(colors) end,

    -- Override highlight groups after they are generated
    ---@param highlights table
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors) end,

    -- Cache computed highlights to disk for faster startup
    cache = true,

    -- Plugin highlight groups
    plugins = {
        -- Theme every known plugin group unconditionally (installed or not)
        all = false,
        -- Auto-detect installed plugins and theme only those. Manager-agnostic:
        -- reads the native vim.pack registry (the lvim-installer default), plus any
        -- other plugin-manager provider that happens to be present.
        auto = true,
    },
})
```

---

## Theme picker

```vim
:LvimColorscheme
```

Opens a floating panel organised by family (via [lvim-utils](https://github.com/lvim-tech/lvim-utils)),
with **live preview** — the theme applies as you move between variants and is restored if
you cancel. The currently active theme is marked with `➤`. When lvim-utils is not installed
it falls back to `vim.ui.select`, so there is no hard dependency.

| Key           | Action                            |
| ------------- | --------------------------------- |
| `h` / `l`     | Switch family tab                 |
| `j` / `k`     | Move between variants (previewed) |
| `<CR>`        | Apply theme                       |
| `<Esc>` / `q` | Close, restoring the previous     |

---

## Settings panel

```vim
:LvimColorschemeConfig
```

A panel (tabs **Background · Focus · Syntax**) to toggle the runtime options — transparency,
sidebar/float style, `dim_inactive` / `dark_active` (with their strength), syntax italics,
terminal colors, day brightness and more. Each change applies **live** and is **persisted**,
so it survives a restart.

The panel is hosted by **[lvim-control-center](https://github.com/lvim-tech/lvim-control-center)**
(a required dependency) as its OWN instance with its OWN database — separate from every other
control center. Both the command that opens it and the database directory are configurable:

```lua
require("lvim-colorscheme").setup({
    settings_panel = {
        command = "LvimColorschemeConfig", -- the user command that opens the panel
        save = nil, -- database directory; nil → stdpath("data")/lvim-colorscheme
    },
})
```

control-center registers the command (`:LvimColorschemeConfig` by default); `:LvimColorscheme`
stays the theme picker. `setup()` is called once and restores the saved values on top of your
config (the store wins).

With `remember = true`, the **active theme** is persisted the same way (in the panel's database,
under the `colorscheme` key) plus a plain mirror file `stdpath("data")/lvim-colorscheme/theme`.
The mirror is what `setup()` reads to restore the theme — it is readable before any database
(e.g. a bootstrap/installer painting itself before plugins load).

---

## Reload

```vim
:LvimColorscheme reload
```

Re-applies the active theme **live**, without restarting Neovim. It drops the active style's
highlight cache and reloads the generated `groups` / `colors` / `theme` modules, so edits to a
palette or highlight group (or a `version` bump) take effect immediately — handy while tuning a
theme. Your runtime options and any `on_colors` listeners are preserved, so other plugins that
re-theme themselves keep their bindings. A notification confirms the rebuild.

> Edits to `config.lua` itself (runtime option defaults) still need a restart, since reloading it
> would discard your live merged options. `cache-reload` is accepted as an alias.

Equivalent API: `require("lvim-colorscheme").reload()` (returns `false` when no lvim theme is active).

---

## Public API

### Live color access

```lua
local lcs = require("lvim-colorscheme")

local colors = lcs.colors -- ColorScheme | nil
local opts = lcs.opts -- Config | nil
```

`lcs.colors` always reflects the currently active theme — no caching on the caller side needed.

### Runtime functions

```lua
local lcs = require("lvim-colorscheme")

-- Every colorscheme name, in family/variant order (the values accepted by `:colorscheme`).
-- Build dropdowns from this so they never go stale when new families are added.
local names = lcs.colorschemes() -- string[], e.g. { "lvim-dark", ..., "lvim-everforest-soft", ... }

-- The active colorscheme name (dash form), or nil when no lvim theme is active.
local active = lcs.current() -- string | nil

-- Change option(s) at runtime and re-apply the active theme immediately. Merged into the
-- live config; never switches the active theme, only its rendering.
lcs.set({ transparent = true, dim_inactive = true, dark_active = true })

-- Open the runtime settings panel (same as `:LvimColorschemeConfig`).
lcs.config_panel()
```

### Callback on load

Fired after every colorscheme load, before the `User LvimColorscheme` autocmd.

```lua
require("lvim-colorscheme").on_colors(function(colors, opts)
    local bg = colors.bg
    local blue = colors.blue
end)
```

### User autocmd

Use this when you want to react to theme changes without a hard dependency on the module.

```lua
vim.api.nvim_create_autocmd("User", {
    pattern = "LvimColorscheme",
    callback = function()
        local colors = require("lvim-colorscheme").colors
    end,
})
```

---

## Color overrides

```lua
require("lvim-colorscheme").setup({
    on_colors = function(colors)
        colors.blue = "#89b4fa"
        colors.red = "#f38ba8"
    end,
    on_highlights = function(hl, colors)
        hl.Comment = { fg = colors.comment, italic = false }
    end,
})
```

---

## Extras

Generated configuration files for external tools, located in `extras/`.
Each tool has one file per style (48 styles total).

| Tool        | Format        |
| ----------- | ------------- |
| Bat         | `.tmTheme`    |
| Delta       | `.gitconfig`  |
| Fzf         | `.sh`         |
| Kitty       | `.conf`       |
| WezTerm     | `.toml`       |
| Alacritty   | `.toml`       |
| Ghostty     | `.conf`       |
| Lazydocker  | `.yml`        |
| Lazygit     | `.yml`        |
| Neomutt     | `.conf`       |
| Qtile       | `.py`         |
| Qutebrowser | `.py`         |
| Starship    | `.toml`       |
| Tmux        | `.conf`       |
| Vivid       | `.yml`        |
| Waybar      | `.css`        |
| Xresources  | `.Xresources` |
| Yazi        | `.toml`       |
| Zed         | `.json`       |
| Helix       | `.toml`       |

Regenerate the extras after modifying a palette:

```vim
:LvimColorscheme extras          " all tools
:LvimColorscheme extras kitty    " a single tool
```
