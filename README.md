# LVIM Colorscheme

A Neovim colorscheme written in Lua with 12 theme families, each available in four variants.

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://github.com/lvim-tech/lvim-colorscheme/blob/main/LICENSE)

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

### lazy.nvim

```lua
return {
    "lvim-tech/lvim-colorscheme",
    dependencies = { "lvim-tech/lvim-utils" },
    config = function()
        require("lvim-colorscheme").setup({ ... })
        vim.cmd("colorscheme lvim-dark")
    end,
}
```

### Native (vim.pack / packadd)

```lua
-- In your init.lua, after the plugin is on the runtimepath:
vim.pack.add({
    { src = "https://github.com/lvim-tech/lvim-utils" },
    { src = "https://github.com/lvim-tech/lvim-colorscheme" },
})

require("lvim-colorscheme").setup({ ... })
vim.cmd("colorscheme lvim-dark")
```

### packer.nvim

```lua
use({
    "lvim-tech/lvim-colorscheme",
    requires = { "lvim-tech/lvim-utils" },
    config = function()
        require("lvim-colorscheme").setup({ ... })
        vim.cmd("colorscheme lvim-dark")
    end,
})
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
        -- sidebars = "dark",  -- "dark" | "transparent" | "normal"
        -- floats   = "dark",
    },

    -- Brightness for light variants (0.0 = dull, 1.0 = vibrant)
    day_brightness = 0.3,

    -- Mute the foreground of non-focused windows (background stays uniform; transparent-safe)
    dim_inactive = false,

    -- Give the focused window a slightly darker background (independent of dim_inactive)
    dark_active = false,

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
        -- Load all plugin groups (default when lazy.nvim is not detected)
        all = package.loaded.lazy == nil,
        -- Auto-detect installed plugins via lazy.nvim
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

## Public API

### Live color access

```lua
local lcs = require("lvim-colorscheme")

local colors = lcs.colors -- ColorScheme | nil
local opts = lcs.opts -- Config | nil
```

`lcs.colors` always reflects the currently active theme — no caching on the caller side needed.

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
