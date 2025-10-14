local util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/MeanderingProgrammer/render-markdown.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    local ret = {
        RenderMarkdownBullet      = {fg = c.orange},
        RenderMarkdownCode        = { bg = c.bg_soft_dark },
        RenderMarkdownDash        = {fg = c.orange},
        RenderMarkdownTableHead   = { fg = c.red},
        RenderMarkdownTableRow    = { fg = c.orange},
        RenderMarkdownCodeInline  = "@markup.raw.markdown_inline"
    }
    for i, color in ipairs(c.rainbow) do
        ret["RenderMarkdownH" .. i .. "Bg"] = { bg = util.blend_bg(color, 0.1) }
        ret["RenderMarkdownH" .. i .. "Fg"] = { fg = color, bold = true }
    end
    return ret
end

return M
