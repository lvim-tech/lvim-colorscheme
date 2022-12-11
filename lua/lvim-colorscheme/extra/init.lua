package.path = "./lua/?/init.lua;./lua/?.lua"

local config = require("lvim-colorscheme.config")

local function write(str, fileName)
    print("[write] extra/" .. fileName)
    local file = io.open("extras/" .. fileName, "w")
    file:write(str)
    file:close()
end

local extras = {
    alacritty = "yml",
    kitty = "conf",
    tmux = "tmux",
    wezterm = "lua",
    xresources = "Xresources",
    lazygit = "yml",
    fzf = "txt",
    bat = "tmTheme",
}

local themes = {
    "dark",
    "dark_soft",
    "light",
}

for extra, ext in pairs(extras) do
    local plugin = require("lvim-colorscheme.extra." .. extra)
    config = config or require("lvim-colorscheme.config")
    for _, theme in pairs(themes) do
        local colors = require("lvim-colorscheme.colors." .. theme)
        local fname = extra .. "_" .. theme .. "-lvim-colorscheme" .. "." .. ext
        write(plugin.generate(colors), fname)
    end
end
