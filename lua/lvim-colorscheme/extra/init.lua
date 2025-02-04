local util = require("lvim-colorscheme.util")

local M = {}

-- map of plugin name to plugin extension
--- @type table<string, {ext:string, url:string, label:string, subdir?: string, sep?:string}>
-- stylua: ignore
M.extras = {
  bat            = { ext = "tmTheme", url = "https://github.com/sharkdp/bat", label = "Bat" },
  delta            = { ext = "gitconfig", url = "https://github.com/dandavison/delta", label = "Delta" },
  kitty            = { ext = "conf", url = "https://sw.kovidgoyal.net/kitty/conf.html", label = "Kitty" },
}

function M.setup()
    local lvim_colorscheme = require("lvim-colorscheme")
    vim.o.background = "dark"

    -- map of style to style name
    local styles = {
        darker = " Darker",
        dark = "",
        light = " Light",
    }

    ---@type string[]
    local names = vim.tbl_keys(M.extras)
    table.sort(names)

    for _, extra in ipairs(names) do
        local info = M.extras[extra]
        local plugin = require("lvim-colorscheme.extra." .. extra)
        for style, style_name in pairs(styles) do
            local colors, groups, opts = lvim_colorscheme.load({ style = style, plugins = { all = true } })
            local fname = extra
                .. (info.subdir and "/" .. info.subdir .. "/" or "")
                .. "/lvim"
                .. (info.sep or "_")
                .. style
                .. "."
                .. info.ext
            fname = string.gsub(fname, "%.$", "") -- remove trailing dot when no extension
            colors["_style_name"] = "Lvim Colorsheme" .. style_name
            colors["_name"] = "lvim_" .. style
            colors["_style"] = style
            print("[write] " .. fname)
            util.write("extras/" .. fname, plugin.generate(colors, groups, opts))
        end
    end
end

return M
