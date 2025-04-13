local util = require("lvim-colorscheme.util")

local M = {}

local styles = {
    darker = "Darker",
    dark = "Dark",
    light = "Light",
    kanagawa = "Kanagawa",
    gruvbox = "Gruvbox",
    everforest = "Everforest",
}

-- map of plugin name to plugin extension
--- @type table<string, {ext:string, url:string, label:string, subdir?: string, sep?:string}>
-- stylua: ignore
M.extras = {
  bat             = { ext = "tmTheme", url = "https://github.com/sharkdp/bat", label = "Bat" },
  delta           = { ext = "gitconfig", url = "https://github.com/dandavison/delta", label = "Delta" },
  fzf             = { ext = "sh", url = "https://github.com/junegunn/fzf", label = "Fzf" },
  kitty           = { ext = "conf", url = "https://sw.kovidgoyal.net/kitty/conf.html", label = "Kitty" },
  lazydocker      = { ext = "yml", url = "https://github.com/jesseduffield/lazydocker", label = "Lazydocker" },
  lazygit         = { ext = "yml", url = "https://github.com/jesseduffield/lazygit", label = "Lazygit" },
  neomutt         = { ext = "conf", url = "https://github.com/neomutt/neomutt", label = "Neomutt" },
  qtile           = { ext = "py", url = "https://github.com/qtile/qtile", label = "Qtile" },
  qutebrowser     = { ext = "py", url = "https://github.com/qutebrowser/qutebrowser", label = "Qtile" },
  starship        = { ext = "toml", url = "https://starship.rs", label = "Starship" },
  tmux            = { ext = "conf", url = "https://github.com/tmux/tmux/wiki", label = "Tmux" },
  vivid           = { ext = "yml", url = "https://github.com/sharkdp/vivid", label = "Vivid" },
  xresources      = { ext = "Xresources", url = "https://wiki.archlinux.org/title/X_resources", label = "Xresources" },
  yazi            = { ext = "toml", url = "https://github.com/sxyazi/yazi", label = "Yazi" },
}

function M.generate_themes()
    local lvim_colorscheme = require("lvim-colorscheme")
    vim.o.background = "dark"

    -- map of style to style name

    ---@type string[]
    local names = vim.tbl_keys(M.extras)
    table.sort(names)

    local function capitalize_first_letter(str)
        return (str:gsub("^%l", string.upper))
    end

    for _, extra in ipairs(names) do
        local info = M.extras[extra]
        local plugin = require("lvim-colorscheme.extra." .. extra)
        for style, style_name in pairs(styles) do
            local colors, groups, opts = lvim_colorscheme.load({ style = style, plugins = { all = true } })
            local fname = extra
                .. (info.subdir and "/" .. info.subdir .. "/" or "")
                .. "/Lvim"
                .. capitalize_first_letter(style)
                .. "."
                .. info.ext
            fname = string.gsub(fname, "%.$", "") -- remove trailing dot when no extension
            colors._style_name = "Lvim Colorsheme" .. style_name
            colors._name = "lvim_" .. style
            colors._style = style
            print("[write] " .. fname)
            util.write("extras/" .. fname, plugin.generate(colors, groups, opts))
        end
    end
end

function M.generate_gowall()
    local lvim_colorscheme = require("lvim-colorscheme")

    -- Generate yaml content
    local themes_yaml = "themes:\n"

    for style, style_name in pairs(styles) do
        -- Load the style colors
        local colors = lvim_colorscheme.load({ style = style, plugins = { all = true } })

        -- Create theme entry
        themes_yaml = themes_yaml .. '- name: "Lvim' .. style_name .. '"\n'
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

    -- Final config content
    local config_content = [[
EnableImagePreviewing: true
InlineImagePreview: true
ImagePreviewBackend: "chafa"

OutputFolder: "MyImages"
ColorCorrectionBackend: nn

]] .. themes_yaml

    -- Make sure directory exists
    local dir_path = "extras/gowall"
    os.execute("mkdir -p " .. dir_path)

    -- Write the file
    util.write(dir_path .. "/config.yml", config_content)
    print("[write] extras/gowall/config.yml")

    return config_content
end

return M
