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

### Lvim family

| Variant | Style name | Command |
|---------|-----------|---------|
| Soft    | `lvim_soft`   | `:colorscheme lvim-soft`   |
| Dark    | `lvim_dark`   | `:colorscheme lvim-dark`   |
| Darker  | `lvim_darker` | `:colorscheme lvim-darker` |
| Light   | `lvim_light`  | `:colorscheme lvim-light`  |

### Kanagawa family

| Variant | Style name | Command |
|---------|-----------|---------|
| Soft    | `kanagawa_lighter` | `:colorscheme lvim-kanagawa-lighter` |
| Dark    | `kanagawa`         | `:colorscheme lvim-kanagawa`         |
| Darker  | `kanagawa_darker`  | `:colorscheme lvim-kanagawa-darker`  |
| Light   | `kanagawa_light`   | `:colorscheme lvim-kanagawa-light`   |

### Gruvbox family

| Variant | Style name | Command |
|---------|-----------|---------|
| Soft    | `gruvbox_lighter` | `:colorscheme lvim-gruvbox-lighter` |
| Dark    | `gruvbox`         | `:colorscheme lvim-gruvbox`         |
| Darker  | `gruvbox_darker`  | `:colorscheme lvim-gruvbox-darker`  |
| Light   | `gruvbox_light`   | `:colorscheme lvim-gruvbox-light`   |

### Everforest family

| Variant | Style name | Command |
|---------|-----------|---------|
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
    config = function()
        require("lvim-colorscheme").setup({
            style = "lvim_dark",
        })
        vim.cmd("colorscheme lvim-dark")
    end,
}
```

---

## Setup

```lua
require("lvim-colorscheme").setup({
    -- Active style. See theme table above for all available style names.
    style = "lvim_dark",

    -- Style used when vim.o.background = "light"
    light_style = "lvim_light",

    -- Disable background (for transparent terminals)
    transparent = false,

    -- Set terminal colors (vim.g.terminal_color_*)
    terminal_colors = true,

    -- Syntax group styles
    styles = {
        comments   = { italic = true },
        keywords   = { italic = true },
        functions  = { italic = true },
        variables  = {},
        -- sidebars = "dark",  -- "dark" | "transparent" | "normal"
        -- floats   = "dark",
    },

    -- Brightness for light variants (0.0 = dull, 1.0 = vibrant)
    day_brightness = 0.3,

    -- Dim inactive windows
    dim_active = true,

    -- Bold section headers in lualine
    lualine_bold = false,

    -- Override colors before highlights are generated
    ---@param colors ColorScheme
    on_colors = function(colors) end,

    -- Override highlight groups after generation
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

```
:LvimColorscheme
```

Opens a floating panel organised by family. Navigate with `h`/`l` (tabs), `j`/`k` (items), `<CR>` to apply, `<Esc>` to cancel. The currently active theme is marked with `➤`.

---

## Public API

### Current colors

```lua
local lcs = require("lvim-colorscheme")

-- Always reflects the active theme (nil if lvim-colorscheme is not loaded)
local colors = lcs.colors  -- ColorScheme
local opts   = lcs.opts    -- Config
```

### Callback on load

```lua
require("lvim-colorscheme").on_colors(function(colors, opts)
    -- Called after every colorscheme load, before the User autocmd.
    local bg   = colors.bg
    local blue = colors.blue
end)
```

### User autocmd

```lua
vim.api.nvim_create_autocmd("User", {
    pattern  = "LvimColorscheme",
    callback = function()
        local colors = require("lvim-colorscheme").colors
        -- colors are fully applied at this point
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

Generated configuration files for external tools are located in `extras/`.

| Tool | Format |
|------|--------|
| Kitty | `.conf` |
| Tmux | `.conf` |
| Alacritty / Wezterm | (via Xresources) |
| Starship | `.toml` |
| Lazygit | `.yml` |
| Lazydocker | `.yml` |
| Delta | `.gitconfig` |
| Bat | `.tmTheme` |
| Fzf | `.sh` |
| Yazi | `.toml` |
| Vivid | `.yml` |
| Waybar | `.css` |
| Neomutt | `.conf` |
| Qtile | `.py` |
| Qutebrowser | `.py` |
| Xresources | `.Xresources` |

Each tool has one file per style (16 total).

To regenerate after modifying a palette:

```lua
require("lvim-colorscheme.extra").generate_themes()
```
