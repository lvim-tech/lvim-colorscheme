-- lvim-colorscheme.extra: generate matching theme files for external tools.
-- Loads each lvim style, hands the palette to the per-tool generator in `extra/<group>/<tool>.lua`,
-- and writes the result under `extras/`. `M.extras` is the tool registry (ext / url / label);
-- `generate_themes([tool])` regenerates all tools (or one); `generate_gowall()` emits the
-- gowall palette config. Invoked by `scripts/build` / `scripts/build_gowall`.
--
---@module "lvim-colorscheme.extra"

local util = require("lvim-colorscheme.util")

local M = {}

-- Style key → capitalised style name used in the generated file names / theme labels.
local styles = {
    base_soft = "BaseSoft",
    base_dark = "BaseDark",
    base_darker = "BaseDarker",
    base_light = "BaseLight",
    kanagawa_soft = "KanagawaSoft",
    kanagawa_dark = "KanagawaDark",
    kanagawa_darker = "KanagawaDarker",
    kanagawa_light = "KanagawaLight",
    gruvbox_soft = "GruvboxSoft",
    gruvbox_dark = "GruvboxDark",
    gruvbox_darker = "GruvboxDarker",
    gruvbox_light = "GruvboxLight",
    everforest_soft = "EverforestSoft",
    everforest_dark = "EverforestDark",
    everforest_darker = "EverforestDarker",
    everforest_light = "EverforestLight",
    catppuccin_soft = "CatppuccinSoft",
    catppuccin_dark = "CatppuccinDark",
    catppuccin_darker = "CatppuccinDarker",
    catppuccin_light = "CatppuccinLight",
    tokyonight_soft = "TokyonightSoft",
    tokyonight_dark = "TokyonightDark",
    tokyonight_darker = "TokyonightDarker",
    tokyonight_light = "TokyonightLight",
    nord_soft = "NordSoft",
    nord_dark = "NordDark",
    nord_darker = "NordDarker",
    nord_light = "NordLight",
    dracula_soft = "DraculaSoft",
    dracula_dark = "DraculaDark",
    dracula_darker = "DraculaDarker",
    dracula_light = "DraculaLight",
    rosepine_soft = "RosepineSoft",
    rosepine_dark = "RosepineDark",
    rosepine_darker = "RosepineDarker",
    rosepine_light = "RosepineLight",
    material_soft = "MaterialSoft",
    material_dark = "MaterialDark",
    material_darker = "MaterialDarker",
    material_light = "MaterialLight",
    solarized_soft = "SolarizedSoft",
    solarized_dark = "SolarizedDark",
    solarized_darker = "SolarizedDarker",
    solarized_light = "SolarizedLight",
    nightfox_soft = "NightfoxSoft",
    nightfox_dark = "NightfoxDark",
    nightfox_darker = "NightfoxDarker",
    nightfox_light = "NightfoxLight",
}

-- map of plugin name to plugin extension
--- `group` is the SOURCE folder of the generator (extra/<group>/<tool>.lua); it does NOT
--- affect the OUTPUT path, which stays extras/<tool>/ — the registry references those by
--- raw URL in hundreds of places and moving them would break every one.
--- @type table<string, {ext:string, url:string, label:string, group?:string, subdir?: string, sep?:string}>
-- stylua: ignore
M.extras = {
  atuin           = { ext = "toml", url = "https://github.com/atuinsh/atuin", label = "Atuin", group = "shell" },
  bat             = { ext = "tmTheme", url = "https://github.com/sharkdp/bat", label = "Bat", group = "text" },
  clipack         = { ext = "yaml", url = "https://github.com/lvim-tech/clipack", label = "Clipack", group = "misc" },
  delta           = { ext = "gitconfig", url = "https://github.com/dandavison/delta", label = "Delta", group = "git" },
  dunst           = { ext = "conf", url = "https://github.com/dunst-project/dunst", label = "Dunst", group = "desktop" },
  eza             = { ext = "yml", url = "https://github.com/eza-community/eza", label = "Eza", group = "files" },
  fsel            = { ext = "toml", url = "https://github.com/Mjoyufull/fsel", label = "Fsel", group = "desktop" },
  fzf             = { ext = "sh", url = "https://github.com/junegunn/fzf", label = "Fzf", group = "shell" },
  kitty           = { ext = "conf", url = "https://sw.kovidgoyal.net/kitty/conf.html", label = "Kitty", group = "terminals" },
  lazydocker      = { ext = "yml", url = "https://github.com/jesseduffield/lazydocker", label = "Lazydocker", group = "containers" },
  lazygit         = { ext = "yml", url = "https://github.com/jesseduffield/lazygit", label = "Lazygit", group = "git" },
  neomutt         = { ext = "conf", url = "https://github.com/neomutt/neomutt", label = "Neomutt", group = "misc" },
  qtile           = { ext = "py", url = "https://github.com/qtile/qtile", label = "Qtile", group = "desktop" },
  mango           = { ext = "conf", url = "https://github.com/DreamMaoMao/mango", label = "Mango", group = "desktop" },
  hyprland        = { ext = "conf", url = "https://hypr.land", label = "Hyprland", group = "desktop" },
  niri            = { ext = "kdl", url = "https://github.com/YaLTeR/niri", label = "Niri", group = "desktop" },
  qutebrowser     = { ext = "py", url = "https://github.com/qutebrowser/qutebrowser", label = "Qutebrowser", group = "desktop" },
  rofi            = { ext = "rasi", url = "https://github.com/davatorium/rofi", label = "Rofi", group = "desktop" },
  starship        = { ext = "toml", url = "https://starship.rs", label = "Starship", group = "shell" },
  tmux            = { ext = "conf", url = "https://github.com/tmux/tmux/wiki", label = "Tmux", group = "shell" },
  vivid           = { ext = "yml", url = "https://github.com/sharkdp/vivid", label = "Vivid", group = "shell" },
  waybar          = { ext = "css", url = "https://github.com/Alexays/Waybar", label = "Waybar", group = "desktop" },
  xresources      = { ext = "Xresources", url = "https://wiki.archlinux.org/title/X_resources", label = "Xresources", group = "desktop" },
  yazi            = { ext = "toml", url = "https://github.com/sxyazi/yazi", label = "Yazi", group = "files" },
  wezterm         = { ext = "toml", url = "https://wezfurlong.org/wezterm", label = "WezTerm", group = "terminals" },
  alacritty       = { ext = "toml", url = "https://github.com/alacritty/alacritty", label = "Alacritty", group = "terminals" },
  ghostty         = { ext = "conf", url = "https://ghostty.org", label = "Ghostty", group = "terminals" },
  zed             = { ext = "json", url = "https://zed.dev", label = "Zed", group = "editors" },
  helix           = { ext = "toml", url = "https://helix-editor.com", label = "Helix", group = "editors" },
  bottom          = { ext = "toml", url = "https://github.com/ClementTsang/bottom", label = "Bottom", group = "system" },
  bru             = { ext = "css", url = "https://github.com/lvim-tech/bru", label = "Bru", group = "desktop" },
  broot           = { ext = "hjson", url = "https://github.com/Canop/broot", label = "Broot", group = "files" },
  btop            = { ext = "theme", url = "https://github.com/aristocratos/btop", label = "Btop", group = "system" },
  fastfetch       = { ext = "jsonc", url = "https://github.com/fastfetch-cli/fastfetch", label = "Fastfetch", group = "system" },
  gdu             = { ext = "yaml", url = "https://github.com/dundee/gdu", label = "Gdu", group = "files" },
  gitui           = { ext = "ron", url = "https://github.com/gitui-org/gitui", label = "Gitui", group = "git" },
  glow            = { ext = "json", url = "https://github.com/charmbracelet/glow", label = "Glow", group = "text" },
  jq              = { ext = "sh", url = "https://github.com/jqlang/jq", label = "Jq", group = "text" },
  k9s             = { ext = "yaml", url = "https://github.com/derailed/k9s", label = "K9s", group = "containers" },
  lsd             = { ext = "yaml", url = "https://github.com/lsd-rs/lsd", label = "Lsd", group = "files" },
  miller          = { ext = "sh", url = "https://github.com/johnkerl/miller", label = "Miller", group = "text" },
  navi            = { ext = "yaml", url = "https://github.com/denisidoro/navi", label = "Navi", group = "misc" },
  nushell         = { ext = "nu", url = "https://www.nushell.sh", label = "Nushell", group = "shell" },
  procs           = { ext = "toml", url = "https://github.com/dalance/procs", label = "Procs", group = "system" },
  ripgrep         = { ext = "conf", url = "https://github.com/BurntSushi/ripgrep", label = "Ripgrep", group = "files" },
  tealdeer        = { ext = "toml", url = "https://github.com/tealdeer-rs/tealdeer", label = "Tealdeer", group = "misc" },
  termusic        = { ext = "yml", url = "https://github.com/tramhao/termusic", label = "Termusic", group = "media" },
  trippy          = { ext = "toml", url = "https://github.com/fujiapple852/trippy", label = "Trippy", group = "network" },
  xplr            = { ext = "lua", url = "https://github.com/sayanarijit/xplr", label = "Xplr", group = "files" },
  zellij          = { ext = "kdl", url = "https://github.com/zellij-org/zellij", label = "Zellij", group = "shell" },
}

--- Regenerate the `extras/` theme files for every tool, or just `only` when given.
---@param only? string  a single tool name from M.extras
function M.generate_themes(only)
    local lvim_colorscheme = require("lvim-colorscheme")
    vim.o.background = "dark"

    -- map of style to style name

    ---@type string[]
    local names = only and { only } or vim.tbl_keys(M.extras)
    table.sort(names)

    local function capitalize_first_letter(str)
        return (str:gsub("^%l", string.upper))
    end

    for _, extra in ipairs(names) do
        local info = M.extras[extra]
        if not info then
            error("unknown extras tool: " .. tostring(extra))
        end
        local plugin = require("lvim-colorscheme.extra." .. (info.group and info.group .. "." or "") .. extra)
        for style, style_name in pairs(styles) do
            local colors, groups, opts = lvim_colorscheme.load({ style = style, plugins = { all = true } })
            local fname = extra
                .. (info.subdir and "/" .. info.subdir .. "/" or "")
                .. "/Lvim"
                .. capitalize_first_letter(style)
                .. "."
                .. info.ext
            fname = string.gsub(fname, "%.$", "") -- remove trailing dot when no extension
            colors._style_name = "Lvim Colorscheme " .. style_name
            colors._name = "lvim_" .. style
            colors._style = style
            print("[write] " .. fname)
            util.write("extras/" .. fname, plugin.generate(colors, groups, opts))
        end
    end

    M.write_index()
end

--- The eleven colours a consumer may want to SHOW beside a theme name, in the
--- order they read best: backgrounds, then the accents around the wheel.
---
--- Presentation only. Nothing configures a program from these — every tool gets
--- a file generated in its own format — so a consumer that draws them is not
--- holding a palette, it is holding a picture of one.
local SWATCH = { "bg", "fg", "red", "orange", "yellow", "green", "teal", "cyan", "blue", "purple", "magenta" }

--- Write extras/themes.txt: one line per theme, `name` then its swatch.
---
---     LvimEverforest_dark #232929 #5a6158 #cb4f4f …
---
--- The list exists so a consumer can learn which themes there are without
--- listing a directory through the GitHub API — one raw URL, no rate limit, and
--- no arbitrary choice of which tool's directory to count. themer reads exactly
--- this; it used to carry its own copy of all 48 palettes for the same purpose,
--- and that copy went stale by two colours without either side noticing.
---
--- The swatch rides along on the same line rather than in a second file: it is
--- wanted at exactly the moment the names are, and one fetch cannot half-fail.
---
--- Written on every generate_themes run, including a single-tool one, because
--- the names come from the style table rather than from what was just emitted.
---@return nil
function M.write_index()
    local lvim_colorscheme = require("lvim-colorscheme")

    ---@type string[]
    local lines = {}
    for style, _ in pairs(styles) do
        local colors = lvim_colorscheme.load({ style = style, plugins = { all = true } })
        local parts = { "Lvim" .. (style:gsub("^%l", string.upper)) }
        for _, key in ipairs(SWATCH) do
            table.insert(parts, colors[key])
        end
        table.insert(lines, table.concat(parts, " "))
    end
    table.sort(lines)
    print("[write] themes.txt")
    util.write("extras/themes.txt", table.concat(lines, "\n") .. "\n")
end

--- Emit the gowall palette config (`extras/gowall/config.yml`) from every lvim style.
---@return string config_content
function M.generate_gowall()
    local lvim_colorscheme = require("lvim-colorscheme")

    -- Generate yaml content
    local themes_yaml = "themes:\n"

    -- Sorted, so regenerating does not reshuffle the file: `styles` is a hash and pairs() has no
    -- defined order, which made every run produce a different diff.
    local style_keys = vim.tbl_keys(styles)
    table.sort(style_keys)

    for _, style in ipairs(style_keys) do
        -- Load the style colors
        local colors = lvim_colorscheme.load({ style = style, plugins = { all = true } })

        -- Create theme entry. The name matches the generated file names in extras/ ("LvimNord_dark"),
        -- NOT the `styles` label ("LvimNordDark") — gowall is selected by this string, and having it
        -- differ from every other tool's spelling of the same theme is a trap.
        themes_yaml = themes_yaml .. '- name: "Lvim' .. (style:gsub("^%l", string.upper)) .. '"\n'
        themes_yaml = themes_yaml .. "  colors:\n"

        -- Add selected colors as a list based on the requested colors
        themes_yaml = themes_yaml .. '    - "' .. colors.bg_light .. '"\n' -- bg_light
        themes_yaml = themes_yaml .. '    - "' .. colors.bg_soft_light .. '"\n' -- bg_soft_light
        themes_yaml = themes_yaml .. '    - "' .. colors.bg .. '"\n' -- bg
        themes_yaml = themes_yaml .. '    - "' .. colors.bg_soft_dark .. '"\n' -- bg_soft_dark
        themes_yaml = themes_yaml .. '    - "' .. colors.bg_dark .. '"\n' -- bg_dark
        themes_yaml = themes_yaml .. '    - "' .. colors.bg_highlight .. '"\n' -- bg_highlight

        themes_yaml = themes_yaml .. '    - "' .. colors.fg_light .. '"\n' -- fg_light
        themes_yaml = themes_yaml .. '    - "' .. colors.fg_soft_light .. '"\n' -- fg_soft_light
        themes_yaml = themes_yaml .. '    - "' .. colors.fg .. '"\n' -- fg
        themes_yaml = themes_yaml .. '    - "' .. colors.fg_soft_dark .. '"\n' -- fg_soft_dark
        themes_yaml = themes_yaml .. '    - "' .. colors.fg_dark .. '"\n' -- fg_dark

        themes_yaml = themes_yaml .. '    - "' .. colors.comment .. '"\n' -- comment

        -- Include accent colors
        themes_yaml = themes_yaml .. '    - "' .. colors.blue .. '"\n' -- blue accent
        themes_yaml = themes_yaml .. '    - "' .. colors.cyan .. '"\n' -- cyan accent
        themes_yaml = themes_yaml .. '    - "' .. colors.green .. '"\n' -- green accent
        themes_yaml = themes_yaml .. '    - "' .. colors.orange .. '"\n' -- orange accent
        themes_yaml = themes_yaml .. '    - "' .. colors.purple .. '"\n' -- purple accent
        themes_yaml = themes_yaml .. '    - "' .. colors.red .. '"\n' -- red accent
        themes_yaml = themes_yaml .. '    - "' .. colors.yellow .. '"\n' -- yellow accent
        themes_yaml = themes_yaml .. "\n"
    end

    -- Themes only. gowall reads a single config.yml with no include
    -- mechanism, so the app settings this used to hardcode (preview backend,
    -- OutputFolder, ...) live with whoever assembles the final file — clipack's
    -- config.sh concatenates its settings.yml with this block. Shipping
    -- settings from here meant every regeneration overwrote them.
    local config_content = "# themes.yml — GENERATED, palettes only. Do not add settings here;\n"
        .. "# they belong in settings.yml next to this file, and config.sh joins the two.\n\n"
        .. themes_yaml

    -- Make sure directory exists
    local dir_path = "extras/gowall"
    os.execute("mkdir -p " .. dir_path)

    -- Write the file
    util.write(dir_path .. "/themes.yml", config_content)
    print("[write] extras/gowall/themes.yml")

    return config_content
end

return M
