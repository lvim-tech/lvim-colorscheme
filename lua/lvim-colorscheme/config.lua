local M = {}

local defaults = {
    style = "",
    light_style = "light",
    transparent = false,
    terminal_colors = true,
    styles = {
        comments = { italic = true, bold = true },
        keywords = { italic = true, bold = true },
        functions = { italic = true, bold = true },
        variables = {},
        sidebars = "dark",
        floats = "dark",
    },
    sidebars = {},
    light_brightness = 0.3,
    dim_inactive = false,
    on_colors = function(colors) end,
    on_highlights = function(highlights, colors) end,
    use_background = true,
}

M.options = {}

function M.setup(options)
    M.options = vim.tbl_deep_extend("force", {}, defaults, options or {})
end

function M.extend(options)
    M.options = vim.tbl_deep_extend("force", {}, M.options or defaults, options or {})
end

function M.is_light()
    return M.options.style == "light" or M.options.use_background and vim.o.background == "light"
end

M.setup()

return M
