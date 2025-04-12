local util = require("lvim-colorscheme.util")

local M = {}

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

function M.setup()
    local lvim_colorscheme = require("lvim-colorscheme")
    vim.o.background = "dark"

    -- map of style to style name
    local styles = {
        darker = " Darker",
        dark = " Dark",
        light = " Light",
        kanagawa = " Kanagawa",
        gruvbox = " Gruvbox",
        everforest = " Everforest",
    }

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

return M
