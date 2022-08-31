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
}

for extra, ext in pairs(extras) do
    local plugin = require("lvim-colorscheme.extra." .. extra)
    config = config or require("lvim-colorscheme.config")
    local colors = require("lvim-colorscheme.colors").setup(config)
    local fname = extra .. "_lvim-colorscheme" .. "." .. ext
    write(plugin.generate(colors), fname)
end
