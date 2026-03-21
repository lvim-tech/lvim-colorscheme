# LVIM Colorscheme

A Neovim colorscheme written in Lua with multiple theme families, each available in four variants.

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://github.com/lvim-tech/lvim-colorscheme/blob/main/LICENSE)

## Screenshots

![LVIM Colorscheme](https://github.com/lvim-tech/lvim-colorscheme/blob/main/media/lvim-colorscheme-screenshot_01.png)
![LVIM Colorscheme](https://github.com/lvim-tech/lvim-colorscheme/blob/main/media/lvim-colorscheme-screenshot_02.png)
![LVIM Colorscheme](https://github.com/lvim-tech/lvim-colorscheme/blob/main/media/lvim-colorscheme-screenshot_03.png)
![LVIM Colorscheme](https://github.com/lvim-tech/lvim-colorscheme/blob/main/media/lvim-colorscheme-screenshot_04.png)

---

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

---

## Installation

### lazy.nvim

```lua
{
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
use {
    "lvim-tech/lvim-colorscheme",
    requires = { "lvim-tech/lvim-utils" },
    config = function()
        require("lvim-colorscheme").setup({ ... })
        vim.cmd("colorscheme lvim-dark")
    end,
}
```

---

## Setup

```lua
require("lvim-colorscheme").setup({
    -- Active style — see style names in the theme tables above
    style = "lvim_dark",

    -- Style used when vim.o.background = "light"
    light_style = "lvim_light",

    -- Disable background color (for transparent terminals)
    transparent = false,

    -- Set terminal colors (vim.g.terminal_color_*)
    terminal_colors = true,

    -- Syntax group styles
    styles = {
        comments  = { italic = true },
        keywords  = { italic = true },
        functions = { italic = true },
        variables = {},
        -- sidebars = "dark",  -- "dark" | "transparent" | "normal"
        -- floats   = "dark",
    },

    -- Brightness for light variants (0.0 = dull, 1.0 = vibrant)
    day_brightness = 0.3,

    -- Dim inactive windows
    dim_active = true,

    -- Bold section headers in lualine
    lualine_bold = false,

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

Requires [lvim-utils](https://github.com/lvim-tech/lvim-utils).

```vim
:LvimColorscheme
```

Opens a floating panel organised by family. The currently active theme is marked with `➤`.

| Key           | Action                |
| ------------- | --------------------- |
| `h` / `l`     | Switch family tab     |
| `j` / `k`     | Move between variants |
| `<CR>`        | Apply theme           |
| `<Esc>` / `q` | Close without changes |

---

## Public API

### Live color access

```lua
local lcs = require("lvim-colorscheme")

local colors = lcs.colors  -- ColorScheme | nil
local opts   = lcs.opts    -- Config | nil
```

`lcs.colors` always reflects the currently active theme — no caching on the caller side needed.

### Callback on load

Fired after every colorscheme load, before the `User LvimColorscheme` autocmd.

```lua
require("lvim-colorscheme").on_colors(function(colors, opts)
    local bg   = colors.bg
    local blue = colors.blue
end)
```

### User autocmd

Use this when you want to react to theme changes without a hard dependency on the module.

```lua
vim.api.nvim_create_autocmd("User", {
    pattern  = "LvimColorscheme",
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
        colors.red  = "#f38ba8"
    end,
    on_highlights = function(hl, colors)
        hl.Comment = { fg = colors.comment, italic = false }
    end,
})
```

---

## Extras

Generated configuration files for external tools, located in `extras/`.
Each tool has one file per style (16 styles total).

| Tool        | Format        |
| ----------- | ------------- |
| Bat         | `.tmTheme`    |
| Delta       | `.gitconfig`  |
| Fzf         | `.sh`         |
| Kitty       | `.conf`       |
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

To regenerate all extras after modifying a palette:

```vim
:lua require("lvim-colorscheme.extra").generate_themes()
```
